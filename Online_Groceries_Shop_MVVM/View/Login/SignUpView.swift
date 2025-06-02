//
//  SignUpView.swift
//  Online_Groceries_Shop_MVVM
//
//  Created by Suraj Lokhande on 27/05/25.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    
    @ObservedObject var coordinator: AppCoordinator
    @ObservedObject var viewModel: SignUpViewModel

    var body: some View {
        VStack {
            Image("color_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60, alignment: .center)
                .padding(.bottom, 20)

            VStack(alignment: .leading) {
                Text("Logging")
                    .font(.customFont(.semibold, size: 26))
                    .foregroundStyle(Color.primaryText)
                    .padding(.bottom, 5)

                Text("Enter your emails and password")
                    .font(.customFont(.semibold, size: 16))
                    .foregroundStyle(Color.secondaryText)
                    .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .leading, spacing: 20) {
                FloatingPlaceholderTextField(text: $email, placeholder: " Email ")
                
                Group {
                    if showPassword {
                        FloatingPlaceholderTextField(text: $password, placeholder: " Password ")
                    } else {
                        FloatingPlaceholderTextField(text: $password, placeholder: " Password ", secure: true)
                    }
                }
                .overlay(alignment: .trailing) {
                    Button(action: {
                        showPassword.toggle()
                    }) {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(.black)
                            .padding(15)
                    }
                }
            }

            Button(action: {
                // Handle forget password action
            }) {
                Text("Forget password?")
                    .font(.customFont(.medium, size: 14))
                    .foregroundColor(.primaryText)
                
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.vertical, 10)

            RoundButton(title: "Log In", bgColor: Color.green ,content: {
                //call login service
            })
            .padding(.bottom, 20)

            HStack {
                Text("Don't have an account?")
                    .font(.customFont(.semibold, size: 14))
                    .foregroundColor(.primaryText)
                
                NavigationLink {
                    coordinator.build(.SignUp)
                } label: {
                    Text("Sign Up")
                        .font(.customFont(.semibold, size: 14))
                        .foregroundColor(.primaryApp)
                }
            }
        }
        .padding()
    }
}

#Preview {
    SignUpView(coordinator: DependencyContainer().makeAppCoordinator(), viewModel: SignUpViewModel())
}
