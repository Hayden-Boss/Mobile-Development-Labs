//
//  PostsTableViewController.swift
//  TechSocialMediaApp
//
//  Created by Hayden Boss on 3/31/25.
//

import UIKit

class PostsTableViewController: UITableViewController {
    
    var posts: [Post] = [
        Post(imageTitle: "Image1", user: "Heebs", title: "Bingus asdfaf asdfasfasd asdfasdfasdf asdf end here.", date: "01/01/1991", bodyText: "Bingus is a cool cat", commentText: ["Thats the ugliest thing I've ever seen", "What a good... cat"]),
        Post(imageTitle: "Image2", user: "Heebs", title: "Lazy", date: "12/28/1990", bodyText: "Just laying around", commentText: ["What a cutie!"]),
        Post(imageTitle: "Image3", user: "Heebs", title: "Penguin", date: "12/27/1990", bodyText: "My favorite animal from my favorite movie", commentText: ["Thats so cool!"]),
        Post(imageTitle: "Image4", user: "Heebs", title: "My camry", date: "12/26/1990", bodyText: "My car is so rad", commentText: ["Wow! You should get sponsored!"]),
        Post(imageTitle: "Image5", user: "Heebs", title: "Toad", date: "12/25/1990", bodyText: "Me in the bath", commentText: ["This is so relatable"]),
        Post(imageTitle: "Image6", user: "Heebs", title: "Snowboard", date: "12/24/1990", bodyText: "Check out this sick method", commentText: ["You look like a pro!"]),
        Post(imageTitle: "Image7", user: "Heebs", title: "Huh??", date: "12/23/1990", bodyText: "Me when someone says something stupid", commentText: ["Mr beans"]),
        Post(imageTitle: "Image8", user: "Heebs", title: "Mrs. Puff", date: "12/22/1990", bodyText: "Flabbergasted", commentText: ["What is this?"]),
        Post(imageTitle: "Image9", user: "Heebs", title: "Messy dog", date: "12/21/1990", bodyText: "Bed Head", commentText: ["Thats so cute!", "I wish I had a dog", "Stop messing up her hair!"]),
        Post(imageTitle: "Image10", user: "Heebs", title: "Pretty", date: "12/20/1990", bodyText: "Cliff jumped from here", commentText: ["That looks so fun!", "I wish I could do that"])
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        let post = posts[indexPath.row]
        
        cell.titleLabel.text = post.title
        cell.userLabel.text = post.user
        cell.dateLabel.text = post.date
        cell.bodyTextLabel.text = post.bodyText
        let commentsText = post.commentText.joined(separator: "\n")
        cell.commentTextLabel.text = commentsText
        cell.postImage.image = UIImage(named: post.imageTitle)
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        // create a UIView
//        
//        
//        // set background color on UIView
//        
//        // add label as a subview of the UIView
//        let label = UILabel()
//        label.text = "Socially"
//        label.backgroundColor = UIColor.systemBackground
//        
//        
//        // add constraints to label centering it in the UIView
//        
//        // return the UIView
//        
//        
////        label.font = UIFont(name: "noteworthy", size: 38)
//        
//        return label
//    }
    
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
