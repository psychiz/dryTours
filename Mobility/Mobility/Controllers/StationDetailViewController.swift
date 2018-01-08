import UIKit
import os.log

import MathParser

class StationDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var stationDetailTableView: UITableView!
    // MARK: properties
    var stationReading: TourStationReading?
  
    @IBOutlet weak var stationPhotoView: UIImageView!
    @IBOutlet weak var stationReadingField: UITextField!
    @IBOutlet weak var stationFormula: UILabel!
    @IBOutlet weak var stationFormulaResult: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        stationDetailTableView.delegate = self
        stationDetailTableView.dataSource = self
      //  stationReadingField.delegate = self

        if let stationReading = stationReading {
            navigationItem.title = stationReading.station?.name

           // stationPhotoView.image = stationReading.station?.photo
          //  stationReadingField.text = stationReading.stationValue?.reading
            
          //  let formulaWithoutTokens = stationReading.station?.formula.replacingOccurrences(of: "$", with: "")
       //     stationFormula.text = formulaWithoutTokens
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        evaluate()
    }

    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
    
        if segue.identifier == "SaveStationDetail", let reading = stationReadingField.text {
            stationReading?.stationValue?.reading = reading
        }
    }
    
    // MARK: Private methods
    
    private func evaluate() {
        let rawExpression = stationReading!.station!.formula
        
        do {
            let evaluator: Evaluator = Evaluator()
            let expression = try Expression(string: rawExpression)
            let isComparision = rawExpression.range(of: "<") != nil   // NOTE: handle more comparisons
            let parsedInput = Double(stationReadingField.text!) ?? 0
            let substitions = ["x": parsedInput]
            let value = try evaluator.evaluate(expression, substitutions: substitions)
            var outputText = String(describing: value)
            
            if isComparision {
                outputText = value == 1 ? "true" : "false"
            }
            
            stationFormulaResult.text = outputText
        } catch {
            NSLog("Unable to parse or evaluate expression: \(rawExpression)")
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        if indexPath.row == 0
        {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegularExpressionCustomTableViewCell", for: indexPath) as! RegularExpressionCustomTableViewCell
            if let stationReading = stationReading {
            cell.stationValueText.text = stationReading.stationValue?.reading
            
            }
        
            
            
            
            return cell
        }
        else if indexPath.row == 1
        {
            let  cell = tableView.dequeueReusableCell(withIdentifier: "PhysicalLocationTableViewCell", for: indexPath) as! PhysicalLocationTableViewCell
            return cell
        }
            
            
        else if indexPath.row == 2
        {
      let  cell = tableView.dequeueReusableCell(withIdentifier: "PhysicalLocationTableViewCell", for: indexPath) as! PhysicalLocationTableViewCell
            return cell
        }
        
        else if indexPath.row == 3
        {
         let    cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell", for: indexPath) as! DescriptionTableViewCell
        return cell
        
        }
        
        
        else if indexPath.row == 4
        {
          let   cell = tableView.dequeueReusableCell(withIdentifier: "OtherOptionsTableViewCell", for: indexPath) as! OtherOptionsTableViewCell
            cell.optionLabel.text = "Instructions"
            return cell
        
        }
        
        else if indexPath.row == 5
        {
            let   cell = tableView.dequeueReusableCell(withIdentifier: "OtherOptionsTableViewCell", for: indexPath) as! OtherOptionsTableViewCell
          
            cell.optionLabel.text = "Attachment"
            
            
            return cell
            
        }
        else if indexPath.row == 6
        {
            let   cell = tableView.dequeueReusableCell(withIdentifier: "OtherOptionsTableViewCell", for: indexPath) as! OtherOptionsTableViewCell
            cell.optionLabel.text = "Trending"
            
            
            return cell
            
        }
        
        return UITableViewCell()
    }
}
