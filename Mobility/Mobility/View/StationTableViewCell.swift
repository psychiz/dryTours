import UIKit

class StationTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stationImageView: UIImageView!
    @IBOutlet weak var stationReadingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
