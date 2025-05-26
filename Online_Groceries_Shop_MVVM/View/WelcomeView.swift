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
                        .font(.custom(Constants.Fonts.semiBold.rawValue, fixedSize: 48))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                    Text("Get your groceries in as fast as one hour")
                        .font(.custom(Constants.Fonts.medium.rawValue, fixedSize: 16))
                        .foregroundStyle(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 20)
                    NavigationLink {
                        coordinator.build(.SignUp)
                    } label: {
                        Text("Get Started")
                            .foregroundStyle(.white)
                            .font(.custom(Constants.Fonts.semiBold.rawValue, fixedSize: 18))
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, minHeight: 50 ,maxHeight: 50)
                    .background(.green)
                    .cornerRadius(10)
                    
                }
                Spacer()
                    .frame(height: 50)
            }.padding(.horizontal ,20)
            
        }
        .navigationBarHidden(true)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    WelcomeView()
}
