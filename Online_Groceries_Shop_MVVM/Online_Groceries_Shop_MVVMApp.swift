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
    var body: some Scene {
        WindowGroup {
             NavigationView {
                 //WelcomeView()
                 LoginView()
             }
        }
    }
}
