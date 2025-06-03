//
//  LoginView.swift
//  Online_Groceries_Shop_MVVM
//
//  Created by Suraj Lokhande2 on 24/03/25.
//
import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    
    @ObservedObject var coordinator: AppCoordinator
    @ObservedObject var viewModel: SignInViewModel
    
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
            VStack{
                Image("color_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 55, height: 55, alignment: .center)
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
                
                RoundButton(title: "Log In", bgColor: Color.primaryApp, tap: {
                    //call login API
                })
                .padding(.bottom, 20)
                
                HStack {
                    Text("Don't have an account?")
                        .font(.customFont(.semibold, size: 14))
                        .foregroundColor(.primaryText)
                    
                    Button {
                        coordinator.popTo(.SignUp)
                    } label: {
                        Text("Sign Up")
                            .font(.customFont(.semibold, size: 14))
                            .foregroundColor(.primaryApp)
                    }
                }
            }
            Spacer()
                .frame(height: UIScreen.main.bounds.size.height * 0.05)
        }
        .padding()
    }
}

#Preview {
    SignInView(coordinator: DependencyContainer().makeAppCoordinator(), viewModel: SignInViewModel())
}
