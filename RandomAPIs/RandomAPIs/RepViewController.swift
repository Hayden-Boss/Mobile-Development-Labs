//
//  RepViewController.swift
//  RandomAPIs
//
//  Created by Hayden Boss on 5/2/25.
//

import UIKit

class RepViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var zipTextField: UITextField!
    
    var representatives: [Representative] = []
    let repController = RepresentativeController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        guard let zip = zipTextField.text, !zip.isEmpty else { return }

        Task {
            do {
                let reps = try await repController.fetchRepresentatives(for: zip)
                DispatchQueue.main.async {
                    self.representatives = reps
                    self.tableView.reloadData()
                }
            } catch {
                print("Error fetching representatives: \(error.localizedDescription)")
                // You could also show an alert to the user here
            }
        }
    }

    // MARK: - UITableView DataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return representatives.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepCell", for: indexPath) as? RepTableViewCell else {
            fatalError("Could not dequeue RepTableViewCell")
        }

        let rep = representatives[indexPath.row]
        cell.nameLabel.text = rep.name
        cell.partyLabel.text = "\(rep.party), \(rep.state)"
        cell.linkLabel.text = "Link: \(rep.link)"

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
}
