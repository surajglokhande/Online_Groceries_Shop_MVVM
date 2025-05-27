//
//  ContentView.swift
//  Online_Groceries_Shop_MVVM
//
//  Created by Suraj Lokhande2 on 20/03/25.
//

import SwiftUI

struct WelcomeView: View {
    
    @ObservedObject var coordinator: AppCoordinator
    
    var body: some View {
        ZStack {
            Image("welcome_bg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                VStack {
                    Image("app_logo")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding(.bottom, 8)
                    Text("Welcome\nto our store")
                        .font(.customFont(.semibold, size: 48))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                    Text("Get your groceries in as fast as one hour")
                        .font(.customFont(.medium, size: 16))
                        .foregroundStyle(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 20)
//                    NavigationLink {
//                        coordinator.build(.SignUp)
//                    } label: {
//                        Text("Get Started")
//                            .foregroundStyle(.white)
//                            .font(.customFont(.semibold, size: 18))
//                            .multilineTextAlignment(.center)
//                    }
//                    .frame(maxWidth: .infinity, minHeight: 60 ,maxHeight: 60)
//                    .background(.green)
//                    .cornerRadius(20)
                    RoundButton(title: "Get Started", bgColor: Color.primaryApp, titleColor: .white) {
                        coordinator.build(.Login)
                    }
                    Spacer()
                        .frame(height: 45)
                }
                
            }.padding(.horizontal ,20)
            
        }
        //        .navigationBarHidden(true)
        //        .navigationTitle("")
        //        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    WelcomeView(coordinator: AppCoordinator(viewFactory: ViewFactory(container: DependencyContainer())))
}
