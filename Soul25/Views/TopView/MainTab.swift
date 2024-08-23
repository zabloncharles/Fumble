//Created by Zablon Charles.


import SwiftUI
import Firebase

struct MainTab: View {
    @AppStorage("signedIn") var signedIn = false
    @Binding var onboardComplete : Bool
    @AppStorage("currentUser") private var currentUserData: String?
    @State var currentUser: UserStruct?  // Variable to hold the user data
    @AppStorage("currentPage") var selected = 3
    @AppStorage("hidemainTab") var hidemainTab = false
    @State var matchProfiles: [UserStruct] = fakeUsers
    @State var chatProfiles: [UserStruct] = fakeUsers
    @State var likesProfiles : [UserStruct] = []
    @State var homeProfiles: [UserStruct] = fakeUsers
    @State var likedEmails = [""]
    @State var dislikedEmails = [""]
    
   @State var appLoading = true
    @StateObject private var authLikedModel = AuthLikedModel()
    @ObservedObject var viewModel = BooksViewModel()
    @ObservedObject var userViewModel = UserViewModel()
    @StateObject private var authModel = AuthViewModel()
    @StateObject private var currentUserViewModel = UserViewModel()
 

    var body: some View {
        
        ZStack {
            BackgroundView()
            if  signedIn   {
                ZStack {
                    NavigationView {
                        VStack{
                            
                            if self.selected == 0{
                                MatchView(profiles: $matchProfiles, likedEmails:$likedEmails, dislikedEmails: $dislikedEmails, currentUser: $currentUser)
                                    .overlay{
                                        if userViewModel.users.count < 2 {
                                            Text("\(userViewModel.users.count)")
                                            
//                                            BackgroundView()
//                                            ProgressView()
//                                            LogoLoadingView(animateForever: true)
                                               
                                        }
                                    }
                            }
                           if self.selected == 1{
                               LikesView(profiles: $likesProfiles, currentUser: $currentUser, likedEmails:$likedEmails, dislikedEmails: $dislikedEmails)
                                   .onAppear{
                                       //get likes
                                       authLikedModel.fetchLikedUsers()
                                       DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                           likesProfiles = authLikedModel.likedUsers
                                           
                                       }
                                   }
                                   
                            }
                            if self.selected == 2{
                                
                                HomeView(profiles:$homeProfiles, currentUser: $currentUser,likedEmails:$likedEmails, dislikedEmails: $dislikedEmails)
                            }
                            if self.selected == 3{
                                ChatsView(profiles: $chatProfiles,likedEmails:$likedEmails, dislikedEmails: $dislikedEmails, messagesModel: viewModel)
                            }
                            if self.selected == 4{
                                ProfileView(currentUser: $currentUser, signedIn: $signedIn)
                            }
                        }
                    }
                    
                    //the tab bar // it also gets the chat notifications
                    FloatingTabbar(selected: self.$selected,chatCount: "00", likeCount: likesProfiles.count)
                        .offset(y:  hidemainTab  ? UIScreen.main.bounds.height * 0.13 : 0)
                        .animation(.spring(), value: hidemainTab)
                       
                        
                }.opacity(appLoading ? 0 : signedIn ? 1 : 0)
                    
                    .onAppear{
                        withAnimation(.spring()) {
                            hidemainTab = false
                        }
                        
//                            userViewModel.fetchUsers()
//                            currentUser = currentUserViewModel.currentUser
                        
                        getCurrentUser()
                        
                       
                        //get likes
//                        authLikedModel.fetchLikedUsers()
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//                            likesProfiles = authLikedModel.likedUsers
//
//                        }
                        //get match profiles
                        switch selected {
                            case 0:
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    getFakeRecommendedProfiles()
                                }
                            case 1:
                                // Get likes profiles
                                getFakeLikesProfiles()
                            case 2: // Changed from 3 to 2 since 2 corresponds to the third case
                                    // Get chat profiles
                                getFakeChats()
                            
                            default:
                                // Get chat profiles as default
                                getFakeChats()
                        }
                  
                    
                        
                        
                            
                        if currentUser == nil && signedIn {
                            
                            getCurrentUser()
                        }
                }
                    
            } else {
                SigninView(currentUser: $currentUser, signIn: $signedIn, doneIntro: $onboardComplete)
                    .onAppear{
                        currentUserData = nil
                    }
                
            }
            
