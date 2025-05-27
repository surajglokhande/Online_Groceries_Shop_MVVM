//
//  DependencyInjection.swift
//  Online_Groceries_Shop_MVVM
//
//  Created by Suraj Lokhande on 26/05/25.
//

import Foundation
import SwiftUI

class DependencyContainer {
    // Data Sources
//    lazy var dataSource: DataSource = {
//        return MockProductDataSource()
//    }()
    
//    // Repositories
//    lazy var productRepository: ProductRepository = {
//        return DefaultProductRepository(dataSource: productDataSource)
//    }()
//    
//    // Use Cases
//    lazy var getProductsUseCase: GetProductsUseCase = {
//        return DefaultGetProductsUseCase(productRepository: productRepository)
//    }()
//    
//    lazy var getProductUseCase: GetProductUseCase = {
//        return DefaultGetProductUseCase(productRepository: productRepository)
//    }()
//    
//    lazy var saveProductUseCase: SaveProductUseCase = {
//        return DefaultSaveProductUseCase(productRepository: productRepository)
//    }()
//    
    // ViewModels
    
    func makeSignUpViewModel() -> SignUpViewModel {
        return SignUpViewModel()
    }
    func makeSignInViewModel() -> SignInViewModel {
        return SignInViewModel()
    }
    func makeLoginViewModel() -> LoginViewModel {
        return LoginViewModel()
    }
    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel()
    }
    
//    func makeProductDetailViewModel(productId: UUID? = nil) -> ProductDetailViewModel {
//        return ProductDetailViewModel(getProductUseCase: getProductUseCase, productId: productId)
//    }
    
    // Factory
    lazy var viewFactory: ViewFactory = {
        return ViewFactory(container: self)
    }()
    
    // Coordinator
    func makeAppCoordinator() -> AppCoordinator {
        return AppCoordinator(viewFactory: viewFactory)
    }
}

