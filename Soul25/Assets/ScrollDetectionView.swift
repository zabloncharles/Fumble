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


