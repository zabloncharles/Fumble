//
//  SigninView.swift
//  SigninView
//
//  Created by Meng To on 2021-07-27.
//

import SwiftUI


struct SigninView: View {
    @AppStorage("currentPage") var selected = 0
    @AppStorage("onboardComplete") var onboardComplete = false
    @State var text = "test@gmail.com"
    @State var password = "123456"
    @State var circleInitialY = CGFloat.zero
    @State var circleY = CGFloat.zero
    @State var alertMessage = "Something went wrong."
    @State var showAlert = false
    @State var isLoading = false
    @State var isSuccessful = false
    @State var isLogging = false
    @FocusState var isEmailFocused: Bool
    @FocusState var isPasswordFocused: Bool
    @State var appear = [false, false, false, false]
    @Binding var signIn : Bool
    @State var userMessage = "Sign in"
    @State var messageTitle = "Sign In"
    @State var messageDescription = "Log in to your account to access your profile. Furthermore you can sign up for an account if you have not done so yet."
    @State var infoTitle = "Having trouble signing in?"
    @State var infoMessage = ""
    @State var infoTapped = false
    @State var signInTapped = false
    @State var showtext = false
    @State var profilePictureTapped = false
    @State var animate = false
    
    var body: some View {
        NavigationView{
         
                ZStack {
                   
                    LogoLoadingView(animateForever: true)
                        .scaleEffect(1.2)
                        .offset(y:-80)
                
                    //MARK: THE TOP ICONS
               
//                    LottieView(filename: "stars" ,loop: true)
//                        .frame(width: 380)
//                        .offset(x: 0, y: -420)
//                    
//                    LottieView(filename: "birds" ,loop: true)
//                        .frame(width: 380)
//                        .offset(x: 0, y: -220)
                    
                    topIcons
                    
               
                  
                    
                    
                    
                    
                    textandsecureFields
                    
                    
                    
                    
                    
                    
                    
                }.background(
                    Image("Blob 1")
                        .offset(x: -154, y: -340)
                        .edgesIgnoringSafeArea(.all)
                        .blur(radius: 58)
                        .opacity(signInTapped ? 0 : 1)
                        
                )
                    .background(
                        BackgroundView()
                            .edgesIgnoringSafeArea(.all)
                            .opacity(!animate ? 1 : 0.001)
                            .animation(.easeInOut(duration: 6), value: animate)
                            .opacity(0)
                    )
                    .statusBar(hidden: false)
                    
                    .navigationBarHidden(true)
                .transition(.scale.combined(with: .opacity))
            
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
  
    var topIcons: some View {
        VStack{
            
            HStack {
                if isEmailFocused || isPasswordFocused {
                    
                    VStack{
                        Image(systemName: "keyboard.chevron.compact.down")
                           
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(infoTapped ? .gray : Color("black"))
                            .font(.subheadline)
                            .padding(infoTapped ? 8 : 7)
                        
                    }.background(.ultraThinMaterial)
                        .cornerRadius(5)
                        .onTapGesture {
                            animate = true
                            infoPressed()
                            
                        }
                }
                Spacer()
              //  NavigationLink(destination:  helpSuggestions) {
                  
                HStack {
                    Text("Sign Up")
                        .padding(.horizontal,10)
                        .padding(.vertical,7)
                        .neoButtonOff(isToggle: false, cornerRadius: 8)
                        .onTapGesture {
                            onboardComplete = false
                        }
                    Spacer()
                    Image(systemName: "info.circle")
                        .padding(.horizontal,5)
                        .padding(.vertical,5)
                   
                        
                  
                }
                        
                  
               // }
              
                
                
            }.padding(.horizontal,20)
                .onTapGesture {
                    withAnimation(.spring()) {
                        infoPressed()
                    }}
            
            
            
            Spacer()
        }
    }
    
  
    var textandsecureFields: some View{
        VStack(alignment: .center, spacing:8){
            Spacer()
            //MARK: Fields and submit button
           
            Group {
                titleandDescription
                    .padding(.bottom, -12)
                VStack {
                    
                    TextField("Email address", text: $text)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding(.vertical,12)
                        .padding(.horizontal,10)
                        .neoButtonOffShadow(cornerRadius: 15, isTapped: false)
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
                        .focused($isEmailFocused)
                        .onChange(of: isEmailFocused) { isEmailFocused in
                            if isEmailFocused {
                                withAnimation {
                                    
                                    vibrate()
                                    userTyping()
                                    circleY = circleInitialY
                                }
                            }
                        }
                    Divider()
                    
                    
                    SecureField("Password", text: $password)
                        .textContentType(.password)
                        .padding(.vertical,12)
                        .padding(.horizontal,10)
                        .neoButtonOffShadow(cornerRadius: 12, isTapped: false)
                        .focused($isPasswordFocused)
                        .onChange(of: isPasswordFocused, perform: { isPasswordFocused in
                            if isPasswordFocused {
                                withAnimation {
                                    
                                    vibrate()
                                    userTyping()
                                    circleY = circleInitialY + 70
                                    
                                }
                            }
                        })
                }//.offset(y: !infoTapped ? 0 : UIScreen.main.bounds.height * 0.3)
               
                .padding()
                .neoButtonOff(isToggle: false, cornerRadius: 15)
                Button {
                    //model.dismissModal.toggle()
                    login()
                    vibrate()
                    
                } label: {
                    
                    Text(userMessage)
                        .padding(.vertical,9)
                        .padding(.horizontal,28)
                        .neoButtonOffShadow(cornerRadius: 12, isTapped: false)
                        .padding(.horizontal,120)
                        .padding(.top, isEmailFocused || isPasswordFocused ? 0 : 10)
                        .padding(.bottom, isEmailFocused || isPasswordFocused ? 10 : 0)
                        
                }.padding(.top,10)
            }
        }
        .padding(.horizontal, 13.0)
        //.transition(.scale.combined(with: .opacity))
        .offset(y: signInTapped ? 700 : 0)
        .onDisappear(perform: {
            signInTapped = false
        })
        .animation(.spring(), value: animate)
//        .transition(.asymmetric(
//            insertion: .move(edge: .bottom),
//            removal: .move(edge: .bottom)
//        ))
    }
    var titleandDescription: some View{
        
        VStack{
          
            
            if !infoTapped {
                VStack {
                    //  Text(messageDescription)
                    Text("Log in to your account to access your profile. Furthermore, you can sign up if you don't have an account with us. (Sign Up)")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding()
             
                        .onTapGesture {
                            isPasswordFocused = false
                            isEmailFocused = false
                        }
//
                }
                
                
            }
            
        }
    }
    func userTyping(){
        infoTapped = false
    }
    func keyboardTapped(){
        isEmailFocused = false
        isPasswordFocused = false
        vibrate()
    }
    func infoPressed(){
        vibrate()
        isEmailFocused = false
        isPasswordFocused = false
        withAnimation(.spring()) {
            
            infoTapped.toggle()
            
        }
        
       
        
    }
    func vibrate() {
        let impactMed = UIImpactFeedbackGenerator(style: .light)
        impactMed.impactOccurred()
    }
    
    func login() {
        //check animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeInOut(duration: 1)) {
                signInTapped = true
                signIn = true
            }
        }
      
        if infoTapped{
            infoPressed()
        } 
        
        
        
    }
    
    
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        
        ViewController()
         .preferredColorScheme(.light)
        //  helpwithSignin()
        
    }
}





