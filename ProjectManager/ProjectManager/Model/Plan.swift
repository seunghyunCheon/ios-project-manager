//
//  Plan.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/17.
//

import Foundation

struct Plan: Identifiable, Equatable {
    let title: String
    let date: Date
    let body: String
    var workState: WorkState
    let id: UUID
    
    init(title: String, date: Date, body: String, workState: WorkState, id: UUID = UUID()) {
        self.title = title
        self.date = date
        self.body = body
        self.workState = workState
        self.id = id
    }
}
