//
//  TodoViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/17.
//

import Foundation

final class TodoViewModel {
    private let todo: Todo
    private let dateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"

        return formatter
    }()
    
    init(todo: Todo) {
        self.todo = todo
    }
    
    var title: String { return todo.title }
    
    var body: String { return todo.body }
    
    var date: String { return DateFormatter().string(from: todo.date) }
}

extension TodoViewModel: Hashable {
    static func == (lhs: TodoViewModel, rhs: TodoViewModel) -> Bool {
        return lhs.todo == rhs.todo
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(todo)
    }
}
