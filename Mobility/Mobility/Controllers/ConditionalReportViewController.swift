import UIKit
import os.log

class ConditionalReportViewController: UIViewController, UITextFieldDelegate {

    // MARK: Properties
    /*
     This value is either passed by `TourTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new tour.
     */
    var station: Station?
    @IBOutlet weak var saveConditionalReport: UIBarButtonItem!
    @IBOutlet weak var conditionalReportName: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // conditionalReportName.delegate = self
        // updateSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)    // dismisses modal, back to previous scene
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveConditionalReport else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
     }
        
        let nameInput = conditionalReportName.text ?? "X"
        let name = "Duty Tour \(nameInput)"
        let photo = UIImage(named: "station1")
        
        station = Station(name: name, photo: photo!, formula: "")
    }
    
    // MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveConditionalReport.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    // MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = conditionalReportName.text ?? ""
        saveConditionalReport.isEnabled = !text.isEmpty
    }
}
