//
//  SigninView.swift
//  SigninView
//
    import SwiftUI
    import Firebase
    
    struct SigninView: View {
        @AppStorage("currentPage") var selected = 3
        @StateObject var authViewModel = AuthViewModel()
        @AppStorage("currentUser") var currentUserData: String?
        @Binding var currentUser: UserStruct?  // Variable to hold the user data
        @State var email = "zack@gmail.com"
        @State var password = "123456"
        @StateObject var currentUserViewModel = UserViewModel()
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
        @Binding var doneIntro : Bool
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
        @State var hideTopAndBottom = false
        
        var body: some View {
            NavigationView{
                
                ZStack {
                    
                    
                    
                    //MARK: THE TOP ICONS
                    Group{
                        LottieView(filename: "stars" ,loop: true)
                            .frame(width: 380)
                            .offset(x: 0, y: -420)
                        
                        LottieView(filename: "birds" ,loop: true)
                            .frame(width: 380)
                            .offset(x: 0, y: -220)
                        
                        topIcons
                            .offset(y: hideTopAndBottom ? -200 : 0)
                        
                        
                            
                    }.offset(y: signInTapped ? -700 : 0)
                    
                    
                    applogo
                    
                        .scaleEffect(1.2)
                        .offset(y:-50)
                    
                    textandsecureFields
                        .modifier(KeyboardAwareModifier())
                        .offset(y: hideTopAndBottom ? UIScreen.main.bounds.height/2 : 0)
                    
                    
                    
                    
                    
                    
                    
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
                )
                .statusBar(hidden: false)
                
                .navigationBarHidden(true)
                .transition(.scale.combined(with: .opacity))
                
                
            }
            .navigationViewStyle(StackNavigationViewStyle())
           
        }
        var applogo: some View {
           LogoLoadingView(background: false)
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
                    
                    
                    HStack(spacing: 2.0) {
                        Image(systemName: "mail")
                        Divider()
                            .frame(height:8)
                        Text("Sign Up")
                            
                    }.padding(.horizontal,7)
                        .padding(.vertical,5)
                        .background(Color("white"))
                        .cornerRadius(10)
                        .neoButton(isToggle: false, perform: {
                         
                                doneIntro = false
                                
                            
                        })
                      
                        
                      
                   
                    Spacer()
                    NavigationLink(destination:  helpSuggestions) {
                        
                        Image(systemName: "info.circle")
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(infoTapped ? .gray : Color("black"))
                            .font(.title3)
                            .background(.ultraThinMaterial)
                            .cornerRadius(25)
                            .padding(infoTapped ? 8 : 7)
                        
                        
                    }
                    
                    
                    
                }.padding(.horizontal,20)
                   
                
                
                
                Spacer()
            }
        }
        
        var titleandDescription: some View{
    
            VStack{
             
                if !infoTapped {
                    VStack {
                        //  Text(messageDescription)
                        GradientText(text: "Log in to your account to access your profile. Furthermore you can sign up for an account if you have not done so yet.", gradient: [Color("black"), Color("black"), .purple],animate: false)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .padding()
                        //                        .background(
                        //                            Rectangle()
                        //                                .background(.ultraThinMaterial)
                        //                                .opacity(0.10)
                        //
                        //                        )
                        //                        .background(Circle()
                        //                                        .fill(.purple.opacity(0.5))
                        //                                        .blur(radius: 33)
                        //                                        .offset(x:90, y:98)
                        //                                        .frame(width: 266, height: 266)
                        //                        )
                        //        .cornerRadius(20)
                            .onTapGesture {
                                isPasswordFocused = false
                                isEmailFocused = false
                            }
                           
                           
                    }
                    
                    
                }
                
            }
        }
        var helpSuggestions: some View{
            VStack{
                //MARK: Message and questions
                
                
                VStack{
                    Text("How you resolve problems signing into your fusion account depends on the type of issue preventing you from signing in. For example, are you having a password problem? Did you forget your username? Or did you get a message that your account is locked? To help you find the correct solution, select the issue from below that best describes the reason you can't sign in.")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(
                            Rectangle()
                                .background(.ultraThinMaterial)
                                .opacity(0.10)
                            
                        )
                        .background(Circle()
                            .fill(.purple.opacity(0.5))
                            .blur(radius: 33)
                            .offset(x:90, y:98)
                            .frame(width: 266, height: 266)
                        )
                        .cornerRadius(20)
                        .onTapGesture {
                            isPasswordFocused = false
                            isEmailFocused = false
                        }
                }.padding(.bottom, 10)
                
                HStack{
                    VStack (alignment: .leading, spacing: 13){
                        NavigationLink {HelpWithSignIn(
                            doneIntro: $doneIntro,
                            question: 1,
                            showalltextFields: true)}
                    label: {
                        Label("Help with verification",
                              systemImage: "questionmark.circle")
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                    }.padding(.horizontal,20)
                            .padding(.vertical,14)
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                        
                        Divider()
                            .padding(.horizontal, 50)
                        
                        NavigationLink {HelpWithSignIn(
                            doneIntro: $doneIntro,
                            question: 2,
                            backgroundColor: "Background",
                            background: "image_03",
                            icon: "questionmark.circle",
                            titleMessage: "Forgot you email?",
                            titleDescription: "If you forgot your Fusion account email address or you signed in and got the error message, That account may not exist, we recommend you to request a security code to be sent to the phone number or email you used.",
                            askText: "Email/Phone",
                            userMessage: "Submit")}
                    label: {
                        Label("Forgot you email",
                              systemImage: "questionmark.circle")
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                    }.padding(.horizontal,20)
                            .padding(.vertical,14)
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                        
                        Divider().padding(.horizontal, 50)
                        NavigationLink {
                            
                            HelpWithSignIn(
                            doneIntro: $doneIntro, question: 3,
                            backgroundColor: "Background",
                            background: "image_03",
                            icon: "person.circle",
                            titleMessage: "Forgot you password?",
                            titleDescription: "If the password you typed is incorrect, you’ll see a message that says: Your account or password is incorrect. If you don't remember your password, reset it now.",
                            askText: "Email",
                            userMessage: "Reset")
                            
                        }
                    label: {
                        Label("Forgot your password",
                              systemImage: "questionmark.circle")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }.padding(.horizontal,20)
                            .padding(.vertical,14)
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                        
                        Divider().padding(.horizontal, 50)
                        VStack{
                            Button {
                                
                                doneIntro = false
                                signIn = false
                            }
                        label: {
                            Label("Make a new account",
                                  systemImage: "questionmark.circle")
                            
                            Spacer()
                            Image(systemName: "chevron.right")
                            
                        }
                        .padding(.horizontal,20)
                        .padding(.vertical,14)
                        .background(.ultraThinMaterial)
                        .cornerRadius(15)
                        }
                    }
                }
                .foregroundColor(Color("black"))
                Spacer()
                
            }.padding()
                .navigationBarTitle("Trouble signing in ?")
            
            
        }
        var textandsecureFields: some View{
            VStack(alignment: .center, spacing:8){
                Spacer()
                //MARK: Fields and submit button
                
                Group {
                    titleandDescription
                        .padding(.bottom, -12)
                    VStack {
                        
                        TextField("Email address", text: $email)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                           
                           
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
                        
                        HStack(spacing: 5.0) {
                            
                            if !userMessage.isEmpty && userMessage != "Sign in" {
                                ProgressView()
                                    .foregroundColor(.blue)
                            }
                            if userMessage == "Incorrect Password/Email!" {
                                Image(systemName: "shield.slash")
                            }
                            
                            Text(userMessage)
                               
                        } .padding(.horizontal,30)
                            .foregroundColor(userMessage == "Incorrect Password/Email!" ? .red : .blue)
                            .padding(.top, isEmailFocused || isPasswordFocused ? 10 : 10)
                            .padding(.bottom, isEmailFocused || isPasswordFocused ? 10 : 10)
                            .animation(.spring(), value: userMessage)
                            .neoButtonOff(isToggle: false, cornerRadius: 10)
                        
                    }.padding(.top,10)
                }
            }
            .onChange(of:password, perform: { newValue in
                withAnimation(.spring()) {
                    userMessage = "Sign In"
                }
             
            })
            .padding(.horizontal, 13.0)
            //.transition(.scale.combined(with: .opacity))
            .offset(y: signInTapped ? 700 : 0)
            .onDisappear(perform: {
                signInTapped = false
            })
//            .animation(.spring(), value: animate)
            //        .transition(.asymmetric(
            //            insertion: .move(edge: .bottom),
            //            removal: .move(edge: .bottom)
            //        ))
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
            
            if infoTapped{
                
                
                
                infoMessage = "How you resolve problems signing into your fusion account depends on the type of issue preventing you from signing in. For example, are you having a password problem? Did you forget your username? Or did you get a message that your account is locked? To help you find the correct solution, select the issue from below that best describes the reason you can't sign in."
                userMessage = "Try Signing in"
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    showtext = true
                }
                showtext = false
                
                
            } else{
                messageDescription = "Log in to your account to access your profile. Furthermore, you can sign up if you don't have an account with us. (Sign Up)"
                infoMessage = ""
                showtext = false
                userMessage = "Sign In"
                
            }
            
        }
        func vibrate() {
            let impactMed = UIImpactFeedbackGenerator(style: .light)
            impactMed.impactOccurred()
        }
        
        func login() {
           
            
            if infoTapped{
                infoPressed()
            } else {
                //check animation
              
                
                
                authViewModel.signIn(email: email, password: password)  { success, error in
                    if success {
                        let db = Firestore.firestore()
                        let user = Auth.auth().currentUser
                        // Set the data to update
                        
                        db.collection("users").whereField("email", isEqualTo: user?.email ?? "")
                            .getDocuments() { (querySnapshot, error) in
                                if error != nil {
                                    
                                } else {
                                    for document in querySnapshot!.documents {
                                        db.collection("users").document("\(document.documentID)").setData(["online": true], merge: true) { error in
                                            
                                            if error == nil {
                                                
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        
                        //if the auth is  successful
                        userMessage = "Checking info..."
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            userMessage = "Successful..."
                            vibrate()
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            userMessage = "Signing you in..."
                            vibrate()
                            currentUserViewModel.fetchCurrentUser()
                         
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation(.spring()){
                                //finally log the user in
                                
                                if let userData = currentUserData, let user = UserStruct.fromJSONString(userData) {
                                    currentUser = user
                                } else {
                                    // Example fake user data
                                    let fakeUserLocal = currentUserViewModel.currentUser
                                    currentUser = currentUserViewModel.currentUser
                                    currentUserData = fakeUserLocal?.toJSONString()
                                    
                                  
                                }
                                
                                    if currentUser != nil {
                                        userMessage = "Signing you in \(currentUser?.firstName ?? "..")"
                                        vibrate()
                                        self.signIn = true
                                        UserDefaults.standard.set(true, forKey: "signIn")
                                        
                                        
                                        hideTopAndBottom = true
                                    } else {
                                        userMessage = "There was a problem!"
                                        vibrate()
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                            userMessage = "Couldn't find user data!"
                                        }
                                        self.signIn = false
                                        UserDefaults.standard.set(false, forKey: "signIn")
                                    }
                                    
                                
                               
                              
                            }
                            
                        }
                        
        
                        
                    } else if let error = error {
                        //if the auth is unsuccessful
                        UserDefaults.standard.set(false, forKey: "signIn")
                        //                        self.alertMessage = error?.localizedDescription ?? ""
                        //if the auth is not successful
                        userMessage = "Checking info..."
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            userMessage = "Incorrect Password/Email!"
                        }
                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                            userMessage = "\(error.localizedDescription )"
                                        }
                    }
                }
            }
            
            
            
        }
        
        
    }

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        
        ViewController()
      
        
    }
}





