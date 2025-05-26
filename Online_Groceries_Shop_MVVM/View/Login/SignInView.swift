//
//  SignInView.swift
//  Online_Groceries_Shop_MVVM
//
//  Created by Suraj Lokhande2 on 20/03/25.
//

import SwiftUI
import CountryPicker

struct SignInView: View {
    
    @State private var country: Country?
    @State private var showCountryPicker = false
    @State private var mobileNumber = ""
    @FocusState private var isFirstResponder :Bool

    @ObservedObject var viewModel: SignUpViewModel
    
    var body: some View {
        VStack {
            Image("sign_in_top")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            VStack(alignment: .leading, spacing: 50) {
                Text("Get your Groceries\nwith nectar")
                    .font(.custom(Constants.Fonts.semiBold.rawValue, fixedSize: 26))
                    .frame(maxWidth: .infinity, alignment: .leading)
                VStack {
                    HStack(alignment: .center) {
                        Button {
                            showCountryPicker = true
                        } label: {
                            if let obj = $country.wrappedValue {
                                Text("\(obj.isoCode.getFlag())")
                                    .font(.custom(Constants.Fonts.medium.rawValue, fixedSize: 30))
                                
                                Text("+\(obj.phoneCode)")
                                    .font(.custom(Constants.Fonts.medium.rawValue, fixedSize: 18))
                            }
                        }
                        .foregroundStyle(.black)

                        TextField("Enter your mobile number", text: $mobileNumber)
                            .font(.custom(Constants.Fonts.medium.rawValue, fixedSize: 18))
                            .keyboardType(.phonePad)
                            .focused($isFirstResponder)
                            .toolbar {
                                ToolbarItem(placement: .keyboard) {
                                    HStack {
                                        Spacer()
                                        Button("Done") {
                                            isFirstResponder = false
                                        }
                                        .frame(alignment: .trailing)
                                        .font(.custom(Constants.Fonts.medium.rawValue, fixedSize: 18))
                                    }
                                }
                            }
                    }
                    Divider().padding(.top, 5)
                }
                    
                Text("Or continue with social media")
                    .font(.custom(Constants.Fonts.regular.rawValue, fixedSize: 16))
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                VStack(spacing: 20) {
                    RoundButton(title: "Continue with Google", icon: Image("google_logo"), bgColor: .init(hex: "db4437"), titleColor: .white) {
                    }
                    RoundButton(title: "Continue with Facebook", icon: Image("fb_logo"), bgColor: .init(hex: "1877F2"), titleColor: .white) {
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
        .navigationBarHidden(true)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationView {
        SignInView()
    }
}
