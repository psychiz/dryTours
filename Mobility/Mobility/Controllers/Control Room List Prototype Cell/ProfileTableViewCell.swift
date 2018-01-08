//
//  ProfileTableViewCell.swift
//  Mobility
//
//  Created by zeeshan on 31/12/17.
//  Copyright © 2017 zeeshan. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
  
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var profileEmail: UILabel!
 
    @IBOutlet weak var profileOrganization: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
