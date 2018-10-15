//
//  ViewController.swift
//  Todoey
//
//  Created by Roy Freeman on 10/10/2018.
//  Copyright © 2018 Roy Freeman. All rights reserved.
//

import UIKit
import RealmSwift


class TodoListViewController: UITableViewController {
    
        
    var todoItems: Results<Item>?
    let realm = try! Realm()
    var selectedThing : Things? {
        didSet{
            //print (selectedThing!)
           loadItems()
        }
    }
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
   
            
        }

//MARK - Tableview Daatasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
 
        //bit of refactoring
        
        if let item = todoItems?[indexPath.row]{
        
        cell.textLabel?.text = item.title
            
        //   use the ternary operator
        //
        //      value              = condition ? valueIfTrue : valueIffalse
        cell.accessoryType = item.done ? .checkmark  : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
//
       
        return cell
    }
    
//MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if let item = todoItems?[indexPath.row]{
            do{
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print ("Error saving done status")
            }
        }
        
        tableView.reloadData()
       
//        todoItems[indexPath.row].done = !todoItems[indexPath.row].done
//
//        saveItems()
        
        
        tableView.deselectRow(at: indexPath, animated: true) // doesnt seem to work??
        
    }
    
    
//MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
      
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New To Do", message: "", preferredStyle: .alert )
        
        let action = UIAlertAction(title: "Add Item", style: .default){ (action) in
            //What will happen once the user clicks the add item button on our UI Alert
        
            if let currentCategory = self.selectedThing{
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print ("Error  saving new items, \(error)")
                }
            }
                
            self.tableView.reloadData()
       
        }
        alert.addTextField{ (alertTextField) in
        alertTextField.placeholder = "Create New Item"
        textField = alertTextField
            
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
          
        }
        
    }
    
////MARK manipulate data model methods

    func loadItems(){
        
        todoItems = selectedThing?.items.sorted(byKeyPath: "title", ascending: true)
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
       
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
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

