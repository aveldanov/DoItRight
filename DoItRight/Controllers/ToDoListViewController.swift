//
//  ViewController.swift
//  DoItRight
//
//  Created by Veldanov, Anton on 3/25/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
  
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
    
    
    // Filemager - interface for filesystem
    
    
    //    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    
    
    // retrieve array from "defaults" memory
    //    if let safeItemArray = defaults.array(forKey: "TodoListArray") as? [Item]{
    //      itemArray = safeItemArray
    //    }
    
    
    // FileManager -> initiated request
    
  }
  //MARK: - TableView DataSource Methods
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todoItems?.count ?? 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    //    Not doing it because it creates a new cell when the exisitng cell is out of screen view
    //    let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    // indexPath contains SectionNumber and RowNumber
    //    print(indexPath.row)
    
    
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
    //    print(itemArray[indexPath.row])
    //Deleting items
    //    context.delete(itemArray[indexPath.row])
    //    itemArray.remove(at: indexPath.row)
    
    //    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
//    saveItems()
    
    self.tableView.reloadData()
    
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  
  //MARK: - Add a new item
  
  
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
    var textField = UITextField()
    
    
    
    let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
      // user clicked
      
      
      
//      let newItem = Item(context: self.context)
//      newItem.title = textField.text!
//      newItem.done = false
      //NEW because of category
      
//      newItem.parentCategory = self.selectedCategory
//      self.itemArray.append(newItem)
      
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
  
  
  
 
  
  
  func loadItems(){

    todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
    
    tableView.reloadData()

  }
  
  
  
}


//MARK: - Search Bar Methods
//
//extension ToDoListViewController: UISearchBarDelegate{
//
//  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//    let request : NSFetchRequest<Item> = Item.fetchRequest()
//    //    print(searchBar.text!)
//    // look for the "title" that "CONTAINS" ...
//    // %@ will be replaced with - searchBar.text data
//    // [cd] - makes case/special symbols non-sesitive
//    let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//    //sort by title
//    request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)] // as it expects an array
//
//
//    loadItems(with: request, predicate: predicate)
//
//
//    //    do{
//    //     itemArray = try context.fetch(request)
//    //    }catch{
//    //      print(error)
//    //    }
//    //
//    //    tableView.reloadData()
//
//  }
//
//  // SearchBar Text Change - listener
//
//  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//    if searchBar.text?.count == 0{
//      loadItems()
//
//      DispatchQueue.main.async {
//              searchBar.resignFirstResponder()
//      }
//    }
//  }
//
//}

