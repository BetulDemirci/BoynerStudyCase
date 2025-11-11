//
//  AsyncBaseViewModel.swift
//  Common
//
//  Created by Betul Demirci Çelik on 11.11.2025.
//

import Foundation

@MainActor
public protocol AsyncBaseViewModelable: AnyObject {
    func viewDidRemove()
}

@MainActor
open class AsyncBaseViewModel: AsyncBaseViewModelable {
    
    /// Async unstructure Tasks store
    public var tasks = [Task<Void, Never>]()
    
    public init() {}
    
    /// Adds a Task to the store for automatic cancellation
    public func store(_ task: Task<Void, Never>) {
        tasks.append(task)
    }
    
    /// Cancel all stored unstructure tasks
    public func cancelAllTasks() {
        tasks.forEach { $0.cancel() }
        tasks.removeAll()
    }
    
    open func viewDidRemove() {
        /// Cancel all unstructure tasks
        cancelAllTasks()
    }
}

