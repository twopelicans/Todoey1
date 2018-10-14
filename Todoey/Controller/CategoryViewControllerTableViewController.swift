//
//  CategoryViewControllerTableViewController.swift
//  Todoey
//
//  Created by Roy Freeman on 11/10/2018.
//  Copyright © 2018 Roy Freeman. All rights reserved.
//

import UIKit
import CoreData


class CategoryViewControllerTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemArray = [Things]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()
        
    }
        
    //MARK TableView DataSource Methods
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return itemArray.count
        }
    
    
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
            
            let item = itemArray[indexPath.row]
            
            cell.textLabel?.text = item.name
            
            //cell.accessoryType = item.done ? .checkmark  : .none
            
            return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedThing = itemArray[indexPath.row]
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    
    //MARK: Add New Categories
            
            func saveCategory(){
                //TODO add Create Data Code
                do{
                    try context.save()
                }catch{
                    print("Error saving Context \(error)")
                }
                self.tableView.reloadData()
            }
            // func with external parameter (with) and internal parameter(request) and a default value of Item.Re... hence can call loaditems() with no arguments as default value is used.
            func loadCategory(with request: NSFetchRequest<Things> = Things.fetchRequest()){
                //TODO add Read Data Code
                
                do{
                    try itemArray = context.fetch(request)
                }catch{
                    print("Error in retrieving data \(error)")
                }
                
                tableView.reloadData()
                
            }

    

    
    @IBAction func adButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert )
        
        let action = UIAlertAction(title: "Add Category", style: .default){ (action) in
            //What will happen once the user clicks the add item button on our UI Alert
            
            
            let newItem = Things(context: self.context)
            newItem.name = textField.text!
            
            self.itemArray.append(newItem)
            self.saveCategory()
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

