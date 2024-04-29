//  ViewController.swift
//  Created by Zablon Charles on 12/30/21.


import SwiftUI

struct ViewController: View {
    @AppStorage("signedIn") var signedIn = false
    @AppStorage("onboardComplete") var onboardComplete = false
   
    
    var body: some View {
        if !onboardComplete {
            OnboardView(onboardComplete: $onboardComplete)
            
        } else {
         
                if !signedIn {
                    SigninView(signIn: $signedIn)
                } else {
                    MainTab()
            }
            
         }

     }

}
        
        struct ViewController_Previews: PreviewProvider {
            static var previews: some View {
                ViewController()

                    
            }
        }
        
