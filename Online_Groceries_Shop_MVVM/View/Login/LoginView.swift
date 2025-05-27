//
//  SignInView.swift
//  Online_Groceries_Shop_MVVM
//
//  Created by Suraj Lokhande2 on 20/03/25.
//

import SwiftUI
import CountryPicker

struct LoginView: View {
    
    @State private var country: Country?
    @State private var showCountryPicker = false
    @State private var mobileNumber = ""
    @FocusState private var isFirstResponder :Bool
    @State private var alert: Bool = false
    
    @ObservedObject var coordinator: AppCoordinator
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            Image("sign_in_top")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay(alignment: .bottomLeading) {
                    Text("Get your Groceries\nwith nectar")
                        .font(.customFont(.semibold, size: 26))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 35, trailing: 0))
                }
            
            VStack(alignment: .leading, spacing: 30) {
                
                VStack(spacing: 15) {
//                    HStack(alignment: .center) {
//                        Button {
//                            showCountryPicker = true
//                        } label: {
//                            if let obj = $country.wrappedValue {
//                                Text("\(obj.isoCode.getFlag())")
//                                    .font(.custom(Constants.Fonts.medium.rawValue, fixedSize: 30))
//
//                                Text("+\(obj.phoneCode)")
//                                    .font(.custom(Constants.Fonts.medium.rawValue, fixedSize: 18))
//                            }
//                        }
//                        .foregroundStyle(.black)
//
//                        TextField("Enter your mobile number", text: $mobileNumber)
//                            .font(.custom(Constants.Fonts.medium.rawValue, fixedSize: 18))
//                            .keyboardType(.phonePad)
//                            .focused($isFirstResponder)
//                            .toolbar {
//                                ToolbarItem(placement: .keyboard) {
//                                    HStack {
//                                        Spacer()
//                                        Button("Done") {
//                                            isFirstResponder = false
//                                        }
//                                        .frame(alignment: .trailing)
//                                        .font(.custom(Constants.Fonts.medium.rawValue, fixedSize: 18))
//                                    }
//                                }
//                            }
//                    }
//                    Divider().padding(.top, 5)
                     
                    RoundButton(title: "Continue with Email Sign In", icon: nil, bgColor: Color.init(hex: "5383EC"), titleColor: .white) {
                        coordinator.build(.SignIn)
                    }
                    RoundButton(title: "Continue with Email Sign Up", icon: nil, bgColor: Color.primaryApp, titleColor: .white) {
                        coordinator.build(.SignUp)
                    }
                }
                
                Text("Or continue with social media")
                    .font(.customFont(.semibold, size: 14))
                    .foregroundStyle(Color.textTitle)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                VStack(spacing: 15) {
                    Button {
                        alert.toggle()
                    } label: {
                        RoundButton(title: "Continue with Google", icon: Image("google_logo"), bgColor: .init(hex: "db4437"), titleColor: .white, content:  {
                            //AnyView(_fromValue: EmptyView())
                        })
                        .disabled(true)
                    }
                    Button {
                        alert.toggle()
                    } label: {
                        RoundButton(title: "Continue with Facebook", icon: Image("fb_logo"), bgColor: .init(hex: "4A66AC"), titleColor: .white, content:  {
                            //AnyView(_fromValue: EmptyView())
                        })
                        .disabled(true)
                    }

                }
                
            }.padding(.horizontal, 20)
            Spacer()
        }
        .onAppear(perform: {
            country = Country(phoneCode: "91", isoCode: "IN")
        })
        .sheet(isPresented: $showCountryPicker, onDismiss: {
            mobileNumber = ""
            isFirstResponder = false
        }, content: {
            CountryPicker(country: $country)
        })
        .alert("Comming Soon", isPresented: $alert) {
            Button("OK", role: .cancel) {
                alert.toggle()
            }
        } message: {
            Text("This feature is not available yet.")
        }
        .navigationBarHidden(true)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    LoginView(coordinator: AppCoordinator(viewFactory: ViewFactory(container: DependencyContainer())), viewModel: LoginViewModel())
}
