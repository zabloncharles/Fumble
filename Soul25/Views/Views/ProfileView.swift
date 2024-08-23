//
//  ProfileView.swift
//  Soul25
//
//  Created by Zablon Charles on 4/14/24.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("hidemainTab") var hidemainTab = false
    @Binding var currentUser: UserStruct?
    @Binding var signedIn : Bool
    @State var profile : UserStruct = fakeUser
    @State var editingProfile = false
    @State var isSheetPresented = false
    @State var currentIndex = 0
    
    var body: some View {
        ZStack {
          
          
            SkullProfile(currentUser: $currentUser, profile: profile, showProfile:  $isSheetPresented, editingProfile: editingProfile, currentIndex: $currentIndex,likedEmails: .constant([""]), dislikedEmails: .constant([""]))
            
           
               
                    
                    
                   
                    
                
            
           
        }.onAppear{
            profile = currentUser ?? fakeUser
            editingProfile = true
            
            withAnimation(.spring()) {
                hidemainTab = false
            }
           
        }
//        .onChange(of: currentIndex, perform: { newValue in
//            if isSheetPresented {
//                withAnimation(.spring()) {
//                    hidemainTab = true
//                }
//            } else {
//                withAnimation(.spring()) {
//                    hidemainTab = false
//                }
//            }
//            if currentIndex == -4 || currentIndex == -2 {
//                isSheetPresented = true
//            }
//        })
        
        //show the tab bar when the settings are dismissed
        .onChange(of: isSheetPresented, perform: { newValue in
            if isSheetPresented {
                withAnimation(.spring()) {
                    hidemainTab = true
                }
            } else {
                withAnimation(.spring()) {
                    hidemainTab = false
                }
            }
           
        })
        .sheet(isPresented: $isSheetPresented) {

            if currentIndex == -4 {
                NavigationView {
                    SettingsView(currentUser: $currentUser, isSheetPresented: $isSheetPresented)
                }
                
                
            } else if currentIndex == -2   {
                NavigationView {
                    EditProfileInfoDetailView(signedIn: $signedIn, isSheetPresented: $isSheetPresented)
                }
            }  else {
                Text("There was an error loading that view!")
                    .onAppear{
                        isSheetPresented = false
                    }
            }


              
            }
  
        
      
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
