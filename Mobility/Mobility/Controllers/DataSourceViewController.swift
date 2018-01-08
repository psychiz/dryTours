import UIKit

// pattern from: https://www.raywenderlich.com/160519/storyboards-tutorial-ios-10-getting-started-part-2
class DataSourceViewController: UITableViewController
{
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
            let indexPath = tableView.indexPath(for: cell) else {
                return
        }
        let index = indexPath.row
        self.selectedDataSource = dataSources[index]
    }
}

// MARK: - UITableViewDataSource
extension DataSourceViewController
{
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
     {
        return dataSources.count
     }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataSourceCell", for: indexPath)
            cell.textLabel?.text = dataSources[indexPath.row]
        
        if indexPath.row == selectedDataSourceIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
         return cell
    }
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Other row is selected - need to deselect it
        if let index = selectedDataSourceIndex {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell?.accessoryType = .none
        }
        
        selectedDataSource = dataSources[indexPath.row]
        let selectedCell = tableView.cellForRow(at: indexPath)
        selectedCell?.accessoryType = .checkmark
    }
}
