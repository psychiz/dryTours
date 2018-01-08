// Derived from: https://github.com/3lvis/Sync/tree/master/iOSDemo
import CoreData
import Sync
import SwiftyJSON
import Alamofire
import os.log

class Fetcher {
    private let persistentContainer: NSPersistentContainer

    init() {
        let modelName = "Mobility"
        self.persistentContainer = NSPersistentContainer(name: modelName)
        let containerURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        let storeURL = containerURL.appendingPathComponent("\(modelName).sqlite")

        do {
            try self.persistentContainer.persistentStoreCoordinator.addPersistentStore(
                ofType: NSSQLiteStoreType,
                configurationName: nil,
                at: storeURL,
                options: nil)
            
            // Sync can happen in diffent contexts, merge latest data so see updates immediately.
            // Not having this will cause refresh in table views to not show until disposing and recreating view
            self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true

        } catch {
            os_log("Unable to setup persistent store.", type: .error)
        }

        os_log("Core Data save path: %@", type: .debug, storeURL.absoluteString)
    }
    
    func fetchLocalTechnician() -> Technician? {
        let request: NSFetchRequest<Technician> = Technician.fetchRequest()
      
        var technician: Technician?
        
        do {
             let technicians = try self.persistentContainer.viewContext.fetch(request)
            print(technicians.count)
            technician = technicians.first
        } catch {
            os_log("Unable to get technician.", type: .error)
        }

        return technician
    }
    
    
    func deleteLocalTechnician() -> Technician? {
        let request: NSFetchRequest<Technician> = Technician.fetchRequest()
        
        var technician: Technician?
        
        do {
            let technicians = try self.persistentContainer.viewContext.fetch(request)
            print(technicians.count)
            
            for result in technicians {
               
                self.persistentContainer.viewContext.delete(result)
                
            }
            
          //  technician = technicians.first
        } catch {
            os_log("Unable to get technician.", type: .error)
        }
        
        return technician
    }
    
    
    
    
    func fetchLocalTours() -> [Tour] {
        let request: NSFetchRequest<Tour> = Tour.fetchRequest()
        var tours: [Tour] = []
        
        do {
            tours = try self.persistentContainer.viewContext.fetch(request)
        } catch {
            os_log("Unable to get tours.", type: .error)
        }
        
        return tours
    }
    
    func fetchRemoteTechnician(completion: @escaping (_ result: VoidResult) -> Void) {
        SessionService.whoami {result in
            switch result {
            case .success(let response):
                let entityName = Technician.entity().name!
                let resultJSON = self.convertResponseToSyncEntity(response)

                self.persistentContainer.sync(resultJSON, inEntityNamed: entityName) { error in
                    if error == nil {
                        completion(.success(response))
                    } else {
                        completion(.failure(error!))
                    }
                }
            case .failure(let error):
                completion(.failure(error as NSError))
            }
        }
    }
    
    
    
    func fetchRemoteTours(completion: @escaping (_ result: VoidResult) -> Void) {
        ToursService.tours {result in
            switch result {
            case .success(let response):
                let entityName = Tour.entity().name!
                let responseObject = response as? [String: Any]
                let reponseItems = responseObject!["member"]
                let syncItem = reponseItems as? [[String: Any]]
                
                self.persistentContainer.sync(syncItem!, inEntityNamed: entityName) { error in
                    if error == nil {
                        completion(.success(response))
                    } else {
                        completion(.failure(error!))
                    }
                }
            case .failure(let error):
                completion(.failure(error as NSError))
            }
        }
    }
    
    func getRemoteTourById(tourId: String, completion: @escaping (_ result: VoidResult) -> Void) {
        ToursService.getTourById(tourId: tourId) { result in
            switch result {
            case .success(let response):
                let entityName = Tour.entity().name ?? "Tour"
                let syncItem = self.convertResponseToSyncEntity(response)
                let predicate = NSPredicate(format: "stationid == %@", tourId)
                
                self.persistentContainer.sync(syncItem, inEntityNamed: entityName, predicate: predicate) { error in
                    if error == nil {
                        completion(.success(response))
                    } else {
                        completion(.failure(error!))
                    }
                }
            case .failure(let error):
                completion(.failure(error as NSError))
            }
        }
    }
    
    // note: only handling object and array responses from server.
    // handles responses as objects or arrays, sync() requires array to be passed in.
    // wraps objects in array, and leaves array of objects as is.
    fileprivate func convertResponseToSyncEntity(_ response: (Any?)) -> [[String: Any]] {
        let jsonObjectResponse = response as? [String: Any]
        let jsonArrayResponse = response as? [[String: Any]]
        let syncEntity = jsonObjectResponse != nil ? [jsonObjectResponse!] : jsonArrayResponse!
        
        return syncEntity
    }
}
