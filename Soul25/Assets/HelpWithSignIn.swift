//
//  HelpWithSignIn.swift
//  Soul25
//
//  Created by Zablon Charles on 5/4/24.
//

import SwiftUI

struct HelpWithSignIn: View {
   
        @Environment(\.presentationMode) var presentationMode
        @AppStorage("signIn") var signIn = false
        @Binding var doneIntro : Bool
        @State var question = 1
        @State var backgroundColor = "Background"
        @State var background = "Blob 1"
        @State var icon = "person.circle"
        @State var titleMessage = "Verification"
        @State var titleDescription = "If you don’t see an option for where to send a code or you no longer have access to any of the verification options shown, you won't be able to reset your password this way. Remember to check your email when signing up for a verification code. Yes even in your junk folder. You can also request a new verification email below."
        @State var askText = "Email"
        @State var text = ""
        @State var userMessage = "Submit"
        
        @State var askSecure = "Secure"
        @State var secureText = ""
        @State var showalltextFields = false
        @State var showtextSubmit = true
        @State var showsecureSubmit = true
        @FocusState var isEmailFocused: Bool
        @State var showButton = true
        
        
        
        var body: some View {
            
            VStack{
                iconTitleMessage
                Spacer()
                
                Divider()
                ZStack {
                    LottieView(filename: "birds" ,loop: true)
                        .frame(width: 399)
                    alltextFields
                        .padding(.vertical,5)
                        .padding(.horizontal,5)
                }
                
                if showButton {
                    Button {
                        submit()
                    } label: {
                        Text(userMessage)
                            .padding(.horizontal,90)
                            .padding(.top, 20)
                    }
                }
                
                
            } .padding(20)
                .background(
                    
                    Image("ob7")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fill)
                        .offset(x:UIScreen.main.bounds.width * 0.99)
                        .blur(radius: 17)
                    
                        .padding()
                        .edgesIgnoringSafeArea(.all) )
                .statusBar(hidden: false)
                .background(Color(backgroundColor).edgesIgnoringSafeArea(.vertical))
                .onTapGesture{hidekeyboard()}
            
            
                .navigationBarBackButtonHidden(false)
            
                .onAppear {
                    method()
                }
        }
        
        var iconTitleMessage: some View {
            VStack(spacing:10){
                VStack(spacing:10) {
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundStyle(.secondary)
                        .padding(10)
                        .background(.ultraThinMaterial)
                        .cornerRadius(30)
                    
                    
                    Text(titleMessage)
                        .font(.title2)
                        .fontWeight(.regular)
                        .foregroundColor(Color("black"))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 19)
                        .background(.ultraThinMaterial)
                        .cornerRadius(25)
                        .onTapGesture {
                            //presentationMode.wrappedValue.dismiss()
                            hidekeyboard()
                            
                        }
                    
                }
                Divider()
                Text(titleDescription)
                    .font(.subheadline)
                    .padding(18)
                    .background(.ultraThinMaterial)
                    .cornerRadius(25)
                    .multilineTextAlignment(.center)
            }.padding(.top, -80)
                .onTapGesture {
                    hidekeyboard()
                }
            
            
        }
        var alltextFields: some View {
            VStack{
                
               
                    if showtextSubmit{
                        TextField(askText, text: $text)
                            .keyboardType(.default)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                           
                            .focused($isEmailFocused)
                            .onTapGesture {
                                userMessage = "Submit"
                                vibrate()
                            }
                            .onChange(of: text) { text in
                                userMessage = "Submit"
                            }
                    }
                    
                    
                    if showsecureSubmit{
                        SecureField(askSecure, text: $secureText)
                            .keyboardType(.default)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                           
                            .focused($isEmailFocused)
                            .onTapGesture {
                                userMessage = "Submit"
                                vibrate()
                            }
                            .onChange(of: secureText) { secureText in
                                userMessage = "Submit"
                            }
                    }
                    
                
                Spacer()
                
                
            }
        }
        func hidekeyboard(){
            isEmailFocused = false
        }
        func method(){
            vibrate()
            
            if question == 1 || question == 2 || question == 3 || question == 4 {
                
                showsecureSubmit = false
                
            }
            
            if question == 1{
                
                
            }
            if question == 2{
                
                showtextSubmit = true
                
                
            }
            if question == 3{
                
                
            }
            if question == 4{
                
                showtextSubmit = false
                showButton = true
                
                
            }
            
        }
        func submit(){
            vibrate()
            if question == 1 || question == 2 || question == 3  {
                
                if text.isEmpty || !text.contains("@") || !text.contains("."){
                    userMessage = "Retype email"
                }else {
                    userMessage = "Sending email..."
                    userMessage = "Email sent"
                }
                
            } else if question == 4 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    
                    userMessage = "Let's GO!"
                    UserDefaults.standard.set(true, forKey: "doneIntro")
                    signIn = false
                    doneIntro = false
                    vibrate()
                }
                userMessage = "Loading..."
                
            }
            
        }
        func vibrate() {
            let impactMed = UIImpactFeedbackGenerator(style: .light)
            impactMed.impactOccurred()
        }
    }

struct HelpWithSignIn_Previews: PreviewProvider {
    static var previews: some View {
        HelpWithSignIn(doneIntro: .constant(false))
    }
}
