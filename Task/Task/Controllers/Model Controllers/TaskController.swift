//
//  TaskController.swift
//  Task
//
//  Created by Thomas Mazza on 4/26/21.
//

import Foundation

class TaskController {
    
    static let shared = TaskController()
    
    var tasks: [Task] = []
    
    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
        let newTask = Task(name: name, notes: notes, dueDate: dueDate)
        tasks.append(newTask)
        saveToPersistenceStore()
}

    func update(task: Task, name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        saveToPersistenceStore()
    }
    
    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        saveToPersistenceStore()
    
    }
    
    func delete(task: Task) {
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks.remove(at: index)
        saveToPersistenceStore()
    }
    

    //MARK:  - Persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Task.json")
        return fileURL
        
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(tasks)
            try data.write(to:createPersistenceStore())
            
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            
        }
        
    }
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            
            tasks = try JSONDecoder().decode([Task].self, from: data)
            
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            
        }
        
    }
    
}// end of class
