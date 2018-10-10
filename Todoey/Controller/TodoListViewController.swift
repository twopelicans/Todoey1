//
//  ViewController.swift
//  Todoey
//
//  Created by Roy Freeman on 10/10/2018.
//  Copyright © 2018 Roy Freeman. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
        var itemArray = [TodoModel]()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
//            let newItem = TodoModel()
//            newItem.title = "Find Mike"
//            itemArray.append(newItem)
//
//            let newItem1 = TodoModel()
//            newItem1.title = "Buy Eggs"
//            itemArray.append(newItem1)
//
//            let newItem2 = TodoModel()
//            newItem2.title = "Kill Dragon"
//            itemArray.append(newItem2)
            
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
        let newItem = TodoModel()
            newItem.title = textField.text!
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
        // add Create Data Code
    }
    
    func loadItems(){
        //add Read Data Code
    }
    
    func updateItems(){
        //add Update Data Code
    }
    
    func deleteItems(){
        //add Delete Data Code
    }
    
}

