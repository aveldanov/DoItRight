//
//  SwipeTableViewController.swift
//  DoItRight
//
//  Created by Veldanov, Anton on 4/12/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import UIKit
import SwipeCellKit



class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
  
  
  var cell: UITableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
  
  
  //MARK: - TableViewDataSource Methods
  
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
    
    //    cell.delegate = self
    cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Added Yet"
    
    return cell
  }
  

  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
     
      
      guard orientation == .right else { return nil }
      
      let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
        print("Delete Cell")
        
        
        
        
//        if let categoryForDeletion = self.categoryArray?[indexPath.row]{
//
//          do{
//            try self.realm.write{
//              self.realm.delete(categoryForDeletion)
//
//              }
//          }catch{
//            print("delete row error \(error)")
//          }
//
//
//        }

    
      }
      
      // customize the action appearance
      deleteAction.image = UIImage(named: "delete-icon")
      
      return [deleteAction]
    }
    
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }

}

