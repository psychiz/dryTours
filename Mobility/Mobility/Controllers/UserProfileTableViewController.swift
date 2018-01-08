import UIKit
import Toast_Swift

class UserProfileTableViewController: UITableViewController {

    // MARK: Properties
    @IBOutlet weak var userNameCell: UITableViewCell!
    @IBOutlet weak var versionCell: UITableViewCell!
    @IBOutlet weak var buildNumberCell: UITableViewCell!
    @IBOutlet weak var trainingSiteLabel: UILabel!
    @IBOutlet weak var refreshControlLoader: UIRefreshControl!
    @IBOutlet weak var dataSourceCell: UITableViewCell!

    private var fetcher: Fetcher = ((UIApplication.shared.delegate as? AppDelegate)?.fetcher)!
    
    var dataSource: String = Constants.dataSources[0] {
        didSet {
            dataSourceCell.detailTextLabel?.text = dataSource
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewData()
    }

    // MARK: Actions
    @IBAction func refreshControl(_ sender: UIRefreshControl) {
        loadViewData()
    }
    
    // MARK: Privates
    private func loadViewData() {
        let technician = self.fetcher.fetchLocalTechnician()
        print(technician)
        // for some reason, if use empty string, detail in view for technician name never displays.
        self.userNameCell.detailTextLabel?.text = technician?.displayName ?? "Name"
        self.versionCell.detailTextLabel?.text = Helpers.loadAppSetting(byKey: Constants.releaseVersionKey)
        self.buildNumberCell.detailTextLabel?.text = Helpers.loadAppSetting(byKey: Constants.buildVersionKey)
        self.dataSourceCell.detailTextLabel?.text = SessionService.dataSource
        self.refreshTechnicianData()
    }

    private func refreshTechnicianData() {
        self.fetcher.fetchRemoteTechnician {result in
   
            // READ: retain cycle in swift, unknown self. no reference counter incremented anywhere
           
            switch result
            {
            case .success:
                let technician = self.fetcher.fetchLocalTechnician()
                self.userNameCell.detailTextLabel?.text = technician?.displayName ?? "No Name"
        
            case .failure(let error):
                Helpers.showErrorToast(view: self.view, message: error.localizedDescription)
            }
              self.refreshControlLoader.endRefreshing()   // only needed when user pulls down refresh view
        }
    }
}

extension UserProfileTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickDataSource" {
            let dataSourceViewController = segue.destination as? DataSourceViewController
            dataSourceViewController?.selectedDataSource = self.dataSource
        }
    }
    
    @IBAction func unwindWithSelectedDataSource(segue: UIStoryboardSegue) {
        let dataSourceViewController = segue.source as? DataSourceViewController
        let selectedDataSource = dataSourceViewController?.selectedDataSource
        
        if selectedDataSource != nil {
            SessionService.dataSource = selectedDataSource!
            self.dataSource = selectedDataSource!
            self.dataSourceCell.detailTextLabel?.text = selectedDataSource
        }
    }
}
