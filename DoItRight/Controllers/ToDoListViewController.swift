//
//  ViewController.swift
//  DoItRight
//
//  Created by Veldanov, Anton on 3/25/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class ToDoListViewController: SwipeTableViewController {
  
  var todoItems: Results<Item>?
  let realm = try! Realm()
  
  @IBOutlet weak var searchBar: UISearchBar!
  
  
  var selectedCategory: Category?
  {
    // works only if selectedCategory is assigned a value
    didSet{
      loadItems()
    }
  }
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //    if let colorHex = selectedCategory?.color{
    //
    //
    //      // problem viewDidLoad called before navBar added -> we need viewWillAppear
    //      guard let navBar = navigationController?.navigationBar else {
    //        fatalError("No Nav Controller")
    //      }
    //
    //        navigationController?.navigationBar.barTintColor = UIColor(hexString: colorHex)
    //    }
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    
    
    if let colorHex = selectedCategory?.color{
      
      title = selectedCategory?.name
      
      // problem viewDidLoad called before navBar added -> we need viewWillAppear
      guard let navBar = navigationController?.navigationBar else {
        fatalError("No Nav Controller")
      }
      
      if let navBarColor = UIColor(hexString: colorHex) {
        //Original setting: navBar.barTintColor = UIColor(hexString: colourHex)
        //Revised for iOS13 w/ Prefer Large Titles setting:
        navBar.backgroundColor = navBarColor
        navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)
        searchBar.barTintColor = navBarColor
   
      }
      
    }
    
    
  }
  
  
  
  
  
  //MARK: - TableView DataSource Methods
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return todoItems?.count ?? 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = super.tableView(tableView, cellForRowAt: indexPath)
    if let item = todoItems?[indexPath.row]{
      cell.textLabel?.text = item.title
      
      
      // OPTIONAL Chaining - the "?" after ".color)?"...if not nil then go ahead
      if let color = UIColor(hexString: selectedCategory!.color)?.darken(byPercentage:
        CGFloat(indexPath.row) / CGFloat(todoItems!.count)
        ){
        cell.backgroundColor = color
        cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
      }
      
      
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
          
          //          realm.delete(item)
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
  
  
  
  
  //Mark - Model Manipulation Methods
  
  
  func loadItems(){
    
    todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
    
    tableView.reloadData()
    
  }
  
  
  
  override func updateModel(at indexPath: IndexPath) {
    
    if let item = todoItems?[indexPath.row]{
      do{
        try realm.write{
          realm.delete(item)
        }
      }catch{
        print("Error didSelectAt - done status", error)
      }
      
    }
    
    
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

