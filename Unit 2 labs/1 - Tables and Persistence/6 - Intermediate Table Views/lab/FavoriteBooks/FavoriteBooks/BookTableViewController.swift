import UIKit

class BookTableViewController: UITableViewController {
    
    var books: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookTableViewCell

        let book = books[indexPath.row]
        cell.titleLabel.text = book.title
        cell.authorNameLabel.text = book.author
        cell.PagesNumberLabel.text = book.length
        cell.genreNameLabel.text = book.genre
        

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editBookSegue",
           let destinationVC = segue.destination as? BookFormTableViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.book = books[indexPath.row] // Pass book data
            destinationVC.bookIndex = indexPath.row  // Pass index

        }
    }

    // MARK: - Navigation
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        guard let source = segue.source as? BookFormTableViewController,
            let book = source.book else {return}
        
        if let indexPath = tableView.indexPathForSelectedRow {
            books.remove(at: indexPath.row)
            books.insert(book, at: indexPath.row)
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            books.append(book)
        }
    }
    
    @IBSegueAction func editBook(_ coder: NSCoder) -> BookFormTableViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow else { return nil }
        
        let book = books[indexPath.row]
        return BookFormTableViewController(coder: coder, book: book)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            books.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}
