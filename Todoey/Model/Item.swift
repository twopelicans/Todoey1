//
//  Item.swift
//  Todoey
//
//  Created by Roy Freeman on 14/10/2018.
//  Copyright © 2018 Roy Freeman. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    //inverse relationship
    
    var parentCategory = LinkingObjects(fromType: Things.self, property: "items")
}
