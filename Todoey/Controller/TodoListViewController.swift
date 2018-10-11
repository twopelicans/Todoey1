//
//  ViewController.swift
//  Todoey
//
//  Created by Roy Freeman on 10/10/2018.
//  Copyright © 2018 Roy Freeman. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var itemArray = [Item]()
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            
            loadItems()
    
        }

//MARK - Tableview Daatasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
 
        //bit of refactoring
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title

//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
//
//       or use the ternary operator
//
//      value              = condition ? valueIfTrue : valueIffalse
        cell.accessoryType = item.done ? .checkmark  : .none
       
        return cell
    }
    
//MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.reloadData() // needed as the done property defaults to false for new items hence to see if any items were selected ie done = true means data needs reloading.
        tableView.deselectRow(at: indexPath, animated: true) // doesnt seem to work??
        
    }
    
//MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New To Do", message: "", preferredStyle: .alert )
        
        let action = UIAlertAction(title: "Add Item", style: .default){ (action) in
            //What will happen once the user clicks the add item button on our UI Alert
        
        
        let newItem = Item(context: self.context)
        newItem.title = textField.text!
        newItem.done = false
        self.itemArray.append(newItem)
        self.saveItems()
        self.tableView.reloadData()
            
        }
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            
            
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
//MARK manipulate data model methods
    func saveItems(){
//TODO add Create Data Code
        do{
            try context.save()
        }catch{
            print("Error saving Context \(error)")
        }
        self.tableView.reloadData()
    }
    // func with external parameter (with) and internal parameter(request) and a default value of Item.Re... hence can call loaditems() with no arguments as default value is used.
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()){
//TODO add Read Data Code
        
        do{
            try itemArray = context.fetch(request)
        }catch{
            print("Error in retrieving data \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func updateItems(){
//TODO add Update Data Code
        
    }
    
    func deleteItems(){
//TODO add Delete Data Code
        
    }
    
    
    
}
//MARK: Search Bar Methods
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
//        request.sortDescriptors = [sortDescriptor]
//          replaced with let request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)
        
       
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
           loadItems() //with default
            // UI stuff is on main thread so to get rid of cursor and keyboard from view we need to get the queue and call the resign....
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
           
        }
    }
    
}

