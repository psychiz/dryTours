
//

import UIKit

class ControlRoomListViewController: UIViewController {
    @IBOutlet weak var controlRoomList: UITableView!
    var arrayOfControlRooms: [String] = []
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var technicianEmailId: UILabel!
    @IBOutlet weak var technicianName: UILabel!
    @IBOutlet weak var technicianControlRoom: UILabel!
    
    private var fetcher: Fetcher = ((UIApplication.shared.delegate as? AppDelegate)?.fetcher)!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        controlRoomList.delegate = self
        controlRoomList.dataSource = self
        // Do any additional setup after loading the view.
         arrayOfControlRooms = ["Control Room 1", "Control Room 2","Control Room 3","Control Room 4", "Control Room 5","Control Room 6"]
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        refreshTechnicianData()
        
        
    }
    
    
    
    
    private func refreshTechnicianData() {
        self.fetcher.fetchRemoteTechnician {result in
            
            // READ: retain cycle in swift, unknown self. no reference counter incremented anywhere
            
            switch result
            {
            case .success:
                let technician = self.fetcher.fetchLocalTechnician()
                self.loadViewData()
                //  self.userNameCell.detailTextLabel?.text = technician?.displayName ?? "No Name"
                
            case .failure(let error):
                Helpers.showErrorToast(view: self.view, message: error.localizedDescription)
            }
           // self.refreshControlLoader.endRefreshing()   // only needed when user pulls down refresh view
        }
    }



    @IBAction func submitControlRoomSelection(_ sender: Any) {
   
        performSegue(withIdentifier: "showTabFlow", sender: self)
    }
  
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Load profile data
    
    // MARK: Privates
    private func loadViewData()
    {
        let technician = self.fetcher.fetchLocalTechnician()
        print(technician)
        // for some reason, if use empty string, detail in view for technician name never displays.
        self.technicianName.text = technician?.displayName
        self.technicianEmailId.text = technician?.email
        self.technicianControlRoom.text = technician?.defaultSite
        self.refreshTechnicianData()
    
    }
    
    
    
    
}


extension ControlRoomListViewController: UITableViewDelegate,UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     {
     
       let cell = tableView.dequeueReusableCell(withIdentifier: "ControlllerListTableViewCell", for: indexPath as IndexPath) as! ControlllerListTableViewCell
       
        cell.controlListName.text = arrayOfControlRooms[indexPath.row] as String
        
        return cell
     }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayOfControlRooms.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if cell.accessoryType == .checkmark{
                cell.accessoryType = .none
            }
            else{
                cell.accessoryType = .checkmark
            }
        }
        
    }
 
}
