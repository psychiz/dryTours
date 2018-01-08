//
//

import UIKit

class NotesViewController: UIViewController {

  @IBOutlet weak var notesTableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        notesTableView.delegate = self
        notesTableView.dataSource = self 
        self.notesTableView.register(NotesTableViewCell.self, forCellReuseIdentifier: "DataSourceCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - UITableViewDataSource

extension NotesViewController:  UITableViewDataSource,UITableViewDelegate
 {
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTableViewCell", for: indexPath) as! NotesTableViewCell
      
    cell.reportHeading.text = "Added deferment tag"
    cell.reportDate.text = "12/12/17"
    cell.reportContent.text = "Content Lorem ipsum"
        return cell
    }
   
    
}

