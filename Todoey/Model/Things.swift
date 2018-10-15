//
//  Things.swift
//  Todoey
//
//  Created by Roy Freeman on 14/10/2018.
//  Copyright © 2018 Roy Freeman. All rights reserved.
//

import Foundation
import RealmSwift

class Things: Object {
    
    @objc dynamic var name: String = ""
    
    //relationship (LIst comes from realm framework)
    
    let items = List<Item>()
   
}
