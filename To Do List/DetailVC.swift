//
//  DetailVC.swift
//  To Do List
//
//  Created by Linda Chen on 9/25/17.
//  Copyright © 2017 Synestha. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var toDoField: UITextField!
    @IBOutlet weak var noteView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var toDoItem:String?
    var note:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let toDoItem = toDoItem {
            toDoField.text = toDoItem
            self.navigationItem.title = "Edit Item"
        } else {
            self.navigationItem.title = "New Item"
        }
        
        if let note = note {
            noteView.text = note
        }
        
        toDoField.becomeFirstResponder()
        enableDisableSaveButton()
    }

    //When you press save, the text that you entered becomes the updated ToDoItem.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindFromSave" {
            toDoItem = toDoField.text
            note = noteView.text
        }
    }
    

    @IBAction func toDoFieldChanged(_sender: UITextField) {
        enableDisableSaveButton()
    }
    
    //Disable save if there's nothing there.
    func enableDisableSaveButton() {
        if let toDoFieldCount = toDoField.text?.count, toDoFieldCount > 0 {
            saveButton.isEnabled = true
        }else{
            saveButton.isEnabled = false
        }
    }
    
    //If you press cancel, dismiss the view without doing anything to do the data.
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            //If you were adding something, then dismiss it.
            dismiss(animated: true, completion: nil)
        } else {
            //If you were editing something, then pop it.
            navigationController?.popViewController(animated: true)
        }
    }
        
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
