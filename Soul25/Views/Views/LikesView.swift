//
//  LikesView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/14/23.
//

import SwiftUI

struct LikesView: View {
    @AppStorage("currentPage") var selected = 0
    @AppStorage("hidemainTab") var hidemainTab = false
    @State var userScrolledDown : Bool = false
    @State var pageAppeared = false
    @Binding var profiles: [UserStruct] 
    @Binding var currentUser: UserStruct?
    @State var profile = fakeUsers[0]
    @State var dataMessages = "Getting your likes :)"

    @State var indexRemoved = 0
    @State var unmatch = false
    @Namespace var namespace
    @State  var showProfile = false
    @State var profileAppeared = false
    @State var profilesReady = false
    @State var profileLoaded = 0
    @State var showError = false
    @State var noProfiles = false
    @State var profileUrl = ""
    @State var currentIndex = 0
    @State var showX = false
    @State var animateX = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            //hearts animation
            
            
            
            if profiles.count != 0{
                
                
                
                stories
                
               
                  
                
                    if profileLoaded < 5 {
                        loading
                    }
                  
                   
                
            }
            if profiles.isEmpty && showError {
                topbar
                girlanimation
                nolikes
            }
            
            
            
            
            
           
            
          showprofile
              
            if   showX {
                
                
                Image(systemName: "xmark")
                    .font(.title)
                    .bold()
                    .foregroundColor(.red)
                    .scaleEffect(animateX ? 1.5 : 1)
                    .rotationEffect(.degrees(animateX ? 90 : 0))
                    .animation(.spring(), value: animateX)
                    .onAppear{
                        withAnimation(.spring()) {
                            animateX = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation(.spring()) {
                                
                                showX = false
                                animateX = false
                            }
                        }
                    }
            }
            
        }.onAppear{
            profileAppeared = true
            
            withAnimation(.spring()){
                hidemainTab = false
            }
           
//            if loading for 10 seconds show error
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                showError = true
            }
           
        }
        .onChange(of: unmatch || showProfile) { newValue in
            //
            
            
            if !showProfile {
                withAnimation(.spring()) {
                    showX = true
                   
                }
            }
            
            
            withAnimation(.spring()) {
             
                if showProfile {
                    
              
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        
                        withAnimation(.spring()) {
                            
                            removeCurrentIndexFunc()
                            
                        }
                        
                        
                        
                    }
                }
                
                
                    if !showProfile && unmatch {
                        profiles.remove(at: indexRemoved)
                        // Remove the first item from the array when it appears
                    }
                
                
            }
                
            
        }
        
        
    }
   
    var showprofile: some View {
        ZStack {
            if showProfile {
                SkullProfile(currentUser: $currentUser, profile: profile, showProfile: $showProfile, currentIndex: .constant(0))
                    .padding(.top,37)
                    .padding(.bottom,-80)
                    .animation(.spring(), value: showProfile)
                    .cornerRadius(showProfile ?  40 : 43)
                    .edgesIgnoringSafeArea(.all)
                    .offset(y: !showProfile ? UIScreen.main.bounds.height : 0)
                    
                   
                    .transition(.asymmetric(
                        insertion: .push(from: .bottom),
                        removal: .push(from: .top)))
                    .animation(.spring(), value: showProfile)
                
                   
                    .onAppear{
                        profileAppeared = true
                        hidemainTab = true
                    }
                    .onDisappear{
                        profileAppeared = false
                        hidemainTab = false
                      
                    }
                   
            }
        }
    }
  
    var topbar: some View {
        VStack {
            HStack {
                HStack {
                    Image(systemName: "fleuron")
                    Text("Likes You")
                    
                }.font(.title3)
                    .fontWeight(.bold)
                Spacer()
                HStack {
                    Image(systemName: "fleuron")
                    Text("Boost")
                }.padding(.horizontal,12)
                    .padding(.vertical,5)
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(20)
                
            }
                .padding(15)
                .neoButtonOff(isToggle: false, cornerRadius: 16)
//                .offset(y: pageAppeared ? 0 : -300)
            Spacer()
        }.padding(20)
          
          
    }
    var girlanimation: some View {
        VStack {
            LottieView(filename: "girllikingstuff" ,loop: true)
                .frame(width: 280)
                .opacity(pageAppeared ? 1 : 0)
            
        }.offset(y:-160)
    }
    var maintabanimationhearts: some View{
        VStack {
            LottieView(filename: "loveflying" ,loop: true)
                .frame(width: 100)
                .opacity(pageAppeared ? 1 : 0)
            
        }.offset( x:-40, y:280)
            .opacity(0.7)
    }
    var loading : some View {
        VStack(alignment: .center) {
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color("black")))
            
        }
    }
    var nolikes: some View {
        VStack(alignment: .center, spacing: 20.0) {
          
                
                VStack(alignment: .center) {
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        
                }
            
            Text(dataMessages)
                .font(.headline)
            Text("Likes are more intentional on Fumble so don't worry, They'll come in very soon.")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            HStack {
                Text("Try boosting your profile")
                    .font(.body)
                    .fontWeight(.semibold)
            }.padding(.horizontal,15)
                .padding(.vertical,10)
                .background(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0))
                .cornerRadius(30)
        }.padding(20)
            .offset(y:  profileLoaded < 2 ? 0 : UIScreen.main.bounds.height )
        
    }
   
    var stories : some View {
        VStack {
            DynamicTopBar(label: "likes", labelicon: "fleuron"){
                
            }.background{
                ScrollDetectionView(userScrolledDown: $userScrolledDown)
            }
            ScrollView(.vertical,showsIndicators: false){
                
               
                    
                ScrollView(.horizontal,showsIndicators: false){
                    HStack(spacing: 15.0){
                        VStack {
                            
                            Circle()
                            
                                .fill(.angularGradient(colors: [.purple, .orange, .purple], center: .center, startAngle: .degrees(0), endAngle: .degrees(360)))
                            
                                .overlay(
                                    Image(systemName: "plus")
                                        .font(.headline)
                                        .foregroundColor(Color("black"))
                                )
                                .frame(width: 65,height: 65)
                                .cornerRadius(60)
                                .neoButton(isToggle: false) {
                                    //Start matching
                                    selected = 0
                                }
                            
                            Text("Start Matching")
                                .font(.footnote)
                                .lineLimit(1)
                            
                        }
                        ForEach(profiles, id: \.id) { user in
                            VStack {
                                
                                GetImageAndUrl(url:user.avatar, loaded: .constant(true), imageUrl: .constant(""))
                                    .frame(width: 65,height: 65)
                                    .cornerRadius(60)
                                    .overlay (
                                        ZStack {
                                            
                                            CircularView(value: Double(99.9) / 100.0,lineWidth: 1.0,colors: [Color("black")])
                                                .padding(-1)
                                            
                                            
                                            //This one shows the percentage of match
                                            CircularView(value: Double(56.9) / 100.0,lineWidth: 1.0,colors: [Color.green.opacity(0.67),Color.green])
                                                .padding(-1)
                                            
                                            
                                        }
                                    )
                                    .neoButton(isToggle: false) {
                                        //when a story is clicked
                                        showProfile = true
                                        profile = user
                                    }
                                
                                Text(user.firstName)
                                    .font(.footnote)
                                    .lineLimit(1)
                            }
                        }
                    }
                    .offset(x:  profileLoaded > 5 ? 0 : UIScreen.main.bounds.width )
                    .padding(.top,5)
                    
                    .offset(x:10)
                }.padding(.top, 2)
                Divider()
                likesprofiles
            }.coordinateSpace(name: "scroll")
        }
    }
    var likesprofiles : some View {
      
                VStack(spacing: 25.0) {
          
                    ForEach(Array(profiles.enumerated()), id: \.element.id) { index, user in
                            //
                        PostCard(firstname: user.firstName,avatar: user.avatar, post: user.photos[0], indexRemoved: $indexRemoved, imageUrlReturned: $profileUrl, imageLoaded: $profileLoaded, unmatch: $unmatch, index: index){
                            //tapp does what?
                            currentIndex = index
                            profile = user
                            
                            withAnimation(.spring()) {
                                showProfile = true
                                
                            }
                            
                            
                        }
                    
                           
                            .padding(.bottom,5)
                        if index != profiles.count - 1{
                            Divider()
                        }
                        }
                    
                    
                        
                }
                .padding(.top,20)
                .padding(.bottom,80)
                .offset(y:  profileLoaded > 5 ? 0 : UIScreen.main.bounds.height )
            .animation(.spring(), value: profileLoaded)
            
        
    }
    var filteredProfiles: [UserStruct] {
        guard let currentUser = currentUser
        else {
            return profiles
        }
        let matchingEmails = Set(currentUser.matched)
        return profiles.filter { matchingEmails.contains($0.email) }
    }
    
    func removeCurrentIndexFunc(){
        profiles.remove(at: currentIndex)
    }
 
    func getDataMessages(){
        
        if profileLoaded < 2 {
            dataMessages = "Getting your likes :)"
        }
        if profileLoaded > 5 {
            profilesReady = true
        }
    }
}

struct LikesView_Previews: PreviewProvider {
    static var previews: some View {
        // LikesView( currentUser: .constant(fakeUser))
        ViewController()
            .preferredColorScheme(.dark)
    }
}
