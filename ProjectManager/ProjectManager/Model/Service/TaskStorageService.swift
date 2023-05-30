//
//  MainCollectionViewService.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/23.
//

import Foundation

final class TaskStorageService {
    private var taskStore: [Task]
    
    init(taskStore: [Task]) {
        self.taskStore = taskStore
    }
    
    func createTask(_ task: Task) {
        taskStore.append(task)
    }
    
    func fetchTaskList() -> [Task] {
        return taskStore
    }
    
    func updateTask(_ task: Task) {
        guard let index = taskStore.firstIndex(where: { $0.id == task.id }) else { return }
        
        taskStore[safe: index] = task
    }
    
    func deleteTask(id: UUID) {
        guard let index = taskStore.firstIndex(where: { $0.id == id }) else { return }
        
        taskStore.remove(at: index)
    }
    
    func changeWorkState(taskID: UUID, with workState: WorkState) {
        guard let index = taskStore.firstIndex(where: { $0.id == taskID }) else { return }
        
        taskStore[safe: index]?.workState = workState
    }
}
