//
//  DetailService.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/22.
//
import Foundation

final class DetailService {
    func createTask(title: String, date: Date, body: String) {
        let task = Task(title: title, date: date, body: body, workState: .todo)
        TaskRepository.shared.append(task)
    }
    
    func update() {
        
    }
}
