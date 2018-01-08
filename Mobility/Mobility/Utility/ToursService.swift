import Foundation
import Alamofire

class ToursService {
    static func tours(completion: @escaping (_ result: VoidResult) -> Void) {
        let endpoint = "\(SessionService.endpoint)/tours"
    
        Alamofire.request(endpoint).validate().responseJSON { response in
            if response.result.isSuccess {
                completion(.success(response.result.value))
            } else if response.error != nil {
                let maximoError = NetworkHelpers.transformMaximoServerError(response: response)
                completion(.failure(maximoError))
            } else {
                fatalError("No error, no failure")
            }
        }
    }
    
    static func getTourById(tourId: String, completion: @escaping (_ result: VoidResult) -> Void) {
        var url = URL(string: SessionService.endpoint)
        url?.appendPathComponent("/tours/\(tourId)")
        let endpoint = url?.absoluteString ?? "bad url set"
        
        Alamofire.request(endpoint).validate().responseJSON { response in
            if response.result.isSuccess {
                completion(.success(response.result.value))
            } else if response.error != nil {
                let maximoError = NetworkHelpers.transformMaximoServerError(response: response)
                completion(.failure(maximoError))
            } else {
                fatalError("No error, no failure")
            }
        }
    }
}
