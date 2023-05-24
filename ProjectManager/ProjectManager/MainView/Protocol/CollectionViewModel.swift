//
//  CollectionViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/24.
//

import UIKit

protocol CollectionViewModel: AnyObject {
    associatedtype DataSource
    
    var items: [Task] { get set }
    
    func makeDataSource() throws -> DataSource
    
    func applySnapshot()
    
    func task(at: IndexPath) -> Task?
    
    func updateSnapshot()
    
    func updateTask(id: UUID)
}
