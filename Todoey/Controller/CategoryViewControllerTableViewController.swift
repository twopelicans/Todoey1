//
//  CategoryViewControllerTableViewController.swift
//  Todoey
//
//  Created by Roy Freeman on 11/10/2018.
//  Copyright © 2018 Roy Freeman. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryViewControllerTableViewController: UITableViewController {
    
    let realm = try! Realm() // valid use of ! from Realm docs
    
   
    var itemArray: Results<Things>?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
      loadCategory()
        
    }
        
    //MARK TableView DataSource Methods
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return itemArray?.count  ?? 1
        }
    
    
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
            
            //let item = itemArray?[indexPath.row]
            
            cell.textLabel?.text =  itemArray?[indexPath.row].name ?? "No Categories Added Yet"
            
            //cell.accessoryType = item.done ? .checkmark  : .none
            
            return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedThing = itemArray?[indexPath.row]
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    
    //MARK: Add New Categories
            
    func save(category: Things){
                //TODO add Create Data Code
                do{
                    try realm.write {
                     realm.add(category)
                        
                    }
                }catch{
                    print("Error saving Context \(error)")
                }
                self.tableView.reloadData()
            }
            // func with external parameter (with) and internal parameter(request) and a default value of Item.Re... hence can call loaditems() with no arguments as default value is used.
    func loadCategory(){
                //TODO add Read Data Code
                itemArray = realm.objects(Things.self)
                tableView.reloadData()
                
            }

    

    
    @IBAction func adButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert )
        
        let action = UIAlertAction(title: "Add Category", style: .default){ (action) in
            //What will happen once the user clicks the add item button on our UI Alert
            
            
            let newItem = Things()
            newItem.name = textField.text!
            self.save(category: newItem)
            self.tableView.reloadData()
            
        }
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
            
            
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: TableView Delegate Methods
    
   
    
}

