//
//  ChangeWorkStateViewModelDelegate.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/29.
//

import Foundation

protocol ChangeWorkStateViewModelDelegate: AnyObject {
    func changeTaskWorkState(id: UUID, with: WorkState)
}