//
//  CategoryViewController.swift
//  DoItRight
//
//  Created by Veldanov, Anton on 4/8/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
  
  let realm = try! Realm()
  
  var categoryArray: Results<Category>?
  

  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadCategories()
  }
  
  
  
  //MARK: - TableView DataSource Methods
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categoryArray?.count ?? 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
    
    cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Added Yet"
    
    return cell
    
  }
  
  
  
  
  
  //MARK: - TableView delegate methods
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "goToItems", sender: self)
    
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destinationVC = segue.destination as! ToDoListViewController
    // indexPath for selected row
    if let indexPath = tableView.indexPathForSelectedRow{
      
      destinationVC.selectedCategory = categoryArray?[indexPath.row]
      
    }
  }
  
  
  
  
  
  
  
  //MARK: - Data manipulation methods (Save/Load)
  
  func saveCategories(category:Category){
    // Working with local files
    do{
      try realm.write{
        realm.add(category)
      }
    }catch{
      print("Error: ", error)
    }
    
    tableView.reloadData()
    
  }
  
  
  
  func loadCategories(){
    
    categoryArray = realm.objects(Category.self)
    

    tableView.reloadData()
    
  }
  
  
  
  
  //MARK: - add new category
  
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
    var textField = UITextField()
    
    
    let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
    let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
      // user clicked
      
      let newCategory = Category()
      
      newCategory.name = textField.text!
      
      
      //      self.defaults.set(self.itemArray, forKey: "TodoListArray")
      
      self.saveCategories(category: newCategory)
      
      
      //      self.tableView.reloadData()
      
    }
    
    alert.addTextField { (alertTextField) in
      alertTextField.placeholder = "Create New Category"
      textField = alertTextField
    }
    
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
    
    
  }
  
  
  
  
  
  
  
  
  
  
}
