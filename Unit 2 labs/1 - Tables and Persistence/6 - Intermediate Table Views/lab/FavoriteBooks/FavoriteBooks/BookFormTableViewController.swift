//
//  BookFormTableViewController.swift
//  FavoriteBooks
//
//  Created by Hayden Boss on 3/14/25.
//

import UIKit

protocol BookFormDelegate: AnyObject {
    func didUpdateBook(_ book: Book, at index: Int)
}

class BookFormTableViewController: UITableViewController {
    
    var book: Book?
    var bookIndex: Int?
    
    @IBOutlet var detailTitleTextField: UITextField!
    @IBOutlet var detailAuthorTextField: UITextField!
    @IBOutlet var detailGenreTextField: UITextField!
    @IBOutlet var detailLengthTextField: UITextField!
    
    init?(coder: NSCoder, book: Book?) {
        self.book = book
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        self.book = nil
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }

func updateView() {
    guard let book = book else {return}
    
    detailTitleTextField.text = book.title
    detailAuthorTextField.text = book.author
    detailGenreTextField.text = book.genre
    detailLengthTextField.text = book.length
}

    @IBAction func saveButtonTapped(_ sender: Any) {
    guard let title = detailTitleTextField.text,
        let author = detailAuthorTextField.text,
        let genre = detailGenreTextField.text,
        let length = detailLengthTextField.text else {return}

        book = Book(title: title, author: author, genre: genre, length: length)
    performSegue(withIdentifier: "UnwindToBookTable", sender: self)
}

}
