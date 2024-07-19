//
//  TextFieldView.swift
//  Soul25
//
//  Created by Zablon Charles on 7/3/24.
//

import SwiftUI

struct TextFieldView: View {
    var title: String
    @Binding var text: String
    @State var circleInitialY = CGFloat.zero
    @State var circleY = CGFloat.zero
    
    var body: some View {
        VStack(alignment: .leading) {
            GradientText(text: title, gradient: [Color("black"), Color("black"), .purple],animate: false)
                .font(.subheadline)
                .multilineTextAlignment(.center)
               
            TextField(title, text: $text)
                .overlay(
                    GeometryReader { proxy in
                        let offset = proxy.frame(in: .named("stack")).minY + 32
                        Color.clear.preference(key: CirclePreferenceKey.self, value: offset)
                    }
                        .onPreferenceChange(CirclePreferenceKey.self) { value in
                            circleInitialY = value
                            circleY = value
                        }
                )
              
                .padding(12)
                .background(Color("white"))
                
                .neoButtonOff(isToggle: false, cornerRadius: 10)
              
        }
        .padding(.horizontal, 12)
       
    }
}

struct SignUp2View_Previews: PreviewProvider {
    static var previews: some View {
       ViewController()
    }
}
