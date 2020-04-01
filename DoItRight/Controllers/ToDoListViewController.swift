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
      let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Filemager - interface for filesystem

    
    print(dataFilePath)
  
    
    print(itemArray)
    
    
    // retrieve array from "defaults" memory
//    if let safeItemArray = defaults.array(forKey: "TodoListArray") as? [Item]{
//      itemArray = safeItemArray
//    }
    
    
    // FileManager
    loadItems()
    
    
  }
  //MARK: - TableView DataSource Methods
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    //    Not doing it because it creates a new cell when the exisitng cell is out of screen view
    //    let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    // indexPath contains SectionNumber and RowNumber
    //    print(indexPath.row)
    
    let item = itemArray[indexPath.row]
    cell.textLabel?.text = item.title
    
    // value = condition ? valuetrue : valuefalse
    
    cell.accessoryType = item.done ? .checkmark : .none
    
    return cell
  }
  
  
  //MARK: - TableView Delegate Method
  
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(itemArray[indexPath.row])
    
    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
    saveItems()
    
    self.tableView.reloadData()
    
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  
  //MARK: - Add a new item
  
  
  
  
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
    var textField = UITextField()
    
    
    
    let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
      // user clicked
      
      let newItem = Item()
      newItem.title = textField.text!
      
      self.itemArray.append(newItem)
      
//      self.defaults.set(self.itemArray, forKey: "TodoListArray")

      self.saveItems()
      
      
      self.tableView.reloadData()
      
    }
    alert.addTextField { (alertTextField) in
      alertTextField.placeholder = "Create New Item"
      textField = alertTextField
    }
    alert.addAction(action)
    
    
    present(alert, animated: true, completion: nil)
    
  }
  
  
  
  func saveItems(){
    // Working with local files
    let encoder = PropertyListEncoder()
    
    do{
      // encoding out data into a property list
      let data = try encoder.encode(itemArray)
      try data.write(to: dataFilePath!)
    }catch{
      print("Error: ", error)
      
    }
    
    
  }
  
  
  func loadItems(){
    
    if let data = try? Data(contentsOf: dataFilePath!){
      let decoder = PropertyListDecoder()
      
      do{
        itemArray = try decoder.decode([Item].self, from: data)

      }catch{
        print(error)
      }
      
    }
    
  }
  

  
  
}

