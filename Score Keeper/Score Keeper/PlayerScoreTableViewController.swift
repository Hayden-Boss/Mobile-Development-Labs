//
//  PlayerScoreTableViewController.swift
//  Score Keeper
//
//  Created by Hayden Boss on 4/1/25.
//

import UIKit

protocol PlayerScoreTableViewControllerDelegate: AnyObject {
    func didChangeWinnerControlSelection(_ index: Int)
}

class PlayerScoreTableViewController: UITableViewController, PlayerTableViewCellDelegate {
    
    weak var delegate: PlayerTableViewCellDelegate?
    var winnerControl: UISegmentedControl
    
    var players = [Player]()
    var sport: Sport?
    
    func didChangeScore(for player: Player, newScore: Int) {
            // Find the player in the array and update their score
            if let index = players.firstIndex(where: { $0.name == player.name }) {
                players[index].score = newScore
                sortPlayers()
                let indexPath = IndexPath(row: index, section: 0)
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
        
        override func viewDidLoad() {
        super.viewDidLoad()
        
            if let sport = sport {
                players = sport.players
                title = sport.title
                sortPlayers()
                tableView.reloadData()
            }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return players.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as? PlayerTableViewCell else {
            return UITableViewCell()}
        
        let player = players[indexPath.row]

        cell.nameLabel.text = player.name
        cell.scoreLabel.text = "\(player.score)"
        cell.logoImageView.image = UIImage(systemName: player.logo)
        
        cell.stepper.value = Double(player.score)
        
        cell.player = player
        cell.delegate = self
        
        return cell
    }
    
    @IBAction func saveScoreTapped(_ sender: Any) {
        sport?.players = players
        updateLeader()
        performSegue(withIdentifier: "unwindToSportList2", sender: self)
    }
    
    // Sorting method that sorts players by score
    func sortPlayers() {
        guard let order = sport?.sortOrder else { return }

        switch order {
        case .ascending:
            players.sort { $0.score < $1.score }
        case .descending:
            players.sort { $0.score > $1.score }
        }

        tableView.reloadData()
    }
   
    func updateLeader() {
        // Ensure there are players to check
        guard players.count > 0 else { return }

        // Assign the leader based on the winnerControl segment
        if let winnerControl = winnerControl {
            if winnerControl.selectedSegmentIndex == 0 {
                // Leader is the player with the highest score
                sport?.leader = players.max(by: { $0.score < $1.score })
            } else {
                // Leader is the player with the lowest score
                sport?.leader = players.min(by: { $0.score > $1.score }) // Correct comparison for lowest score
            }
        }
        
        updateLeaderLabel() // Update the leader label
    

    }

    
    func updateLeaderLabel() {
            // You can display the leader's name or update a label/UI element if needed
            if let leader = sport?.leader {
                print("Current leader: \(leader.name)") // You can update a label here instead
            }
        }
    
    // This is a delegate method in PlayerScoreTableViewController that will be called when the winnerControl's selection changes
    func didChangeWinnerControlSelection(_ index: Int) {
        if index == 0 {
            // Leader is the player with the highest score
            sport?.leader = players.max(by: { $0.score < $1.score })
        } else {
            // Leader is the player with the lowest score
            sport?.leader = players.min(by: { $0.score > $1.score })
        }

        updateLeaderLabel() // Update the leader label
    }




    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            // Sort players whenever the view appears
            sortPlayers()
        }
}
