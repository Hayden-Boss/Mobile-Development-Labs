
import UIKit

protocol EmployeeDetailTableViewControllerDelegate: AnyObject {
    func employeeDetailTableViewController(_ controller: EmployeeDetailTableViewController, didSave employee: Employee)
}

class EmployeeDetailTableViewController: UITableViewController, UITextFieldDelegate, EmployeeTypeTableViewControllerDelegate {
    func employeeTypeTableViewController(_ controller: EmployeeTypeTableViewController, didSelect employeeType: EmployeeType) {
        selectedEmployeeType = employeeType
        employeeTypeLabel.text = employeeType.description
        employeeTypeLabel.textColor = .black
    }
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dobLabel: UILabel!
    @IBOutlet var employeeTypeLabel: UILabel!
    @IBOutlet var saveBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var dobDatePicker: UIDatePicker!
    
    var selectedEmployeeType: EmployeeType?
    
    
    var dobCellIndexPath = IndexPath(row: 2, section: 0)  // The row where the date picker is located
    
    var isEditingBirthday: Bool = false {
        didSet {
            dobDatePicker.isHidden = !isEditingBirthday
            // Make sure the table view updates the layout correctly when the picker visibility changes
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dobCellIndexPath == indexPath {
            return isEditingBirthday ? 190 : 0
        } else {
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if dobCellIndexPath == indexPath {
            return 190  // Give an estimated height for the date picker row
        } else {
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Only toggle if tapping the row above the date picker (row containing dobLabel)
        if indexPath.row == dobCellIndexPath.row - 1 {
            isEditingBirthday.toggle()
        }
    }
    
    weak var delegate: EmployeeDetailTableViewControllerDelegate?
    var employee: Employee?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
        updateSaveButtonState()
    }
    
    func updateView() {
        if let employee = employee {
            navigationItem.title = employee.name
            nameTextField.text = employee.name
            
            dobLabel.text = employee.dateOfBirth.formatted(date: .abbreviated, time: .omitted)
            dobLabel.textColor = .label
            employeeTypeLabel.text = employee.employeeType.description
            employeeTypeLabel.textColor = .label
        } else {
            navigationItem.title = "New Employee"
        }
    }
    
    private func updateSaveButtonState() {
        let shouldEnableSaveButton = nameTextField.text?.isEmpty == false
        saveBarButtonItem.isEnabled = shouldEnableSaveButton
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty else {
            return
        }
        
        // Use the date from the date picker instead of the current date
        let selectedDate = dobDatePicker.date
        let employeeType = selectedEmployeeType ?? .exempt
        // Create the Employee object using the selected date from the date picker
        let employee = Employee(name: name, dateOfBirth: selectedDate, employeeType: employeeType)
        
        // Notify the delegate that the employee has been saved
        delegate?.employeeDetailTableViewController(self, didSave: employee)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        employee = nil
    }
    
    @IBAction func nameTextFieldDidChange(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        dobLabel.text = sender.date.formatted(date: .abbreviated, time: .omitted)
    }
    
    @IBSegueAction func showEmployeeType(_ coder: NSCoder) -> EmployeeTypeTableViewController? {
        let detailViewController = EmployeeTypeTableViewController(coder: coder)
        
        // Pass the current employee type to the EmployeeTypeTableViewController
        detailViewController?.employeeType = selectedEmployeeType
        detailViewController?.delegate = self // Set the delegate back to this view controller
        
        return detailViewController
    }
    
    
}
