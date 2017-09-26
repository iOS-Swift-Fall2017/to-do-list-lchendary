//
//  ViewController.swift
//  To Do List
//
//  Created by Linda Chen on 9/25/17.
//  Copyright © 2017 Synestha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    var defaultsData = UserDefaults.standard
    
    var toDoArray = [String]()
    var notesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
        toDoArray = defaultsData.stringArray(forKey: "toDoArray") ?? [String]()
        notesArray = defaultsData.stringArray(forKey: "notesArray") ?? [String]()
        
        
        let backgroundImage = UIImage(named: "MacDaddy Background_Purple")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        
    }
    
    
    func saveDefaultsData() {
        //Save user defaults.
        defaultsData.set(toDoArray, forKey: "toDoArray")
        defaultsData.set(notesArray, forKey: "notesArray")
    }
    
    //What happens when you want to add or edit an item?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        //If we're editing an old item, remember the index path and edit that item.
        if segue.identifier == "EditItem" {
            let destination = segue.destination as! DetailVC
            let index = tableView.indexPathForSelectedRow!.row
            destination.toDoItem = toDoArray[index]
            destination.note = notesArray[index]
        }else{
        //If we're making a new item, we must deselect any previous selections that were made.
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: false)
            }
        }
    }
    
    
    //Connected as an exit path from the save button.
    @IBAction func unwindFromDetailVC(segue: UIStoryboardSegue){
        let sourceViewController = segue.source as! DetailVC
        //If you were editing an old item, update the data in the array and reload the rows.
        if let indexPath = tableView.indexPathForSelectedRow{
            toDoArray[indexPath.row] = sourceViewController.toDoItem!
            notesArray[indexPath.row] = sourceViewController.note!
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }else{
        //If you were creating a new item, add the new item to the array.
            let newIndexPath = IndexPath(row: toDoArray.count, section: 0)
            toDoArray.append(sourceViewController.toDoItem!)
            notesArray.append(sourceViewController.note!)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        
        saveDefaultsData()
        
    }
    
    @IBAction func editBarButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
        //What happens when you're done editing?
            tableView.setEditing(false, animated: true)
            editBarButton.title = "Edit"
            addBarButton.isEnabled = true
        }else{
        //What happens when you start editing?
            tableView.setEditing(true, animated: true)
            editBarButton.title = "Done"
            addBarButton.isEnabled = false
        }
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    //How many rows?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }
    
    //Which cell goes in what row?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = toDoArray[indexPath.row]
        cell.detailTextLabel?.text = notesArray[indexPath.row]
        
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = .clear
        
        return cell
    }
    
    
    //Deleting stuff.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDoArray.remove(at: indexPath.row)
            notesArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveDefaultsData()
        }
        
    }
    
    //Moving stuff.
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //Make a temporary copy.
        let itemToMove = toDoArray[sourceIndexPath.row]
        toDoArray.remove(at: sourceIndexPath.row)
        toDoArray.insert(itemToMove, at: destinationIndexPath.row)
        
        let noteToMove = notesArray[sourceIndexPath.row]
        notesArray.remove(at: sourceIndexPath.row)
        notesArray.insert(noteToMove, at: destinationIndexPath.row)
        
        saveDefaultsData()
    }
    
}

