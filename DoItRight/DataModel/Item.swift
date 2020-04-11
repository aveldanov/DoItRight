//
//  Item.swift
//  DoItRight
//
//  Created by Veldanov, Anton on 4/10/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
  @objc dynamic var title:String = ""
  @objc dynamic var done:Bool = false
  // from to
  var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
  
}


