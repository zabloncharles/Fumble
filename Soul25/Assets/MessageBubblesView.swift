//
//  MessageBubblesView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 8/19/23.
//


import SwiftUI


struct MessageBubblesView: View {
    
    
    var section: MessageModel
    @State var messageTapped = false
    var message = "You still tryna go"
    var messageTime = "2:30 PM"
    @Binding var blurPage : Bool
    @Binding var messageDeleted : Bool
    var avatar = ""
    @State var showDate = false
    @Binding var bTapped : String
    @State var tappedUserAvatar = ""
    @Binding var goToProfile : Bool
    var body: some View {
        
        if section.userID == "user1" {
            
            HStack {
                Rectangle()
                    .fill(.clear)
                    .frame(width: 100, height: 20)
                Spacer()
                VStack(alignment: .trailing, spacing: 2.0) {
                    ZStack {
                        
                        VStack {
                            if showDate && bTapped == section.timestamp {
                                HStack {
                                    HStack {
                                        Image(systemName: "hand.thumbsup")
                                        Text("Like")
                                            .foregroundColor(.green)
                                    }.padding(5).offwhitebutton(isTapped: !blurPage, isToggle: true, cornerRadius: 5, action: $blurPage)
                                    Rectangle()
                                        .fill(Color.black)
                                        .frame(width: 0.4, height: .infinity)
                                    HStack {
                                        Image(systemName: "trash")
                                        Text("Delete")
                                            .foregroundColor(.red)
                                    }.padding(5).offwhitebutton(isTapped: !blurPage, isToggle: true, cornerRadius: 5, action: $messageDeleted)
                                }.font(.footnote)
                                    .padding(10)
                                    .offset(y: -60)
                                    .onAppear{
                                        withAnimation(.easeIn) {
                                            blurPage = true
                                        }
                                    }
                                    .onDisappear{
                                        withAnimation(.easeIn(duration: 0.30)) {
                                            blurPage = false
                                            showDate = false
                                        }
                                    }
                                   
                            }
                        }
                   
                           
                            Text(section.text)
                                .fontWeight(.medium)
                                .foregroundColor(Color("black"))
                                .font(.subheadline)
                                .padding(.horizontal, 11.0)
                                .padding(.vertical, 9.0)
                                .background(Color("neolighshadow"))
                                .cornerRadius(12)
                                .background{
                                    HStack {
                                        Spacer()
                                        VStack {
                                            Spacer()
                                            
                                            Rectangle()
                                                .fill(Color("neolighshadow"))
                                                .frame(width:20, height: 20)
                                        }
                                        
                                    }
                                    
                                }
                                .neoDoubleTapButton(isToggle: false, perform: {
                                    withAnimation(.easeIn) {
                                        bTapped = section.timestamp
                                        showDate.toggle()
                                    }
                                })
                            .padding(.bottom,9)
                        
                    }
                    
                    
                    
                    Text(showDate ? section.timestamp : section.stamp)
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 3.0)
                    
                }
                .padding(.horizontal)
                .multilineTextAlignment(.leading)
                .animation(.spring(), value: blurPage)
               
            }
        } else {
            
            HStack {
                
                VStack(alignment: .leading, spacing: 2.0) {
                    ZStack {
                        
                        
                        if showDate && bTapped == section.timestamp {
                            HStack {
                                HStack {
                                    Image(systemName: "hand.thumbsup")
                                    Text("Like")
                                        .foregroundColor(.green)
                                }.padding(5).offwhitebutton(isTapped: !blurPage, isToggle: true, cornerRadius: 5, action: $blurPage)
                                Rectangle()
                                    .fill(Color.black)
                                    .frame(width: 0.4, height: .infinity)
                                HStack {
                                    Image(systemName: "trash")
                                    Text("Delete")
                                        .foregroundColor(.red)
                                }.padding(5).offwhitebutton(isTapped: !blurPage, isToggle: true, cornerRadius: 5, action: $messageDeleted)
                            }.font(.footnote)
                                .padding(10)
                                .offset(y: -60)
                                .onAppear{
                                    withAnimation(.easeIn(duration: 0.30)) {
                                        blurPage = true
                                    }
                                }
                                .onDisappear{
                                    withAnimation(.easeIn(duration: 0.30)) {
                                        blurPage = false
                                        showDate = false
                                    }
                                }
                                
                        }
                        
                        VStack {
                            HStack {
                                VStack {
                                    Spacer()
                                    
                                    GetImageAndUrl(url:avatar, loaded: .constant(true), imageUrl: .constant(""))
                                        .cornerRadius(80)
                                        .neoButton(isToggle: false) {
                                            //go to user profile
                                            withAnimation(.spring()) {
                                                goToProfile = true
                                            }
                                        }
                                        .mask(Circle())
                                        .background(
                                            Circle()
                                                .fill(Color.clear)
                                                .padding(-2)
                                            
                                        )
                                    .frame(width: 30, height: 30)
                                    .offset(y:-8)
                                }
                                
                                Text(section.text)
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("black"))
                                    .font(.subheadline)
                                    .padding(.horizontal, 11.0)
                                    .padding(.vertical, 9.0)
                                    .background(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0))
                                    .cornerRadius(12)
                                    .background{
                                        HStack {
                                            VStack {
                                                Spacer()
                                                
                                                Rectangle()
                                                    .fill(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0))
                                                .frame(width:20, height: 20)
                                            }
                                            Spacer()
                                        }
                                            
                                    }
                                    .neoDoubleTapButton(isToggle: false, perform: {
                                        //code
                                        withAnimation(.easeIn) {
                                                bTapped = section.timestamp
                                                showDate.toggle()
                                        }
                                    })
                                .padding(.bottom,9)
                            }
                        }
                        
                    }
                    
                    
                    
                    Text(showDate ? section.timestamp : section.stamp)
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 3.0)
                }
                .padding(.horizontal)
                .multilineTextAlignment(.leading)
                .animation(.spring(), value: blurPage)
                
                
                Spacer()
                
                Rectangle()
                    .fill(.clear)
                    .frame(width: 100, height: 20)
            }.animation(.spring(), value: blurPage)        }
    }
    func formatDate(time:String) -> String{
        
        let dateFormatter = DateFormatter()
        
        let timedate = dateFormatter.date(from: time) ?? Date()
        // dateFormatter.dateFormat = "MMM d, yyyy 'at' h:mm:ss a"
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: timedate)
        
    }
}

struct MessageBubblesView_Previews: PreviewProvider {
    
    static var previews: some View {
       
        ViewController()
    }
}

