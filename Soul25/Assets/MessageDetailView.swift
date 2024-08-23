////
//  MessageDetailView.swift
//  ionicFusion
//
//  Created by Zablon Charles on 8/19/23.
//



import SwiftUI

struct MessageDetailView: View {
    @StateObject var authViewModel = AuthViewModel()
    @AppStorage("hidemainTab") var hidemainTab = false
    var username = "doe"
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State var text = "yo"
    //@Binding var section: NotificationModel
    @State var hideNav = false
    @State var scrolling = CGFloat(0)
    @State var scrolledItem: Int = 0
    @State var chatMessages: [Book] = []
    var log: Book  //has user id
    @State var userAvatarLoaded = false
    // var log : MessageUser
    // var holdData : [IncomingMessage]
    @State private var messageText = ""
    @State private var sender = "John"
    @State var guardSending = false
    @State var userscrolled = false
    @FocusState private var keyboardFocus: Bool
    @State private var typing = false
    @State private var typedText = ""
    @State var scrollingUp = false
    @State var backButtonTapped = false
    @State var btapped = ""
    @State var blurPage = false
    @State var messageSent = false
    @State var bubblesAppeared = false
    @State var messageDeleted = false
    @State private var scrollToBottom: Bool = false
    @State var tappedUserAvatar  = ""
    @State var goToProfile = false
    @State var currentUser : UserStruct? = fakeUser
    @ObservedObject var viewModel = BooksViewModel()
    @ObservedObject var logoModel = LogViewModel()
    @Binding var profiles: [UserStruct]
    @State var teste = false
    var body: some View {
        NavigationView {
            ZStack {
                //                VStack {
                //                    if chatMessages.isEmpty {
                //                        Text("No chat logs available")
                //                    } else {
                //                        List(chatMessages) { book in
                //                            VStack(alignment: .leading) {
                //                                Text("User: \(book.userId)")
                //                                Text("Message: \(book.message)")
                //                                Text("Timestamp: \(book.timestamp)")
                //                            }
                //                        }
                //                    }
                //                }
                
                BackgroundView()
                content
                cover
                texting
                
            }
            
        }  .navigationBarTitle(log.userId, displayMode: .inline)
            .navigationBarBackButtonHidden(false) // Hide the default back button
        
            .sheet(isPresented: $goToProfile){
                SkullProfile(currentUser: $currentUser, profile: fakeUser, showProfile: .constant(false), currentIndex: .constant(-1),likedEmails: .constant([""]), dislikedEmails: .constant([""]))
                    .edgesIgnoringSafeArea(.top)
                    .padding(.bottom, -120)
                
            }
            .onAppear{
                
                logoModel.fetchData(for: log.userId) { books in
                    self.chatMessages = books
                }
                
                
                withAnimation(.spring()) {
                    hidemainTab = true
                    //                chatMessages = viewModel.fetchData(for: "emilyjohnson@example.com")
                }
            }
        
    }
    
