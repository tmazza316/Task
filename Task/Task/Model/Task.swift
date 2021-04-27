//
//  Task.swift
//  Task
//
//  Created by Thomas Mazza on 4/26/21.
//

import Foundation

class Task: Codable {
    var name: String
    var notes: String?
    var dueDate: Date?
    var isComplete: Bool
    
    init(name: String, notes: String?, dueDate: Date?, isComplete: Bool = false) {
        self.name = name
        self.notes = notes
        self.dueDate = dueDate
        self.isComplete = isComplete
        
    }
}

extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.name == rhs.name && lhs.notes == rhs.notes && lhs.dueDate == rhs.dueDate && lhs.isComplete == rhs.isComplete
    }
}
