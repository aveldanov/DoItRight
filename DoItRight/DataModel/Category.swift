//
//  Category.swift
//  DoItRight
//
//  Created by Veldanov, Anton on 4/10/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
  @objc dynamic var name:String = "" //dynamic - monitor for changes
  let items = List<Item>() //empty array of items - List===Array
  
}
