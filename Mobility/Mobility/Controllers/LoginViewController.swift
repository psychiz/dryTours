import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate
{
    // MARK: Properties
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var showOrHideDataSourceOutlet: UIButton!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    var loginButtonColor = UIColor()
   
    @IBOutlet weak var dataSourceLinkTableView: UITableView!
    
   
    @IBOutlet weak var dropDownSelectedItemLabel: UILabel!
    private var fetcher: Fetcher = ((UIApplication.shared.delegate as? AppDelegate)?.fetcher)!
    
    private enum LoginConstants
    {
        static let LoginSeque = "LoginSuccessSegue"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //MARK: RUN THE SOURCE CODE IN DEBUG AND RELEASE 
        
        #if DEBUG
            
            print("INDEBUG MODE")
            showOrHideDataSourceOutlet.isHidden = false
            dropDownSelectedItemLabel.isHidden = false
            #else
            
            
            print ("RELEASE")
            showOrHideDataSourceOutlet.isHidden = true
            dropDownSelectedItemLabel.isHidden = true
            
        #endif
        
        
        
          //dataSourceLinkTableView
          dataSourceLinkTableView.delegate = self
          dataSourceLinkTableView.dataSource = self
        self.dataSourceLinkTableView.register(UITableViewCell.classForKeyedArchiver(), forCellReuseIdentifier: "DataSourceCell")
        
        self.dataSourceLinkTableView.isHidden = true;
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "login")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        loginButtonColor = loginButtonOutlet.backgroundColor as! UIColor
        var username: String? = self.userNameTextField?.text
        var password: String? = self.passwordTextField?.text
     
        if username == "" && password == ""
        {
            loginButtonOutlet.backgroundColor = UIColor.gray
            loginButtonOutlet.isUserInteractionEnabled = false
          
        }
        self.userNameTextField?.delegate = self
        self.passwordTextField?.delegate = self
    
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
       textField.resignFirstResponder()            // Hide the keyboard.
        
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        print("TextField should begin editing method called")
        return true;
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called")
   
        if textField.text != "" && self.userNameTextField.text != "" && self.passwordTextField.text != "" 
        {
            loginButtonOutlet.backgroundColor = loginButtonColor
            loginButtonOutlet.isUserInteractionEnabled = true
            
        }
        else
        {
            loginButtonOutlet.backgroundColor = UIColor.gray
            loginButtonOutlet.isUserInteractionEnabled = false
            
        }
    
    }

    
    // MARK: Actions
    @IBAction func handleLoginAttempt(_ sender: Any)
    {
        
        
     
if Utility.isInternetConnectionAvailable()
        {
        var username: String? = self.userNameTextField?.text
        var password: String? = self.passwordTextField?.text
        #if DEBUG
            if username == "" && password == "" {
                username = Helpers.loadEnvironmentVariable(byKey: Constants.defaultUsername)
                password = Helpers.loadEnvironmentVariable(byKey: Constants.defaultPassword)
            loginButtonOutlet.isUserInteractionEnabled = false
            loginButtonOutlet.backgroundColor = UIColor.gray
        }
          
     #endif
        
        activityIndicator.startAnimating()
        SessionService.login(username: username!, password: password!, success: {() -> Void in
            self.activityIndicator.stopAnimating()
            self.userNameTextField.text = ""
            self.passwordTextField.text = ""
            self.loginButtonOutlet.isUserInteractionEnabled = true
            self.loginButtonOutlet.backgroundColor = UIColor.gray
       //     self.fetcher.deleteLocalTechnician()
            self.performSegue(withIdentifier: LoginConstants.LoginSeque, sender: Bool(true))
        },
                             failure: {(error) -> Void in
            self.activityIndicator.stopAnimating()
            var message: String = "There was an issue with the request. Please check the credentials"
            
            if error.statusCode >= 400 {
                message = "HTTP \(error.statusCode) \(error.message)"
           
                Utility.alertController(message: message)
                
                                }
            
           // Helpers.showErrorToast(view: self.view, message: message)
        })
        }
        else
        {
            Utility.alertController(message: "Please check your internet connection!")
            
        }
    }
    
 
    // MARK: Navigation
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let wasLoginSuccessful = sender as? Bool, identifier == LoginConstants.LoginSeque {
            
            if wasLoginSuccessful
            {
                return true
            }
        }

        return false
    }
    ///Mark : Hide or Show Data Source Linl
    
    
    // MARK : Datasource link 
    
    @IBAction func showOrHideLogin(_ sender: Any)
    {
        if dataSourceLinkTableView.isHidden
        {
           dataSourceLinkTableView.isHidden = false
         }
        else {
            
          dataSourceLinkTableView.isHidden = true
        }
        
    }
    
    // MARK: - Properties
    let dataSources = Constants.dataSources
    
    var selectedDataSource: String?
    {
        didSet
        {
            if let selectedDataSource = selectedDataSource, let index = dataSources.index(of: selectedDataSource) {
                selectedDataSourceIndex = index
            }
        }
    }
    var selectedDataSourceIndex: Int?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard segue.identifier == "SaveSelectedDataSource",
            let cell = sender as? UITableViewCell,
            let indexPath = dataSourceLinkTableView.indexPath(for: cell) else {
                return
        }
        let index = indexPath.row
        self.selectedDataSource = dataSources[index]
    }
    
}

extension LoginViewController: UITableViewDataSource,UITableViewDelegate
{
    @IBAction func unwindToLoginViewController(_ segue: UIStoryboardSegue)
    {
        // place holder so exit scene knows should stop at this ViewController
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataSourceCell", for: indexPath)
        cell.textLabel?.text = dataSources[indexPath.row]
        
        if indexPath.row == selectedDataSourceIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Other row is selected - need to deselect it
        if let index = selectedDataSourceIndex {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell?.accessoryType = .none
        }
        
        selectedDataSource = dataSources[indexPath.row]
        SessionService.dataSource = selectedDataSource!
        let selectedCell = tableView.cellForRow(at: indexPath)
        selectedCell?.accessoryType = .checkmark
       self.dropDownSelectedItemLabel.text = selectedDataSource
        self.dataSourceLinkTableView.isHidden = true
    
    }
}
