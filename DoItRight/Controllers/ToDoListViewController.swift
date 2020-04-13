//
//  ViewController.swift
//  DoItRight
//
//  Created by Veldanov, Anton on 3/25/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: SwipeTableViewController {
  
  //  var itemArray = ["TODO1", "TODO2", "TODO3"]
  
  var todoItems: Results<Item>?
  let realm = try! Realm()
  
  var selectedCategory: Category?
  
  {

    // works only if selectedCategory is assigned a value
    didSet{

      loadItems()
    }
  }
  
  

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  //MARK: - TableView DataSource Methods
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todoItems?.count ?? 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

    
    if let item = todoItems?[indexPath.row]{
      cell.textLabel?.text = item.title
      // value = condition ? valuetrue : valuefalse
      cell.accessoryType = item.done ? .checkmark : .none
    }else{
      
      cell.textLabel?.text = "No Items Added"
    }
    return cell
  }
  
  
  //MARK: - TableView Delegate Method
  
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    if let item = todoItems?[indexPath.row]{
      do{
        try realm.write{
          
//          realm.delete(item) - DELETE OPTION
           item.done = !item.done
         }
         
        
      }catch{
        
        print("Error didSelectAt - done status", error)
      }
 
    }
    
    tableView.reloadData()
 
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  
  //MARK: - Add a new item
  
  
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
    var textField = UITextField()
    
    
    
    let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
      // user clicked
      print(self.selectedCategory ?? "No CAT")
      if let currentCategory = self.selectedCategory{
        print(currentCategory)
        do{
          try self.realm.write{
            let newItem = Item()
            print(newItem)
             newItem.title = textField.text!
            newItem.dateCreated = Date()
            currentCategory.items.append(newItem)
          }
        }catch{
          print("Error saving Items: \(error)")
          
        }

        
      }

      self.tableView.reloadData()
      
    }
    
    alert.addTextField { (alertTextField) in
      alertTextField.placeholder = "Create New Item"
      textField = alertTextField
    }
    
    alert.addAction(action)
    
    
    present(alert, animated: true, completion: nil)
    
  }
  
  
  
 
  
  
  func loadItems(){

    todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
    
    tableView.reloadData()

  }
  
  
  
}


//MARK: - Search Bar Methods

extension ToDoListViewController: UISearchBarDelegate{

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
    
    tableView.reloadData()

  }
  
  
  
  

  // SearchBar Text Change to nothing - listener

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchBar.text?.count == 0{
      loadItems()

      DispatchQueue.main.async {
              searchBar.resignFirstResponder()
      }
    }
  }

}