    var cover: some View {
        VStack {
            HStack {
                Spacer()
                
                
                
                Image(systemName: "exclamationmark.circle")
                    .foregroundColor(.gray )
                    .font(.headline)
                    .padding(.trailing,10)
            }
            .frame( height: 40)
            .padding(.horizontal,10)
            .padding(.top,50)
            .padding(.bottom,10)
            .background(Color("offwhiteneo"))
            Divider()
                .padding(.top,-8)
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var content: some View {
        VStack {
            ScrollViewReader { scrollViewProxy in
                
                
                ScrollView(showsIndicators: false) {
                    
                    ForEach(chatMessages.sorted(by: { dateStringToDate($1.timestamp) ?? Date() > dateStringToDate($0.timestamp) ?? Date() })) {section in
                        VStack {
                            
                            MessageBubblesView(section: section, blurPage: $blurPage, messageDeleted: $messageDeleted, avatar: "", bTapped: $btapped, goToProfile: $goToProfile,log:log)
                            
                            //                                            .opacity(bubblesAppeared ? 1 : 0.30)
                                .onLongPressGesture {
                                    blurPage.toggle()
                                    
                                }
                            
                                .opacity( btapped == (section.timestamp ) ? 1 : blurPage ? 0 : 1)
                                .blur(radius: btapped == (section.timestamp ) ? 0 :  blurPage ? 13 : 0)
                                .id(section.id)
                            //                                                .onAppear{
                            //                                                    withAnimation(.spring()) {
                            //                                                        scrollViewProxy.scrollTo(((chatMessages[chatMessages.count - 4]).id), anchor: .bottom)
                            //                                                    }
                            //
                            //
                            //                                                    Timer.scheduledTimer(withTimeInterval: 0.9, repeats: false) { timer in
                            //                                                        withAnimation(.spring()) {
                            //                                                            scrollViewProxy.scrollTo((chatMessages.last?.id), anchor: .bottom)
                            //                                                        }
                            //                                                    }
                            //                                                    scrollViewProxy.scrollTo(((chatMessages[chatMessages.count - 4]).id), anchor: .bottom)
                            //                                                }
                            //
                        }
                        
                        
                    }
                    
                    
                    
                    
                    
                    .onChange(of: blurPage || messageSent || keyboardFocus) { newValue in
                        if !blurPage {
                            btapped = ""
                        }
                        // scroll chats to bottom if i send message
                        if messageSent {
                            Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { timer in
                                withAnimation(.spring()) {
                                    scrollViewProxy.scrollTo((chatMessages.last?.id), anchor: .bottom)
                                }
                            }
                            
                            
                        }
                        //when i start typing scroll the messages to last message
                        if keyboardFocus {
                            Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { timer in
                                withAnimation(.spring()) {
                                    scrollViewProxy.scrollTo((chatMessages.last?.id), anchor: .bottom)
                                }
                            }
                        }
                    }
                    .onChange(of: messageDeleted) { newValue in
                        if messageDeleted {
                            blurPage = false
                            
                            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
                                
                            }
                            
                            typeWriteText("Message deleted!") {
                                //Message was deleted
                                messageDeleted = false
                                logoModel.fetchData(for: log.userId) { books in
                                    self.chatMessages = books
                                }
                                
                            }
                        }
                    }
                    
                    
                    
                    
                    
                    
                    .padding(.top, 30)
                    
                    
                    
                }.coordinateSpace(name: "scrollView")
                    .background( Color("offwhiteneo"))
                    .onTapGesture{
                        blurPage = false
                    }
                
                    .onTapGesture{
                        keyboardFocus = false
                    }
                
                
                
            }
            .padding(.bottom,80)
            
            
            Spacer()
        }
        
        
    }
    var texting: some View {
        
        
        VStack{
            Spacer()
            // Usage example
            
            
            HStack {
                TextField("Message...", text: $messageText)
                
                    .padding(.vertical,10)
                    .padding(.leading, 15)
                    .foregroundColor(guardSending ? .gray : Color("black"))
                
                    .focused($keyboardFocus)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("black").opacity(0.70), lineWidth: 1)
                        
                    )
                    .cornerRadius(20)
                
                
                    .onChange(of: typing) { newValue in
                        if keyboardFocus {
                            typing = true
                        } else {
                            typing = false
                        }
                    }
                
                Image(systemName: "paperplane.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(messageText.count < 1 ? .gray : guardSending ? .red : .blue)
                
                    .onTapGesture{
                        
                        if (authViewModel.getCurrentUserEmail() != nil) {
                            viewModel.sendMessage(to: log.userId, message: messageText, senderEmail: authViewModel.getCurrentUserEmail() ?? "error")
                            logoModel.fetchData(for: log.userId) { books in
                                self.chatMessages = books
                            }
                            messageText = ""
                        } else {
                            messageText = "there was an error!"
                        }
                        
                        //                        if messageText.count > 0 && !guardSending{
                        //                          //  sendMessage(message: messageText)
                        //                            //send the fake text to array
                        //                            sendFakeText()
                        //                            messageText = ""
                        //
                        //                        } else {
                        //                            if !guardSending {
                        //                                typeWriteText("You haven't typed anything :/") {
                        //                                    print("Typing finished")
                        //                                }
                        //                            }
                        //                        }
                        
                    }
                
            } .background( Color("offwhiteneo"))
            
                .padding()
            
            
            
        }    .modifier(KeyboardAwareModifier())
        
        
    }
    
    
    func sendFakeText(){
        
        
        // Generate and add a fake message to the chat
        //        let fakeMessage = MessageModel(userID: "user1", text: messageText, sender: "user1", timestamp: "\(Date())", stamp: "Sent")
        //
        //        withAnimation {
        //            messageSent = true
        //            chatMessages.append(fakeMessage)
        //        }
    }
    func dateStringToDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy, h:mm a"  // Adjust format to match your timestamp format
        return dateFormatter.date(from: dateString)
    }
    // Function to filter profiles by email
    func filteredProfilesByEmail() -> [UserStruct] {
        return profiles.filter { $0.email == log.userId }
    }
    func typeWriteText(_ text: String, completion: @escaping () -> Void) {
        let original = messageText
        messageText = ""
        var currentIndex = 0
        guardSending = true
        Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true) { timer in
            if currentIndex < text.count {
                let index = text.index(text.startIndex, offsetBy: currentIndex)
                let character = text[index]
                
                DispatchQueue.main.async {
                    withAnimation(.easeIn) {
                        messageText += String(character)
                    } // Update the typedText property on the main queue
                }
                
                currentIndex += 1
            } else {
                
                timer.invalidate()
                completion()
                Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { timer in
                    withAnimation(.easeInOut) {
                        messageText = original
                        
                        guardSending = false
                    }
                }
                
            }
        }
    }
    
    
    
    
}


struct MessageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // MessagesView(section: .constant(messageSections[0]))
        ViewController()
    }
}




struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}
