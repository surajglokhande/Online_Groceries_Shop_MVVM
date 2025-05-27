//
//  CoordinatorView.swift
//  Online_Groceries_Shop_MVVM
//
//  Created by Suraj Lokhande on 26/05/25.
//

import SwiftUI

struct CoordinatorView: View {
    
    @ObservedObject var appCoordinator : AppCoordinator
    
    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
            appCoordinator.build(.Welcome)
                .navigationDestination(for: Screen.self) { screen in
                    appCoordinator.build(screen)
                }
                .sheet(item: $appCoordinator.sheet) { sheet in
                    appCoordinator.build(sheet)
                }
                .fullScreenCover(item: $appCoordinator.fullScreenCover) { fullScreenCover in
                    appCoordinator.build(fullScreenCover)
                }
        }
    }
}

#Preview {
    @Previewable @StateObject var appCoordinator = DependencyContainer().makeAppCoordinator()
    CoordinatorView(appCoordinator: appCoordinator)
}
