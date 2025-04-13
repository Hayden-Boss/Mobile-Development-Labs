//
//  AddSportViewController.swift
//  Score Keeper
//
//  Created by Hayden Boss on 4/8/25.
//

import UIKit

protocol AddSportViewControllerDelegate: AnyObject {
    func didChangeWinnerControlSelection(_ index: Int)
}


class AddSportViewController: UIViewController{
    weak var delegate: AddSportViewControllerDelegate? // Declare the delegate

        var players = [Player(name: "Hayden", score: 0, logo: "person.crop.circle.fill"),
                       Player(name: "Johnny", score: 2, logo: "person.crop.circle.fill"),
                       Player(name: "Fred", score: 0, logo: "person.crop.circle.fill")]

        var selectedSportImage: String = "dice.fill"
        var sport: Sport?
    
    @IBOutlet weak var imageListControl: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var sortByControl: UISegmentedControl!
    @IBOutlet weak var winnerControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        updateLeader()

        // Do any additional setup after loading the view.
    }
    func addPlayer(named name: String) {
        let newPlayer = Player(name: name, score: 0, logo: "person.crop.circle.fill")
        players.append(newPlayer)
        tableView.reloadData()
        updateLeader()
    }

    @IBAction func addPlayerButtonTapped(_ sender: Any) {
        presentAddPlayerAlert()
    }
    
    func presentAddPlayerAlert() {
        let alertController = UIAlertController(title: "Add Player", message: "Enter the player's name", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Player Name"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            if let playerName = alertController.textFields?.first?.text, !playerName.isEmpty {
                self?.addPlayer(named: playerName)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedSportImage = "dice.fill"  // Example: Baseball image
        case 1:
            selectedSportImage = "football.fill"  // Example: Basketball image
        case 2:
            selectedSportImage = "gamecontroller.fill"
        default: selectedSportImage = "brain.fill"
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let sportTitle = titleTextField.text ?? "Untitled Sport"
        sport = Sport(title: sportTitle, players: players, sportImage: selectedSportImage, sortOrder: sortByControl.selectedSegmentIndex == 0 ? .descending : .ascending)
        updateLeader()
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToSportList" {
            let sportTitle = titleTextField.text ?? "Untitled Sport"
            sport = Sport(title: sportTitle, players: players, sportImage: selectedSportImage, sortOrder: sortByControl.selectedSegmentIndex == 0 ? .descending : .ascending)
        }
    }
    
    @IBAction func sortByControlChanged(_ sender: UISegmentedControl) {
        guard players.count > 1 else { return }
            
            print("Before sort:", players.map { $0.score })
            
            switch sender.selectedSegmentIndex {
            case 0:
                players.sort { $0.score > $1.score }
            case 1:
                players.sort { $0.score < $1.score }
            default:
                break
            }
            
            print("After sort:", players.map { $0.score })
            
            tableView.reloadData()
            updateLeader()
    }
    
    @IBAction func leaderControlChanged(_ sender: UISegmentedControl) {
        updateLeader()
        delegate?.didChangeWinnerControlSelection(sender.selectedSegmentIndex)
    }
    
    func updateLeader() {
        // Ensure there are players to check
        guard players.count > 0 else { return }
        
        // Assign the leader based on the winnerControl segment
        if winnerControl.selectedSegmentIndex == 0 {
            // Leader is the player with the highest score
            sport?.leader = players.max(by: { $0.score < $1.score })
        } else {
            // Leader is the player with the lowest score
            sport?.leader = players.min(by: { $0.score > $1.score }) // Correct comparison for lowest score
        }
        
        updateLeaderLabel() // Update the leader label
    }

    
    func updateLeaderLabel() {
            // You can display the leader's name or update a label/UI element if needed
            if let leader = sport?.leader {
                print("Current leader: \(leader.name)") // You can update a label here instead
            }
        }
}

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


extension AddSportViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as? SettingsPlayerListTableViewCell else {
            return UITableViewCell()
        }
        let player = players[indexPath.row]
        cell.settingsNameLabel.text = player.name
        return cell
    }
}

extension AddSportViewController: UITableViewDelegate {
    // Implement delegate methods here if needed, like didSelectRowAt
}
