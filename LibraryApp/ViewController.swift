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

    func addBook() {
        newBook = Book(title: titleField.text, author: authorField.text, genre: genreField.text, length: Int(numberOfPagesField.text!))
        userLibrary.books.append(newBook)
        clearTextFields()
        viewLibrary()
    }

// Perfoms a check for duplicate book titles.  Will return a 0 for no and 1 for yes.
    func duplicateCheck(bookToAdd: String?) -> Int {
        var duplicateCount = 0
        for (_, value) in userLibrary.books.enumerate() {
            if bookToAdd != value.title {
                continue
            } else {
                duplicateCount++
            }
        }
        return duplicateCount
    }

// Uses the return from the duplicateCheck function above to either allow a new book to be added or denied.
    func appendUserLibrary() {
        let duplicateTitleCount = duplicateCheck(titleField.text!)
        if duplicateTitleCount == 0 {
            addBook()
        } else {
            titleField.text = ""
            titleField.placeholder = "Title already exists."
        }
    }

    func deleteBook() {
        for (index, value) in userLibrary.books.enumerate() {
            if titleField.text == value.title! {
                userLibrary.books.removeAtIndex(index)
            }
        }
        clearTextFields()
        viewLibrary()
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
            switch userLibrary.books.count {
             case 0:
                addBook()
                
            default:
                duplicateCheck(titleField.text!)
                appendUserLibrary()
            }
        }
    }
    
    @IBAction func deleteBookButton(sender: UIButton) {
        deleteBook()
    }

    func viewLibrary() {
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
  