            //show app loading view
            if appLoading || signedIn && matchProfiles == nil {
                LogoLoadingView(animateForever: true, background: false)
                    .scaleEffect(1.2)
                    .offset(y:-50)
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            withAnimation(.easeInOut){
                                appLoading = false
                            }
                        }
                    }
            }
          

           
            
        }.onChange(of: selected) { newValue in
            //get match profiles
            switch selected {
                case 0:
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        getFakeRecommendedProfiles()
                    }
                case 1:
                    // Get likes profiles
                    getFakeLikesProfiles()
                case 2: // Changed from 3 to 2 since 2 corresponds to the third case
                        // Get chat profiles
                    getFakeChats()
                default:
                    // Get chat profiles as default
                    getFakeChats()
            }
            
           
            
        }
        
    }
    
   
    
    func getFakeRecommendedProfiles(){
        // Filter the profiles based on whether their email is in the likedEmails array
        
        matchProfiles = userViewModel.users
        
//        fetchUserData(parameter: "") { users in
//            matchProfiles = users ?? fakeUsers
//        }
    }
    func getFakeLikesProfiles(){
        // Filter the profiles based on whether their email is in the likedEmails array
        let disliked = dislikedEmails
        likesProfiles = fakeUsers.filter { profile in
            !disliked.contains(profile.email)
        }
    }
    func getFakeChats() {
        // Filter the profiles based on whether their email is in the likedEmails array
//        let liked = likedEmails
//        chatProfiles = fakeUsers.filter { profile in
//            liked.contains(profile.email)
//        }
        
//        self.viewModel.fetchData()
    }
    
    func getCurrentUser(){
        if let userData = currentUserData, let user = UserStruct.fromJSONString(userData) {
            currentUser = user
        }
    }
   
    var signedInError : some View {
        ZStack {
            
            VStack {
                LottieView(filename: "loveflying" ,loop: true)
                    .frame(width: 100)
                
                
            }.offset( x:-40, y:280)
                .opacity(0.7)
            
            VStack {
                LottieView(filename: "sadheart" ,loop: true)
                    .frame(width: 280)
                
                
            }.offset(y:-160)
            
            
            VStack {
                
                
                Spacer()
                
                VStack(alignment: .center, spacing: 20.0) {
                    
                    Text("Error loading user!")
                        .font(.headline)
                    Text("There was an error getting user information!")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    HStack {
                        Text("Reload Again")
                            .font(.body)
                            .fontWeight(.semibold)
                    }.padding(.horizontal,15)
                        .padding(.vertical,10)
                        .background(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0))
                        .cornerRadius(30)
                        .neoButton(isToggle: false) {
                            //log error
                        }
                    
                }.padding(10)
                
                
                
                
                Spacer()
            }.padding(20)
        }.background{
            BackgroundView()
        }
    }
}


struct MainTab_Previews: PreviewProvider {
    static var previews: some View {
       // MainTab( course: .constant(Course))
        ViewController()
           // .preferredColorScheme(.dark)
            
    }
}

struct FloatingTabbar : View {
    
    @Binding var selected : Int
    @Namespace var namespace
    @State var tappedicon = false
    var chatCount = ""
    var likeCount = 0
    let generator = UINotificationFeedbackGenerator()
    
