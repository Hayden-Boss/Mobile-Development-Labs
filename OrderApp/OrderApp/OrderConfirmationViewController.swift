//
//  OrderConfirmationViewController.swift
//  OrderApp
//
//  Created by Hayden Boss on 5/12/25.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    @IBOutlet weak var confirmationLabel: UILabel!
    
    let minutesToPrepare: Int
    
    init?(coder: NSCoder, minutesToPrepare: Int) {
        self.minutesToPrepare = minutesToPrepare
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        confirmationLabel.text = "Thank you for your order! Your wait time is approximately \(minutesToPrepare) minutes."
    }
    
//    @IBAction func unwindToOrderList(segue: UIStoryboardSegue) {
//        if segue.identifier == "dismissConfirmation" {
//            MenuController.shared.order.menuItems.removeAll()
//        }
//    }
 
//    @IBAction func submitTapped(_ sender: Any) {
//        let orderTotal = MenuController.shared.order.menuItems.reduce(0.0) {
//            (result, menuItem) -> Double in
//            return result + menuItem.price
//        }
//        
//        let formattedTotal = orderTotal.formatted(.currency(code: "usd"))
//        
//        let alertController = UIAlertController(title: "Confirm Order", message: "You are about to submit your order with a total of \(formattedTotal)", preferredStyle: .actionSheet)
//        alertController.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
//            self.uploadOrder()
//        }))
//        
//        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        
//        present(alertController, animated: true, completion: nil)
//    }
//    
//    func uploadOrder() {
//        let menuIds = MenuController.shared.order.menuItems.map { $0.id }
//        Task.init {
//            do {
//                let minutesToPrepare = try await MenuController.shared.submitOrder(forMenuIDs: menuIds)
//                minutesToPrepareOrder = minutesToPrepare
//                performSegue(withIdentifier: "confirmOrder", sender: nil)
//            } catch {
//                displayError(error, title: "Order Submission Failed")
//            }
//        }
//    }
//    
//    func displayError(_ error: Error, title: String) {
//        guard let _ = viewIfLoaded?.window else { return }
//        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
//        self.present(alert,animated: true, completion: nil)
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
