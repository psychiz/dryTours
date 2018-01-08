import UIKit

class TourDetailTableViewController: UITableViewController {
    // Mark - Tour
    var tour: Tour = Tour()
    private var fetcher: Fetcher = ((UIApplication.shared.delegate as? AppDelegate)?.fetcher)!
    
    @IBOutlet weak var tourIDCell: UITableViewCell!
    @IBOutlet weak var tourDescriptionCell: UITableViewCell!
    @IBOutlet weak var startTourButton: UIButton!
    @IBOutlet weak var tourStartTimeCell: UITableViewCell!

    @IBAction func refreshView(_ sender: UIRefreshControl) {
        self.refreshTourData()
    }
    
    @IBAction func refreshViewButton(_ sender: UIBarButtonItem) {
        self.refreshControl?.beginRefreshing()
        self.refreshTourData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViewData()
    }
    
    private func loadViewData() {
        //self.tour = self.fetcher.loadTourById(self.tour.stationid)
        
        self.tourIDCell.textLabel?.text = self.tour.stationid
        self.tourDescriptionCell.textLabel?.text = self.tour.debugDescription
        self.tourStartTimeCell.detailTextLabel?.text = self.tour.startDate?.toDateTime()
        self.startTourButton.isEnabled = TourLogic.canTourBeStarted(tour: tour)
    }
    
    private func refreshTourData() {
        let tourId = self.tour.stationid ?? "no-tour-id"
        
        self.fetcher.getRemoteTourById(tourId: tourId) {result in
            switch result {
            case .success:
                self.loadViewData()
            case .failure(let error):
                Helpers.showErrorToast(view: self.view, message: error.localizedDescription)
            }
        }
        
        self.refreshControl?.endRefreshing()
    }
}

extension TourDetailTableViewController {
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
