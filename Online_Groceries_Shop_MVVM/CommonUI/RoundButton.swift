//
//  RoundButton.swift
//  Online_Groceries_Shop_MVVM
//
//  Created by Suraj Lokhande2 on 20/03/25.
//

import SwiftUI

struct RoundButton: View {
    
    @State var title: String = ""
    @State var icon: Image? = nil
    @State var bgColor: Color = .white
    @State var titleColor: Color = .white
    
    var didTap: (() -> ())?
    
    var body: some View {
        Button {
            didTap?()
        } label: {
            HStack(spacing: 15) {
                
                if let icon = icon {
                    icon
                        .resizable()
                        .scaledToFit()
                        .frame(height: 25)
                }
                    
                Text(title)
                    .foregroundStyle(titleColor)
                    .font(.custom(Constants.Fonts.semiBold.rawValue, fixedSize: 18))
                    .multilineTextAlignment(.center)
                    
            }.frame(maxWidth: .infinity, minHeight: 50 ,maxHeight: 50)
            
        }
        .background(bgColor)
        .cornerRadius(10)
    }
}

#Preview {
    RoundButton(title: "Get Started", bgColor: .blue, titleColor: .white).padding(20)
}
