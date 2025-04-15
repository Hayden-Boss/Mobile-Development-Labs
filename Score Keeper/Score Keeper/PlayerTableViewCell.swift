//
//  PlayerTableViewCell.swift
//  Score Keeper
//
//  Created by Hayden Boss on 4/1/25.
//

import UIKit

protocol PlayerTableViewCellDelegate: AnyObject {
    func didChangeScore(for player: Player, newScore: Int)
}

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    var player: Player!
    weak var delegate: PlayerTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func stepperButtonTapped(_ sender: UIStepper) {
        let newScore = Int(sender.value)
        scoreLabel.text = "\(newScore)"
        delegate?.didChangeScore(for: player, newScore: newScore)
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
