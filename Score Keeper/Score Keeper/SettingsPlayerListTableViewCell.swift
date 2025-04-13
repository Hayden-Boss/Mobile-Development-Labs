//
//  SettingsPlayerListTableViewCell.swift
//  Score Keeper
//
//  Created by Hayden Boss on 4/8/25.
//

import UIKit

class SettingsPlayerListTableViewCell: UITableViewCell {

    @IBOutlet weak var settingsPlayerImage: UIImageView!
    @IBOutlet weak var settingsNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
