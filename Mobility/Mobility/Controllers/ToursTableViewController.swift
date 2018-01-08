import UIKit
import os.log

class ToursTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    // MARK: Properties
    var tours = [Tour]()
    private var fetcher: Fetcher = ((UIApplication.shared.delegate as? AppDelegate)?.fetcher)!
    
    @IBOutlet weak var toursTableView: UITableView!
    private enum Constants {
        static let cellIdentifier = "ToursTableViewCell"
    }
      override func viewDidLoad()
      {
         super.viewDidLoad()
        
        
     }
    @IBAction func downloadAllTours(_ sender: Any)
    {
    
    loadViewData()
    
    }
    
    
    
    // MARK: Actions
    @IBAction func refreshView(_ sender: UIRefreshControl) {
        loadViewData()
    }
    @IBAction func refreshViewButton(_ sender: UIBarButtonItem) {
        //self.refreshControl?.beginRefreshing()
        loadViewData()
    }
    
    private func loadViewData() {
        let tours = self.fetcher.fetchLocalTours()
        self.tours = TourLogic.getRecentTours(tours: tours)
        self.toursTableView.reloadData()
        self.refreshToursData()
    }
    
    private func refreshToursData() {
        self.fetcher.fetchRemoteTours {result in
            switch result {
            case .success:
                self.tours = TourLogic.getRecentTours(tours: self.tours)
                self.toursTableView.reloadData()
            case .failure(let error):
                Helpers.showErrorToast(view: self.view, message: error.localizedDescription)
            }

           // self.refreshControl?.endRefreshing()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! ToursTableViewCell
        let tour = tours[indexPath.row]
        let startTime = tour.startDate?.toDateTime() ?? "None"
        cell.tourName.text = tour.stationid
        cell.tourDetail.text = tour.tourDescription
       
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        super.prepare(for: segue, sender: sender)
        
        guard let tourDetailController = segue.destination as? TourDetailTableViewController else {
            os_log("Error tranitioning to tour details. Destination is not tour detail.", type: .error)
            return
        }
        
        guard let selectedTourCell = sender as? UITableViewCell else {
            os_log("Segue sender in Tours table is not a UITableViewCell.", type: .error)
            return
        }
        
        guard let indexPath = self.toursTableView.indexPath(for: selectedTourCell) else
        {
            os_log("Could not get indexPath for selected Tour.", type: .error)
            return
        }
        
        let selectedTour = self.tours[indexPath.row]
        tourDetailController.tour = selectedTour
    }
}

