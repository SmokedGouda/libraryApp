//
//  ViewController.swift
//  LibraryApp
//
//  Created by Craig Carlson on 9/30/15.
//  Copyright © 2015 Craig Carlson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var genreField: UITextField!
    @IBOutlet weak var numberOfPagesField: UITextField!
    
    @IBOutlet weak var bookOneLabel: UILabel!
    @IBOutlet weak var bookTwoLabel: UILabel!
    @IBOutlet weak var bookThreeLabel: UILabel!
    @IBOutlet weak var bookFourLabel: UILabel!
    
    
    var userLibrary = Library()
    var newBook = Book()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        clearTextFields()
        bookOneLabel.text = nil
        bookTwoLabel.text = nil
        bookThreeLabel.text = nil
        bookFourLabel.text = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
// Enumeration check isn't working because if a title doesn't match any other title before it finds a match, all previous non-matches will allow a book to be created.
    func duplicateBookCheck (bookTitle: String?) {
        for (_, value) in userLibrary.books.enumerate() {
            let titleToCheck = bookTitle
            if titleToCheck == value.title {
                titleField.text = ""
                titleField.placeholder = "Title already exists"
                print("The duplicate book check succeeded. Book is a duplicate.")
            } else {
                newBook = Book(title: titleField.text, author: authorField.text, genre: genreField.text, length: Int(numberOfPagesField.text!))
                userLibrary.books.append(newBook)
                clearTextFields()
                print(userLibrary.books.count)
                print("The duplicate book check succeeded.  Book is a new book.")
            }
        }
    }

    func deleteBook() {
        for (index, value) in userLibrary.books.enumerate() {
            print(index, value)
            if titleField.text == value.title! {
                userLibrary.books.removeAtIndex(index)
                print(index, value)
            }
        }
        clearTextFields()
    }
    
    func clearTextFields() {
        titleField.text = ""
        authorField.text = ""
        genreField.text = ""
        numberOfPagesField.text = ""
        titleField.placeholder = ""
    }
    
    @IBAction func addBookButton(sender: UIButton) {
        if titleField.text == "" {
            titleField.placeholder = "You must enter a book title."
        } else {
            
            let bookCount = userLibrary.books.count
            switch bookCount {
             case 0:
                newBook = Book(title: titleField.text, author: authorField.text, genre: genreField.text, length: Int(numberOfPagesField.text!))
                userLibrary.books.append(newBook)
                clearTextFields()
                print(userLibrary.books.count)
            default:
                duplicateBookCheck(titleField.text)
            }
        }
    }
    @IBAction func deleteBookButton(sender: UIButton) {
        deleteBook()
    }

    @IBAction func viewLibrary(sender: UIButton) {
        if userLibrary.books.count >= 4 {
            bookFourLabel.text = String(userLibrary.books[3])
            bookThreeLabel.text = String(userLibrary.books[2])
            bookTwoLabel.text = String(userLibrary.books[1])
            bookOneLabel.text = String(userLibrary.books[0])
        } else if userLibrary.books.count == 3 {
            bookFourLabel.text = nil
            bookThreeLabel.text = String(userLibrary.books[2])
            bookTwoLabel.text = String(userLibrary.books[1])
            bookOneLabel.text = String(userLibrary.books[0])
        } else if userLibrary.books.count == 2 {
            bookFourLabel.text = nil
            bookThreeLabel.text = nil
            bookTwoLabel.text = String(userLibrary.books[1])
            bookOneLabel.text = String(userLibrary.books[0])
        } else if userLibrary.books.count == 1 {
            bookFourLabel.text = nil
            bookThreeLabel.text = nil
            bookTwoLabel.text = nil
            bookOneLabel.text = String(userLibrary.books[0])
            //testBookButton.setTitle(String(userLibrary.books[0]), forState: .Normal)
        } else {
            bookFourLabel.text = nil
            bookThreeLabel.text = nil
            bookTwoLabel.text = nil
            bookOneLabel.text = nil
        }
    }
}
  