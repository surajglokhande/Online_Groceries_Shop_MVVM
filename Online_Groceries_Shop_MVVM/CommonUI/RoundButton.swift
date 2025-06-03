//
//  RoundButton.swift
//  Online_Groceries_Shop_MVVM
//
//  Created by Suraj Lokhande2 on 20/03/25.
//

import SwiftUI

struct RoundButton/*<Content: View>*/: View {
    
    @State var title: String = ""
    @State var icon: Image? = nil
    @State var bgColor: Color = .white
    @State var titleColor: Color = .white
    
    //var content: () -> Content
    var tap: (()->())?
    
    var body: some View {
        Button {
            tap?()
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
                    .font(.customFont(.semibold, size: 18))
                    .multilineTextAlignment(.center)
                
            }
            .frame(maxWidth: .infinity, minHeight: 60 ,maxHeight: 60)
            
        }
        .background(bgColor)
        .cornerRadius(20)
        .onTapGesture {
            tap?()
        }
    }
}

//#Preview {
//    RoundButton(title: "Click Me", bgColor: Color.primaryApp, titleColor: .white) {
//        Text("Button Clicked")
//    } tap: {
//        print("Button tapped")
//    }
//    .padding(20)
//}
