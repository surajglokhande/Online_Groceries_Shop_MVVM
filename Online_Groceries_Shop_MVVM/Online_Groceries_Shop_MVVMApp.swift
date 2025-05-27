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
        
    
//        if #available(iOS 15.0, *) {
                    let appearance = UINavigationBarAppearance()
                    // Set the tint color for items (including the back arrow)
                    appearance.configureWithOpaqueBackground() // Or .configureWithDefaultBackground()

                    // Apply the appearance to standard, compact, and scrollEdge states
                    UINavigationBar.appearance().standardAppearance = appearance
                    UINavigationBar.appearance().compactAppearance = appearance
                    UINavigationBar.appearance().scrollEdgeAppearance = appearance
                    UINavigationBar.appearance().tintColor = .black // This sets the color of the back button arrow and other bar button items

                    // Optional: If you want to change the title color as well
                    // appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
                    // appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
//                } else {
//                    // Fallback for iOS 13 and 14
//                    UINavigationBar.appearance().tintColor = .black
//                    // Optional: If you want to change the title color for older iOS
//                    // UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
//                    // UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.black]
//                }
    }
    
    var body: some Scene {
        WindowGroup {
             CoordinatorView(appCoordinator: appCoordinator)
        }
    }
}
