//
//  TodoModel.swift
//  Todoey
//
//  Created by Roy Freeman on 10/10/2018.
//  Copyright © 2018 Roy Freeman. All rights reserved.
//

import Foundation

class TodoModel: Encodable {
    // as encodable all properties must be standard data types
    var title : String = ""
    var done : Bool = false
    
}
