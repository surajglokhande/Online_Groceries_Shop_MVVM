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
        case .Welcome:
            WelcomeView(coordinator: coordinator)
        case .SignIn:
            SignInView(coordinator: coordinator, viewModel: container.makeSignInViewModel())
        case .Login:
            LoginView(coordinator: coordinator, viewModel: container.makeLoginViewModel())
        case .SignUp:
            SignUpView(coordinator: coordinator, viewModel: container.makeSignUpViewModel())
        }
    }
}

