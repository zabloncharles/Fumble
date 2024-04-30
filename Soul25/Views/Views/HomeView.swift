//
//  HomeView.swift
//  iOS15
//
//  Created by Zablon Charles on 2021-06-22.

import CoreLocation
import SwiftUI
import Lottie

struct HomeView: View {
    @Binding var profiles: [UserStruct]
    @State private var filteredProfiles: [UserStruct] = []
    @Binding var currentUser: UserStruct?
    @State var profile = fakeUsers[0]
    @State var profiletype = 0
    @State var profilesLoaded = 0
    @State var userScrolledDown : Bool = false
    @AppStorage("currentPage") var selected = 0
    @State var contentHasScrolled = false
    @State var noCardsPageAppeared = false
    @State var loadingIcon = false
    @State var showProfile = false
    @AppStorage("hidemainTab") var hidemainTab = false
    
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            if loadingIcon  {
                loading
            }
            
            VStack {
                topbar
                    .padding(.top,40)
                ScrollView {
                        ScrollDetectionView(userScrolledDown: $userScrolledDown)
                     
                         
                  
    //                       CompatibleProfilesCards(profile: $profile, showProfile: $showProfile)
                           FeedView(profiles: $profiles, profile: $profile, showProfile: $showProfile)
                       
                        
                        if (profiles.count < 1) {
                           nocards
                       }
                    } .coordinateSpace(name: "scroll")
                    .cornerRadius(showProfile ? 25 : 0)
                .scaleEffect( showProfile ? 0.98 : 1)
            }
                
            
            
            // show the profile of the user in full view
          
               
                    SkullProfile(currentUser: $currentUser, profile: profile, showProfile: $showProfile, currentIndex: .constant(0))
                        .animation(.spring(), value: showProfile)
                        .cornerRadius(showProfile ?  40 : 43)
                        .padding(.top,selected == 2 ? 30 : 0)
                    .offset(y: !showProfile ? UIScreen.main.bounds.height *  1.02 : 0)
                    .onChange(of: showProfile, perform: { newValue in
                        if showProfile {
                                withAnimation(.spring()){
                                    hidemainTab = true
                                  
                                    
                                }
                        } else {
                            withAnimation(.spring()){
                                
                                hidemainTab = false
                               
                            }
                        }
                    })
                   
                
            
        }.edgesIgnoringSafeArea(.all)
            
    }
    var loading : some View {
        VStack(alignment: .center) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color("black")))
        }
    }
    var topbar : some View {
        VStack {
            // current signed in user card
          
                    //app name and right system icons
                navigation
                        
                        .padding(.bottom,-10)
               
            
            Divider()
            // type of profiles cards section
            typeofprofiles
//                .opacity(userScrolledDown ? 1 : 0)
//                .scaleEffect(userScrolledDown ? 1 : 0.86)
            if userScrolledDown {
                Divider()
            }
        }
    }
    var nocards: some View {
      NoProfilesView(pageAppeared: $noCardsPageAppeared, profiletype: $profiletype)
    }
    var navigation: some View {
        HomeHeaderView(contentHasScrolled: $contentHasScrolled, showProfile: $showProfile, profiletype: $profiletype, count: "\(profiles.count)")
    }
    
    var typeofprofiles : some View {
        HStack{
            
            
            TypeofMenuRow( tap: $profiletype, selected: 0, placeholder: "COMPATIBLE"){
                
            }
            Spacer()
            Rectangle()
                .frame(width: 1,height: 12)
            TypeofMenuRow(tap: $profiletype, selected: 1, placeholder: "ACTIVE"){
                
            }
            Spacer()
            Rectangle()
                .frame(width: 1,height: 12)
            TypeofMenuRow(tap: $profiletype, selected: 2, placeholder: "NEAR"){
                
            }
            Spacer()
            Rectangle()
                .frame(width: 1,height: 12)
            TypeofMenuRow(tap: $profiletype, selected: 3, placeholder: "NEW HERE"){
                
            }
        }
            .padding(.vertical,5)
            .padding(.horizontal,20)
    }
    
    

}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        ViewController()
        
        
    }
}

