//
//  OnboardView.swift
//  Soul25
//
//  Created by Zablon Charles on 4/28/24.
//

import SwiftUI

struct OnboardView: View {
    @State private var currentPage = 0
    var list : [String] = [""]
    @State var returned  = ""
    @Binding var onboardComplete : Bool
    var body: some View {
        ZStack {
            BackgroundView()
            TabView(selection: $currentPage) {
                // First slide
                ZStack {
                    LogoLoadingView()
                        .padding(.bottom,150)
                       
                    OnboardInfo(lottie: "t", title: "")
                        .padding(.bottom,150)
                        .padding(.horizontal,10)
                       
                } .tag(0)
                
                // Second slide
                OnboardInfo(lottie:"telescope",title: "Fumble approach to dating",description: "Fumble is a modern dating app that prioritizes authentic connections and meaningful conversations.")
                .tag(1)
                
                // Third slide
                OnboardInfo(lottie:"girlonphone",title: "Superficial Interactions", description: "Unlike traditional dating apps focused solely on swiping, we encourage users to engage in deeper conversations through thought-provoking icebreaker questions and prompts.")
                .tag(2)
            }.overlay(
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .neoButton(isToggle: false) {
                                withAnimation(.spring()) {
                                    onboardComplete = true
                                }
                            }
                    }.padding(.horizontal,30)
                    Spacer()
                }
            )
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .onAppear {
                UITabBar.appearance().isHidden = true
        }
        }
    }
}

struct OnboardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardView(onboardComplete: .constant(false))
    }
}




struct OnboardInfo : View {
    var lottie = "study"
    var title = "Welcome to fumble"
    var description = "Find meaningful connections with Fumble, where real conversations lead to real connections."
    var body : some View {
        VStack {
            
            Spacer()
            VStack {
                LottieView(filename: lottie ,loop: true)
                    .frame(height: 200)
                    .padding(.top, 30)
                    .padding(.bottom,10)
                Text(title)
                    .font(.headline)
                    .padding(.bottom,5)
                Text(description)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,25)
                    .padding(.bottom,5)
            }
            
            
            
            Spacer()
            Spacer()
            
            
            
            
            
        }
    }
}
