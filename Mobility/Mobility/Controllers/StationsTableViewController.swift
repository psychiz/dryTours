import UIKit
import os.log

class StationsTableViewController: UITableViewController {
    
    // MARK: Properties
    var stationReadings: [TourStationReading] = [TourStationReading]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadTour()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        switch segue.identifier ?? "" {
        case "AddConditionalReport":
            os_log("Adding a new conditional report.", log: OSLog.default, type: .debug)
        case "unwindToAppsViewController":
            os_log("Loging Back in.", log: OSLog.default, type: .debug)
        case "ShowStation":
            let tabBarController = segue.destination as? UITabBarController
            let navigationController = tabBarController?.viewControllers![0] as? UINavigationController
            let stationDetailViewController = navigationController?.topViewController as? StationDetailViewController

            guard stationDetailViewController != nil else {
                fatalError("Unexpected destination: \(segue.destination)")
            }

            guard let selectedStationCell = sender as? StationTableViewCell else {
                fatalError("Unexpected sender: \(sender ?? "")")
            }

            guard let indexPath = self.tableView.indexPath(for: selectedStationCell) else {
                fatalError("The selected cell is not being displayed in the table.")
            }
            
            let selectedStationReading = stationReadings[indexPath.row]
            stationDetailViewController?.stationReading = selectedStationReading
        default:
            fatalError("Unexpected segue identifier: \(segue.identifier ?? "")")
        }
    }

    // MARK: Actions
    @IBAction func unwindToToursTable(sender: UIStoryboardSegue) {

    }
    
    @IBAction func cancelToStationsViewController(_ segue: UIStoryboardSegue) {
        // placeholder, do nothing
    }
    
    @IBAction func saveStationDetail(_ segue: UIStoryboardSegue) {
        guard let stationViewController = segue.source as? StationDetailViewController,
            let stationReading = stationViewController.stationReading else {
                return
        }
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            // tour.stationReadings[selectedIndexPath.row] = stationReading
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        }
    }

    // MARK: Private Methods
    private func loadTour() {
        // note: convert stations to Core Data, REST API based.
        let photo1 = UIImage(named: "station1")
        let photo2 = UIImage(named: "station2")
        let photo3 = UIImage(named: "station3")
        
        let reading1 = TourStationReading(
            station: Station(name: "Station 1", photo: photo1!, formula: "2 + $x"),
            stationValue: StationValue(reading: nil),
            timeOfReading: nil)
        let reading2 = TourStationReading(
            station: Station(name: "Station 2", photo: photo2!, formula: "5 * $x"),
            stationValue: StationValue(reading: nil),
            timeOfReading: nil)
        let reading3 = TourStationReading(
            station: Station(name: "Station 3", photo: photo3!, formula: "$x < 50"),
            stationValue: StationValue(reading: nil),
            timeOfReading: nil)
        
        stationReadings = [reading1, reading2, reading3]
    }
    
}

// MARK: - Table View
extension StationsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationReadings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "StationTableViewCell"     // matches name of cell in storyboard
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? StationTableViewCell else {
            fatalError("The dequeued cell is not an instance of \(cellIdentifier).")
        }
        let stationReading = stationReadings[indexPath.row]
        
        cell.nameLabel.text = stationReading.station?.name
        cell.stationReadingLabel.text = stationReading.stationValue?.reading
        
        return cell
    }
}
