//
//  SportTableViewController.swift
//  Score Keeper
//
//  Created by Hayden Boss on 4/8/25.
//

import UIKit

class SportTableViewController: UITableViewController {
    
    var sports: [Sport] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Dummy data for testing
        let player1 = Player(name: "Hayden", score: 0, logo: "person.crop.circle.fill")
        let player2 = Player(name: "Johnny", score: 2, logo: "person.crop.circle.fill")
        let player3 = Player(name: "Fred", score: 15, logo: "person.crop.circle.fill")
        
        let sport1 = Sport(title: "Baseball Game", players: [player1, player2, player3], sportImage: "football.fill", sortOrder: .descending)
        sports.append(sport1)
        
        let sport2 = Sport(title: "Basketball Game", players: [player1, player3], sportImage: "football.fill", sortOrder: .ascending)
        sports.append(sport2)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sports.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as? SportTableViewCell else { return UITableViewCell()
        }
        
        let sport = sports[indexPath.row]
        
        cell.sportName.text = sport.title
        
        if let logoName = sport.sportImage {
                cell.sportImage.image = UIImage(systemName: logoName)
            } else {
                cell.sportImage.image = UIImage(systemName: "sportscourt") // Default image
            }
        
        if let firstPlayer = sport.players.first {
                cell.leaderLabel.text = firstPlayer.name
            } else {
                cell.leaderLabel.text = "No players" // Default if no players
            }
        return cell
    }

    @IBAction func unwindToSportList(segue: UIStoryboardSegue) {
        if let sourceViewController = segue.source as? AddSportViewController {
            if let newSport = sourceViewController.sport {
                sports.append(newSport)
                tableView.reloadData()
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "playerScore", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playerScore",
           let destinationVC = segue.destination as? PlayerScoreTableViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            let selectedSport = sports[indexPath.row]
            destinationVC.sport = selectedSport
        }
    }
    
    @IBAction func unwindToSportList2(segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? PlayerScoreTableViewController,
               let updatedSport = sourceVC.sport {
                
                // Find and update the matching sport
                if let index = sports.firstIndex(where: { $0.title == updatedSport.title }) {
                    sports[index] = updatedSport
                }

                tableView.reloadData()
            }
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
}

