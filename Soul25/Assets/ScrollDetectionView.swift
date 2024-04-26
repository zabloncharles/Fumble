//
//  ScrollDetectionView.swift
//  Soul25
//
//  Created by Zablon Charles on 4/21/24.
//

import SwiftUI

struct ScrollDetectionView: View {
    @Binding var userScrolledDown: Bool
    @State var userReloadingView = false
    let generator = UINotificationFeedbackGenerator()
    
    var body: some View {
        VStack {
            if userReloadingView {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color("black")))
                    .padding(.top,40)
                    .offset(y: userReloadingView ? 0 : UIScreen.main.bounds.height * -0.1)
                    .onAppear{
                        vibrate()
                        if userReloadingView {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation(.spring()) {
                                    userReloadingView = false
                                }
                            }
                        }
                        
                    }
            }
         
            
            Rectangle()
                .frame(width: 0, height: 0.0001)
            .scrollDetection(userScrolledDown: $userScrolledDown, userReloadingView: $userReloadingView)
        }
            
    }
    
    func vibrate() {
        let impactMed = UIImpactFeedbackGenerator(style: .soft)
        impactMed.impactOccurred()
    }
}


