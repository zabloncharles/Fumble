//
//  ChatTestView.swift
//  Soul25
//
//  Created by Zablon Charles on 8/23/24.
//

import SwiftUI
import FirebaseFirestore

struct Message: Identifiable, Codable {
    @DocumentID var id: String?
    var text: String
    var senderId: String
    var timestamp: Date
}


struct ChatView: View {
    @ObservedObject var viewModel = ChatViewModel()
    @State private var messageText: String = ""
    let userId: String
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.messages) { message in
                    MessageRow(message: message, isCurrentUser: message.senderId == userId)
                }
            }
            .padding(.top)
            
            HStack {
                TextField("Enter message", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: 30)
                
                Button(action: {
                    viewModel.sendMessage(text: messageText, senderId: userId)
                    messageText = ""
                }) {
                    Text("Send")
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}
struct MessageRow: View {
    let message: Message
    let isCurrentUser: Bool
    
    var body: some View {
        HStack {
            if isCurrentUser {
                Spacer()
            }
            Text(message.text)
                .padding(10)
                .background(isCurrentUser ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
            if !isCurrentUser {
                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

struct ChatTestView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView( userId: "zack@gmail.com")
    }
}


class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    init() {
        fetchMessages()
    }
    
    func fetchMessages() {
        listener = db.collection("users")
            .document("zack@gmail.com")
            .collection("chats")
            .document("oliviabrown@example.com")
            .collection("messages")
//            .order(by: "timestamp", descending: false)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting messages: \(error)")
                    return
                }
                self.messages = querySnapshot?.documents.compactMap {
                    try? $0.data(as: Message.self)
                } ?? []
            }
    }
    
    func sendMessage(text: String, senderId: String) {
        let newMessage = Message(text: text, senderId: senderId, timestamp: Date())
        do {
            _ = try db.collection("users")
                .document("zack@gmail.com")
                .collection("chats")
                .document("oliviabrown@example.com")
                .collection("messages").addDocument(from: newMessage)
        } catch {
            print("Error sending message: \(error)")
        }
    }
    
    deinit {
        listener?.remove()
    }
}
