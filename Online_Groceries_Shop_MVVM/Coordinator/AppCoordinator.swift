//
//  AppCoordinatorImpl.swift
//  CoordinatorPatternSample
//
//  Created by Diki Dwi Diro on 26/07/24.
//

import SwiftUI

class AppCoordinator: AppCoordinatorProtocol {
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?
    
    private let viewFactory: ViewFactory
    
    init(viewFactory: ViewFactory) {
        self.viewFactory = viewFactory
    }
    
    // MARK: - Navigation Functions
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func presentSheet(_ sheet: Sheet) {
        self.sheet = sheet
    }
    
    func presentFullScreenCover(_ fullScreenCover: FullScreenCover) {
        self.fullScreenCover = fullScreenCover
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissFullScreenOver() {
        self.fullScreenCover = nil
    }
    
    // MARK: - Presentation Style Providers
    @ViewBuilder
    func build(_ screen: Screen) -> some View {
        switch screen {
        case .Welcome, .SignUp, .SignIn, .Login:
            viewFactory.makeView(for: screen, coordinator: self)
//        case .detailHabit(named: let habit):
//            //DetailHabitView(habit: habit)
//            AnyView(EmptyView()) // Placeholder for the actual view
        }
    }
    

    @ViewBuilder
    func build(_ sheet: Sheet) -> some View {
        switch sheet {
        case .detailTask(named: let task):
            //DetailTaskView(task: task)
            AnyView(EmptyView()) // Placeholder for the actual view
        }
    }
    
    @ViewBuilder
    func build(_ fullScreenCover: FullScreenCover) -> some View {
        switch fullScreenCover {
        case .addHabit(onSaveButtonTap: let onSaveButtonTap):
            //AddHabitView(onSaveButtonTap: onSaveButtonTap)
            AnyView(EmptyView()) // Placeholder for the actual view
        }
    }
}
