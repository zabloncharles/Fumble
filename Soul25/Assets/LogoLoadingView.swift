//
//  LogoLoadingView.swift
//  Soul25
//
//  Created by Zablon Charles on 4/22/24.
//

import SwiftUI

struct LogoLoadingView: View {
    var animateForever = false
    var body: some View {
        ZStack {
            appbackground
            VStack {
                Spacer()
                ShimmerVar(text:"Fumble",animateForever: animateForever)
                    .scaleEffect(1.1)
                Spacer()
            }
        }
    }
}

struct LogoLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LogoLoadingView()
    }
}
