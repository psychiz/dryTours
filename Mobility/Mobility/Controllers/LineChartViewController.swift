

import UIKit
import Charts
class LineChartViewController: UIViewController
{
    @IBOutlet weak var lineChartView: LineChartView!
    var months: [String]!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        let populationData :[Int : Double] = [
            1990 : 123456.0,
            2000 : 133456.0,
            2010 : 6.0
        ]
        
        let ySeries = populationData.map { x, y in
            return ChartDataEntry(x: Double(x), y: y)
        }
        
        let data = LineChartData()
        let dataset = LineChartDataSet(values: ySeries, label: "Hello")
        dataset.colors = [NSUIColor.red]
        data.addDataSet(dataset)
        
        self.lineChartView.data = data
        
        self.lineChartView.gridBackgroundColor = NSUIColor.white
        self.lineChartView.xAxis.drawGridLinesEnabled = false;
        self.lineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        self.lineChartView.chartDescription?.text = "LineChartView Example"
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


