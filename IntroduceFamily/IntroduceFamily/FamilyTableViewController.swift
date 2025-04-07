//
//  FamilyTableViewController.swift
//  IntroduceFamily
//
//  Created by Hayden Boss on 3/31/25.
//

import UIKit

class FamilyTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    var familyMembers: [FamilyMember] = [
        FamilyMember(name: "David", age: 45, jobs: "IT manager", hobbies: ["3D Printing", "Cooking", "laser engraving"]),
        FamilyMember(name: "Becky", age: 42, jobs: "Realtor, Hair Sytlist", hobbies: ["watching TV", "reading", "cooking"]),
        FamilyMember(name: "Courtney", age: 31, jobs: "HOA Something", hobbies: ["School", "Sporting Events"]),
        FamilyMember(name: "Connor", age: 28, jobs: "Police Officer"),
        FamilyMember(name: "Hadley", age: 24, jobs: "No Clue"),
        FamilyMember(name: "Hayden", age: 21, jobs: nil, hobbies: ["Videogames", "Anime", "Hanging Out With Friends"])
    ]
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return familyMembers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "familyMemberCell", for: indexPath)

        let familyMember = familyMembers[indexPath.row]
        cell.textLabel?.text = familyMember.name
        let hobbiesText = familyMember.hobbies?.joined(separator: ", ") ?? "No hobbies listed"
                cell.detailTextLabel?.text = "Age: \(familyMember.age), Jobs: \(familyMember.jobs ?? "N/A"), Hobbies: \(hobbiesText)"
                
                return cell
            }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Perform segue to DetailViewController when a row is tapped
            self.performSegue(withIdentifier: "showDetail", sender: familyMembers[indexPath.row])
        }

        // MARK: - Navigation

        // Prepare the data to pass to DetailViewController
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showDetail" {
                if let detailVC = segue.destination as? DetailViewController,
                   let familyMember = sender as? FamilyMember {
                    detailVC.familyMember = familyMember
                }
            }
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
