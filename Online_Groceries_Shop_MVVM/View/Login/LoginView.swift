//
//  LoginView.swift
//  Online_Groceries_Shop_MVVM
//
//  Created by Suraj Lokhande2 on 24/03/25.
//
import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    
    @ObservedObject private var viewModel: LoginViewModel

    var body: some View {
        VStack {
            Image("color_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60, alignment: .center)
                .padding(.bottom, 20)

            VStack(alignment: .leading) {
                Text("Loging")
                    .font(.custom(Constants.Fonts.medium.rawValue, size: 40))
                    .padding(.bottom, 5)

                Text("Enter your emails and password")
                    .font(.custom(Constants.Fonts.medium.rawValue, size: 20))
                    .foregroundColor(.gray)
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
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.bottom, 20)

            Button(action: {
                // Handle login action
            }) {
                Text("Log In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(15.0)
            }
            .padding(.bottom, 20)

            HStack {
                Text("Don't have an account?")
                Button(action: {
                    // Handle sign up action
                }) {
                    Text("Sign Up")
                        .foregroundColor(.green)
                }
            }
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
