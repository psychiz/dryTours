

import UIKit





class ReportsTableViewCell: UITableViewCell {
    @IBOutlet weak var reportHeading: UILabel!
    
    @IBOutlet weak var reportContent: UILabel!
    @IBOutlet weak var reportDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
