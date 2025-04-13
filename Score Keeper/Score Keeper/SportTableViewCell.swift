//
//  SportTableViewCell.swift
//  Score Keeper
//
//  Created by Hayden Boss on 4/8/25.
//

import UIKit

class SportTableViewCell: UITableViewCell {

    @IBOutlet weak var sportImage: UIImageView!
    @IBOutlet weak var sportName: UILabel!
    @IBOutlet weak var leaderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
