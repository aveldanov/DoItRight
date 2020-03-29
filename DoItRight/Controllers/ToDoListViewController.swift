//
//  ViewController.swift
//  DoItRight
//
//  Created by Veldanov, Anton on 3/25/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

//  var itemArray = ["TODO1", "TODO2", "TODO3"]
  
  var itemArray = [Item]()
  
  
  
  let defaults = UserDefaults.standard
  
  
  override func viewDidLoad() {
    super.viewDidLoad()

    let newItem = Item()
    newItem.title = "TODO11"
    itemArray.append(newItem)
    
    
    let newItem2 = Item()
      newItem2.title = "TODO22"
      itemArray.append(newItem2)
    
    let newItem3 = Item()
      newItem3.title = "TODO33"
      itemArray.append(newItem3)
    
    
    
    print(itemArray)
    
    
    
    //    if let safeItemArray = defaults.array(forKey: "TodoListArray") as? [String]{
//      itemArray = safeItemArray
//
      
    }

  }
//MARK: - TableView DataSource Methods
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
// indexPath contains SectionNumber and RowNumber
//    print(indexPath.row)
    cell.textLabel?.text = itemArray[indexPath.row].title
    return cell
  }
  
  
//MARK: - TableView Delegate Method
  
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(itemArray[indexPath.row])
  
    
    if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
      tableView.cellForRow(at: indexPath)?.accessoryType = .none
    } else {
      
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  
  //MARK: - Add a new item
  
  
  
  
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
    var textField = UITextField()
    
    
    
    let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
      // user clicked
      print(textField.text)
      
      self.itemArray.append(textField.text!)
      
      self.defaults.set(self.itemArray, forKey: "TodoListArray")
      
      
      
      self.tableView.reloadData()
      
    }
    alert.addTextField { (alertTextField) in
      alertTextField.placeholder = "Create New Item"
      textField = alertTextField
    }
    alert.addAction(action)
    
    
    present(alert, animated: true, completion: nil)
    
  }
  
  
}

