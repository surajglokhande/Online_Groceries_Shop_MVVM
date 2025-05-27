//
//  SignUpView.swift
//  Online_Groceries_Shop_MVVM
//
//  Created by Suraj Lokhande on 27/05/25.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SignUpView(viewModel: SignUpViewModel())
}
