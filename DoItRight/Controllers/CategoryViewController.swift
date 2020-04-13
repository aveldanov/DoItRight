//
//  CategoryViewController.swift
//  DoItRight
//
//  Created by Veldanov, Anton on 4/8/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController  {
  
  let realm = try! Realm()
  
  var categoryArray: Results<Category>?
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadCategories()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.")
    }
    navBar.backgroundColor = UIColor(hexString: "#1D9BF6")
  }
  
  
  
  //MARK: - TableView DataSource Methods
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categoryArray?.count ?? 1
  }
  
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    // inherit cell from super class (Swipe)
    
    let cell = super.tableView(tableView, cellForRowAt: indexPath)
    
    if let category = categoryArray?[indexPath.row]{
      cell.textLabel?.text = category.name ?? "No Categories Added Yet"
      
      cell.backgroundColor = UIColor(hexString: category.color ?? "64D2FF")
      
    }
    
    
    
    
    
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
  //MARK: - Save Section
  
  
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
  
  //MARK: - Load Section
  
  
  func loadCategories(){
    
    categoryArray = realm.objects(Category.self)
    
    
    tableView.reloadData()
    
  }
  
  //MARK: - Delete Section
  
  override func updateModel(at indexPath: IndexPath) {
    
    super.updateModel(at: indexPath)
    
    
    if let categoryForDeletion = self.categoryArray?[indexPath.row]{
      
      do{
        try self.realm.write{
          self.realm.delete(categoryForDeletion)
          
        }
      }catch{
        print("delete row error \(error)")
      }
      
      
    }
  }
  
  
  
  
  
  
  
  //MARK: - add new category
  
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
    var textField = UITextField()
    
    
    let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
    let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
      // user clicked
      
      let newCategory = Category()
      
      newCategory.name = textField.text!
      newCategory.color = UIColor.randomFlat().hexValue()
      
      
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


