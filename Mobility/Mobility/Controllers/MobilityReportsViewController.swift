
//

//

import UIKit

class MobilityReportsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var mobilityReportsTable: UITableView!
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportCell", for: indexPath) as! ReportsTableViewCell
        cell.reportHeading.text = "Report Ipsum"
        cell.reportDate.text = "12/12/17"
        cell.reportContent.text = "Content Lorem ipsum"
        return cell //4.
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        mobilityReportsTable.delegate = self
        mobilityReportsTable.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
