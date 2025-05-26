//
//  HomeView.swift
//  Online_Groceries_Shop_MVVM
//
//  Created by Suraj Lokhande on 26/05/25.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var viewModel: HomeViewModel
    @ObservedObject private var coordinator: AppCoordinator
    
    var body: some View {
        Text("Welcome to the Home Page!")
    }
}

