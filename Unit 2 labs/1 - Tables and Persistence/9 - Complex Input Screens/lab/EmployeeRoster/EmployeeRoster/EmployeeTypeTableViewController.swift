//
//  EmployeeTypeTableViewController.swift
//  EmployeeRoster
//
//  Created by Hayden Boss on 3/25/25.
//

import UIKit

protocol EmployeeTypeTableViewControllerDelegate: AnyObject {
    func employeeTypeTableViewController(_ controller: EmployeeTypeTableViewController, didSelect employeeType: EmployeeType)
}

class EmployeeTypeTableViewController: UITableViewController, EmployeeTypeTableViewControllerDelegate, EmployeeDetailTableViewControllerDelegate {
    var employeeType: EmployeeType?
    func employeeDetailTableViewController(_ controller: EmployeeDetailTableViewController, didSave employee: Employee) {
        self.employeeType = employee.employeeType
        tableView.reloadData()
    }
    
    func employeeTypeTableViewController(_ controller: EmployeeTypeTableViewController, didSelect employeeType: EmployeeType) {
        self.employeeType = employeeType
        tableView.reloadData()
        delegate?.employeeTypeTableViewController(controller, didSelect: employeeType)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    weak var delegate: EmployeeTypeTableViewControllerDelegate?
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EmployeeType.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTypeCell", for: indexPath)
            let type = EmployeeType.allCases[indexPath.row]
            
            var content = cell.defaultContentConfiguration()
            content.text = type.description
            cell.contentConfiguration = content
            
            if employeeType == type {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
            return cell
        }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        employeeType = EmployeeType.allCases[indexPath.row]
        if let delegate = delegate {
            delegate.employeeTypeTableViewController(self, didSelect: employeeType!)
        }
        tableView.reloadData()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEmployeeDetail" {
            if let destinationVC = segue.destination as? EmployeeDetailTableViewController {
                destinationVC.selectedEmployeeType = self.employeeType
                destinationVC.delegate = self
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
