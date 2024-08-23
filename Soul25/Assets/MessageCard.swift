//
//  MessageCard.swift
//  ionicFusion
//
//  Created by Zablon Charles on 8/19/23.
//



import Foundation
import SwiftUI


struct MessageCard: View {
    var section : UserProfile
    @State var isTapped = false
    @State var whoSent = ["Sent","Received","Seen"]
    @State var image = ""
    var index = 0
    @State private var xOffset: CGFloat = 0
    @State var unmatched = false
    @State var animateArrow = false
    var body: some View {
       ZStack {
            
         
              
           VStack {
               HStack(alignment: .center) {
                       Spacer()
                   Image(systemName: "chevron.left.2")
                       .offset(x: animateArrow ? -10 : 0) // Move HStack to the left when moveLeft is true
                     
                   
                       
                   Text(xOffset < -262 ? "Unmatched :(" : "Unmatch")
                       .padding(.trailing)
                         
                       
                   }.foregroundColor(.red)
                 
              
           }
               .padding(.vertical)
//               .background(.red)
               .cornerRadius(12)
               .padding(.bottom,10)
           
               
            
           VStack {
               HStack(alignment: .center, spacing: 8) {
                  //  Image(section.avatar)
                      //  .resizable()
                      //  .aspectRatio(contentMode: .fill)
                   GetImageAndUrl(url:section.avatar, loaded: .constant(true), imageUrl: $image)
                        .frame(width: 49, height: 49)
                        .mask(Circle())
                       
                       
                        .neoButton(isToggle: false) {
                            //user tapped the avatar
//                            showProfile = true
//                            profile = section
                        }
    //                    .onTapGesture {
    //                        showProfile = true
    //                        profile = section
    //                    }
                    VStack(alignment: .leading, spacing: 4) {
                        
                        
                        // GradientText(text: section.name, gradient: [.black, .blue])
                        Text(section.name)
                            .font(.headline)
                            .foregroundColor(Color("black"))
                        Text(section.lastMessage.isEmpty ? "there's no message" : section.lastMessage)
                            .font(.footnote)
                            .foregroundColor(section.userId == section.myEmail ? .gray : .blue)
                            .lineLimit(1)
                        
//                        Text(whoSent[0])
//                            .font(.footnote)
//                            .foregroundColor(.gray)
//                            .lineLimit(1)
                        
                    }
                    Spacer()
                    HStack {
                        Text(section.timestamp.isEmpty ? "there's no time" :  formatDate(time: section.timestamp))
                            .font(.caption)
                            .foregroundColor(.gray )
                        
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(.gray )
                        
                    }
                    
                    
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(Color("offwhiteneo"))
                .offset(x: xOffset, y: 0) // Move text horizontally based on xOffset
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            
                            if value.translation.width < 0 {
                                xOffset = value.translation.width
                                withAnimation(.linear(duration: 1).repeatCount(15)) {
                                    animateArrow = true
                                }
                            }
                            
                        }
                        .onEnded { value in
                            withAnimation {
                                animateArrow = false
    //                            xOffset = 0 // Reset xOffset when dragging ends
                                if xOffset < -262 {
                                    xOffset = -UIScreen.main.bounds.width
                                    unmatched = true
                                   
                                } else {
                                    xOffset = 0
                                    vibrate()
                                }
                            }
                        }
                )
          
               Divider()
              
           }
            
          
       }.frame(height: unmatched ? 0 : nil)
            .opacity(unmatched ? 0 : 1)
    
           
        
    }
    func formatDate(time:String) -> String{
        
        let dateFormatter = DateFormatter()
        // dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timedate = dateFormatter.date(from: time) ?? Date()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: timedate)
        
    }
    // Function to filter profiles by email
 
    func vibrate() {
        let impactMed = UIImpactFeedbackGenerator(style: .soft)
        impactMed.impactOccurred()
    }
    
}




struct MessageCArd_Previews: PreviewProvider {
    static var previews: some View {
        ViewController()
    }
}
