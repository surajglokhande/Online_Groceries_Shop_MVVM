//
//  Online_Groceries_Shop_MVVMApp.swift
//  Online_Groceries_Shop_MVVM
//
//  Created by Suraj Lokhande2 on 20/03/25.
//

import SwiftUI
import SwiftData

@main
struct Online_Groceries_Shop_MVVMApp: App {
    
    @StateObject private var appCoordinator: AppCoordinator
    
    init() {
        let container = DependencyContainer()
        _appCoordinator = StateObject(wrappedValue: container.makeAppCoordinator())
    }
    
    var body: some Scene {
        WindowGroup {
             CoordinatorView(appCoordinator: appCoordinator)
        }
    }
}
