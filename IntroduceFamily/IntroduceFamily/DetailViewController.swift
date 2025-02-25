//
//  DetailViewController.swift
//  IntroduceFamily
//
//  Created by Hayden Boss on 2/24/25.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var familyImageView: UIImageView!
    @IBOutlet weak var familyNameLabel: UILabel!
    @IBOutlet weak var familyAgeLabel: UILabel!
    @IBOutlet weak var familyJobLabel: UILabel!
    @IBOutlet weak var familyHobbiesLabel: UILabel!
    var familyMember: FamilyMember?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(familyMember?.name)
        guard let familyMember = familyMember else { return }
        familyImageView.image = UIImage(named: familyMember.name)
        familyNameLabel.text = familyMember.name
        familyAgeLabel.text = "\(familyMember.age) years old"
        if let occupation = familyMember.occupation {
            familyJobLabel.text = "Occupation: \(occupation))"
        }
        familyHobbiesLabel.text = "Hobbies: \(familyMember.hobbies?.joined(separator: ", ") ?? "No hobbies"))"
    }
    
}