    var body : some View{
        
        VStack(){
           
               
            GeometryReader { proxy in
            let hasHomeIndicator = proxy.safeAreaInsets.bottom > 0
           
               
                HStack( alignment: .center, spacing: 17.0){
               
                  
                TabIcon(selected: $selected, selectedicon: 0, icon: "rectangle.portrait.on.rectangle.portrait.angled", name:"Match" ,tappedicon: $tappedicon )
                Spacer()
                TabIcon(selected: $selected, selectedicon: 1, icon: "fleuron",name:"Likes" , tappedicon: $tappedicon )
                        .overlay{
                            if likeCount != 0 {
                                VStack{
                                    
                                    
                                    ZStack {
                                        Circle()
                                            .fill(Color(red: 0.998, green: 0.268, blue: 0.227))
                                            .padding(-2)
                                            .frame(width: 5, height: 5)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                        .offset(x:-5, y: 1)
                                    }
                                }
                            }
                        }
                Spacer()
                TabIcon(selected: $selected, selectedicon: 2, icon: "person.2" , name:"Explore" ,tappedicon: $tappedicon )
                Spacer()
                TabIcon(selected: $selected, selectedicon: 3, icon: "bubble.left.and.bubble.right",name:"Chats" , tappedicon: $tappedicon )
                        .overlay{
                            if !chatCount.isEmpty {
                                VStack{
                                   
                                  
                                            Circle()
                                                .fill(Color(red: 0.998, green: 0.268, blue: 0.227))
                                                .padding(-2)
                                                .frame(width: 5, height: 5)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                        .offset(x:-5, y: 1)
                                }
                            }
                         }
                Spacer()
                TabIcon(selected: $selected, selectedicon: 4, icon: "person.2.badge.gearshape",name:"Profile" , tappedicon: $tappedicon )
                
         
           
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: hasHomeIndicator ? 64 : 64)
            .padding(.horizontal,20)
             .background(
                GeometryReader { geometry in
                    Rectangle()
                        .fill(Color("black").opacity(0.10))
                        .frame(height: 1)
                        .padding(.bottom, geometry.size.height) // Position the border at the bottom
                }
            )
             .background(Color("offwhiteneo"))
            .background(Image("cover2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            
                            .offset(x: self.selected == 0 ? -90 : self.selected == 1 ?  -20 : self.selected == 2 ? 40 :self.selected == 3 ? 90 : 0)
                            .animation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 1), value: selected)
                            
                           
            )
            
//            .offwhitebutton(isTapped: tappedicon, isToggle: false, cornerRadius: 36, )
         //   .background(.ultraThinMaterial)
           // .cornerRadius(36)
//            .scaleEffect(tappedicon ? 0.97 : 1)
            .animation(.spring(), value: tappedicon)
//            .padding(.horizontal, 61.0) //makes tabbar smaller
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
         
            
        }
       
        
        }
    }
    
 
}


struct TabIcon: View {
    @Binding var selected : Int
    var selectedicon : Int = 0
    var icon : String = "person"
    var tapped: String = ".fill"
    var name = "Name"
    let generator = UINotificationFeedbackGenerator()
    @Binding var tappedicon : Bool
   
    var body: some View {
        Button(action: {
            self.selected = selectedicon
            
            vibrate()
            
            tappedicon = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                tappedicon = false
            }
        }) {
            VStack(spacing:2){
                VStack {
                    Image(systemName: self.selected == selectedicon ? "\(icon)\(tapped)" : icon)
                        .foregroundColor(self.selected == selectedicon ? .red  : .gray).padding(.horizontal)
                        .background(Circle()
                                        .fill(self.selected == selectedicon ? .red : .clear)
                                        .animation(.spring(), value: tapped)
                                        
                                        .blur(radius: 19)
                                        .opacity(0.4)
                    )
                }.frame(width: 40, height: 30)
                if self.selected == selectedicon {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.4, blendDuration: 1)) {
                        Rectangle()
                            .fill(.red)
                            .frame(width: 8, height: 1)
                    }
                }
                Text(name)
                    .font(.footnote)
                    .foregroundColor(self.selected == selectedicon ? .red : .gray)
            }
             
        }
    }
    func vibrate() {
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
}
}
