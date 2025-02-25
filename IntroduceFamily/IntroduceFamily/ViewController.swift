//
//  ViewController.swift
//  IntroduceFamily
//
//  Created by Hayden Boss on 2/24/25.
//

import UIKit
class FamilyMember {
    init(name: String, age: Int, occupation: String? = nil, hobbies: [String]? = nil) {
        self.name = name
        self.age = age
        self.occupation = occupation
        self.hobbies = hobbies
    }
    
    var name: String
    var age: Int
    var occupation: String?
    var hobbies: [String]?
}
class ViewController: UIViewController {
    
    @IBOutlet weak var momButton: UIButton!
    @IBOutlet weak var dadButton: UIButton!
    @IBOutlet weak var courtneyButton: UIButton!
    @IBOutlet weak var connorButton: UIButton!
    @IBOutlet weak var hadleyButton: UIButton!
    @IBOutlet weak var haydenButton: UIButton!
    var familyMember: FamilyMember?
   
    var familyMembers: [FamilyMember] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
       

       
        let dad = FamilyMember(name: "David", age: 45, occupation: "IT manager", hobbies: ["3D Printing", "Cooking", "laser engraving"])
        let mom = FamilyMember(name: "Becky", age: 42, occupation: "Realtor, Hair Sytlist", hobbies: ["watching TV", "reading", "cooking"])
        let courtney = FamilyMember(name: "Courtney", age: 31, occupation: "HOA Something", hobbies: ["School", "Sporting Events"
        ])
        let connor = FamilyMember(name: "Connor", age: 28, occupation: "Police Officer")
        let hadley = FamilyMember(name: "Hadley", age: 24, occupation: "No Clue")
        let hayden = FamilyMember(name: "Hayden", age: 21, hobbies: ["Videogames", "Anime", "Hanging Out With Friends"])
        
        familyMembers.append(dad)
        familyMembers.append(mom)
        familyMembers.append(courtney)
        familyMembers.append(connor)
        familyMembers.append(hadley)
        familyMembers.append(hayden)
        
    }
    @IBAction func momButtonTapped(_ sender: Any) {
        self.familyMember = familyMembers.first(where: { $0.name == "Becky" })
        performSegue(withIdentifier: "familyIdentity", sender: nil)
    }
    @IBAction func dadButtonTapped(_ sender: Any) {
        familyMember = familyMembers.first(where: { $0.name == "David" })
        performSegue(withIdentifier: "familyIdentity", sender: nil)
    }
    @IBAction func courtneyButtonTapped(_ sender: Any) {
        familyMember = familyMembers.first(where: { $0.name == "Courtney" })
        performSegue(withIdentifier: "familyIdentity", sender: nil)
    }
    @IBAction func connorButtonTapped(_ sender: Any) {
        familyMember = familyMembers.first(where: { $0.name == "Connor" })
        performSegue(withIdentifier: "familyIdentity", sender: nil)
    }
    @IBAction func hadleyButtonTapped(_ sender: Any) {
        familyMember = familyMembers.first(where: { $0.name == "Hadley" })
        performSegue(withIdentifier: "familyIdentity", sender: nil)
    }
    @IBAction func haydenButtonTapped(_ sender: Any) {
        familyMember = familyMembers.first(where: { $0.name == "Hayden" })
        performSegue(withIdentifier: "familyIdentity", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationVC = segue.destination as! DetailViewController
        destinationVC.familyMember = self.familyMember
    }
    

}

