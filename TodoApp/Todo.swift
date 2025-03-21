//
//  Todo.swift
//  TodoApp
//
//  Created by 영석 on 3/21/25.
//

import Foundation

import SwiftData

@Model
class Todo : Identifiable {
    let id: UUID 
    var title:String
    var isCompleted:Bool
    var detail:String
    
    init(title:String) {
        self.id = UUID()
        self.title = title
        isCompleted = false
        detail = ""
    }
}
