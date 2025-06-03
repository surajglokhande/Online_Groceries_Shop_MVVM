//
//  SignUpView.swift
//  Online_Groceries_Shop_MVVM
//
//  Created by Suraj Lokhande on 27/05/25.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    
    @ObservedObject var coordinator: AppCoordinator
    @ObservedObject var viewModel: SignUpViewModel
    
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
                    Text("Sign Up")
                        .font(.customFont(.semibold, size: 26))
                        .foregroundStyle(Color.primaryText)
                        .padding(.bottom, 5)
                    
                    Text("Enter your credentials to continue")
                        .font(.customFont(.semibold, size: 16))
                        .foregroundStyle(Color.secondaryText)
                        .padding(.bottom, 20)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 20) {
                    FloatingPlaceholderTextField(text: $username, placeholder: " Username ")
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
                
                VStack {
                    Text("By continuing you agree to our")
                        .font(.customFont(.medium, size: 14))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    HStack{
                        
                        Group {
                            Text("Terms of Service")
                                .foregroundColor(.primaryApp)
                                .onTapGesture {
                                    UIApplication().canOpenURL(URL(string: "https://www.google.com")!)
                                }
                            Text("and")
                                .foregroundColor(.secondaryText)
                            Text("Privacy Policy.")
                                .foregroundColor(.primaryApp)
                                .onTapGesture {
                                    UIApplication().canOpenURL(URL(string: "https://www.google.com")!)
                                }
                        }
                        .font(.customFont(.medium, size: 14))
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.vertical, 5)
                
                RoundButton(title: "Sign Up",
                            bgColor: Color.primaryApp ,
                            tap: {
                    //call login service
                })
                .padding(.bottom, 20)
                
                HStack {
                    Text("Alredy have an account?")
                        .font(.customFont(.semibold, size: 14))
                        .foregroundColor(.primaryText)
                    
                    Text("Sign In")
                        .font(.customFont(.semibold, size: 14))
                        .foregroundColor(.primaryApp)
                        .onTapGesture {
                            coordinator.popTo(.SignIn)
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
    SignUpView(coordinator: DependencyContainer().makeAppCoordinator(), viewModel: SignUpViewModel())
}
