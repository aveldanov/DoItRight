//
//  CategoryViewController.swift
//  DoItRight
//
//  Created by Veldanov, Anton on 4/8/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
  
  var categoryArray = [Category]()
  
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadCategories()
  }
  
  
  
  //MARK: - TableView DataSource Methods
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categoryArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
    
    let category = categoryArray[indexPath.row]
    cell.textLabel?.text = category.name
    
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
      
      destinationVC.selectedCategory = categoryArray[indexPath.row]
      
    }
  }
  
  
  
  
  
  
  
  //MARK: - Data manipulation methods (Save/Load)
  
  func saveCategories(){
    // Working with local files
    do{
      try context.save()
    }catch{
      print("Error: ", error)
    }
    
    tableView.reloadData()
    
  }
  
  
  
  func loadCategories(){
    
    let request : NSFetchRequest<Category> = Category.fetchRequest()
    
    do{
      
      categoryArray = try context.fetch(request)
      
    }catch{
      print(error)
    }
    
    tableView.reloadData()
    
  }
  
  
  
  
  //MARK: - add new category
  
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
    var textField = UITextField()
    
    
    let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
    let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
      // user clicked
      
      let newCategory = Category(context: self.context)
      
      newCategory.name = textField.text!
      
      self.categoryArray.append(newCategory)
      
      //      self.defaults.set(self.itemArray, forKey: "TodoListArray")
      
      self.saveCategories()
      
      
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
