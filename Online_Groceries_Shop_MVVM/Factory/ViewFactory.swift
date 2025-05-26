//
//  Factory.swift
//  Online_Groceries_Shop_MVVM
//
//  Created by Suraj Lokhande on 26/05/25.
//

import SwiftUI

struct ViewFactory {
    private let container: DependencyContainer
    
    init(container: DependencyContainer) {
        self.container = container
    }
    
    @ViewBuilder
    func makeView(for screen: Screen, coordinator: AppCoordinator) -> some View {
        switch screen {
        case .SignUp:
            SignInView(viewModel: container.makeSignUpViewModel())
//        case .Login:
//            LoginView(viewModel: container.makeLoginViewModel(coordinator: coordinator))
        case .Welcome:
            WelcomeView(coordinator: coordinator)
        }
    }
}

