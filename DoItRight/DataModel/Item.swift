//
//  Item.swift
//  DoItRight
//
//  Created by Veldanov, Anton on 3/28/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import Foundation

// to conform to Codable protocol - all variables should be a standard class like - String, Bool etc
class Item: Codable {
  var title: String = ""
  var done: Bool = false
  
  
}
