//
//  FloatingTextField.swift
//  Online_Groceries_Shop_MVVM
//
//  Created by Suraj Lokhande2 on 24/03/25.
//


import SwiftUI

struct FloatingPlaceholderTextField: View {
    
    @Binding var text: String
    @FocusState private var isEditing: Bool
    
    var placeholder: String
    var secure: Bool = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            Group {
                if secure {
                    SecureField("", text: $text)
                        .focused($isEditing)
                }else{
                    TextField("", text: $text)
                        .focused($isEditing)
                }
            }
            .frame(height: 40)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(isEditing ? Color.green : Color.gray, lineWidth: 1)
            )
            Text(placeholder)
                .foregroundColor(isEditing || !text.isEmpty ? .green : .gray)
                .background(Color.white)
                .padding(.horizontal, 4)
                .offset(x: 8, y: isEditing || !text.isEmpty ? -40 : 0)
                .scaleEffect(isEditing || !text.isEmpty ? 0.8 : 1.0, anchor: .leading)
                .animation(.easeInOut(duration: 0.2), value: isEditing || !text.isEmpty)
        }
    }
}

struct ContentView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    
    var body: some View {
        VStack {
            FloatingPlaceholderTextField(text: $email, placeholder: " Username ")
                .padding()
            
            FloatingPlaceholderTextField(text: $password, placeholder: " Password ", secure: true)
                .overlay(alignment: .trailing) {
                    Button(action: {
                        showPassword.toggle()
                    }) {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(.black)
                            .padding(15)
                    }
                }
                .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
