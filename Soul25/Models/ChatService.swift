//
//  ChatService.swift
//  Soul25
//
//  Created by Zablon Charles on 6/29/24.
//

import Foundation
import FirebaseFirestore

class BooksViewModel: ObservableObject {
    @Published var books = [Book]()
    
    private var db = Firestore.firestore()
    private var seenDocumentIDs = Set<String>()  // Track seen document IDs
    
    func fetchData() {
        db.collection("chats").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            // Clear the books array to avoid duplicates
            self.books.removeAll()
            
            for document in documents {
                let chatId = document.documentID
                
                // Access the subcollection within each document in the "chats" collection
                document.reference.collection("chat").order(by: "timestamp").limit(to: 1).getDocuments { (subcollectionSnapshot, error) in
                    guard let subcollectionDocuments = subcollectionSnapshot?.documents, let firstDocument = subcollectionDocuments.first else {
                        print("No documents in chat subcollection for chat ID \(chatId)")
                        return
                    }
                    
                    let data = firstDocument.data()
                    let userId = data["userId"] as? String ?? ""
                    let message = data["message"] as? String ?? ""
                    let timestamp = data["timestamp"] as? String ?? ""
                    
                    let book = Book(id: firstDocument.documentID, userId: userId, message: message, timestamp: timestamp)
                    
                    DispatchQueue.main.async {
                        self.books.append(book)
                    }
                }
            }
        }
    }
    // Function to send a message to the specified user and store your email in the userId field
    func sendMessage(to userId: String, message: String, senderEmail: String) {
        // Get the current timestamp as a string
        let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short)
        
        // Find the chat document for the specified user
        db.collection("chats").whereField("userId", isEqualTo: userId).getDocuments { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents, let chatDocument = documents.first else {
                print("Chat document for user \(userId) not found")
                return
            }
            
            // Create a new message in the chat subcollection
            let chatRef = chatDocument.reference.collection("chat").document()
            let messageData: [String: Any] = [
                "userId": senderEmail,
                "message": message,
                "timestamp": timestamp
            ]
            chatRef.setData(messageData) { error in
                if let error = error {
                    print("Error sending message: \(error.localizedDescription)")
                } else {
                    print("Message sent successfully")
//                    self.fetchData()  // Fetch updated chat data after sending a message
                }
            }
        }
    }
    
    // Function to delete a message from the chat subcollection
  
    func deleteMessage(userId: String, messageId: String, completion: @escaping (Error?) -> Void) {
        // Query the "chats" collection to find the document with the matching user ID
        db.collection("chats").whereField("userId", isEqualTo: userId).getDocuments { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents, let chatDocument = documents.first else {
                print("Chat document for user \(userId) not found")
                return
            }
            
            // Get the chat document ID
            let chatId = chatDocument.documentID
            
            // Reference to the message document within the chat subcollection
            let chatRef = self.db.collection("chats").document(chatId).collection("chat").document(messageId)
            
            chatRef.delete { error in
                if let error = error {
                    print("Error deleting message: \(error.localizedDescription)")
                    completion(error)
                } else {
                    print("Message deleted successfully")
                    completion(nil)
                }
            }
        }
    }

    
//    // Function to send a message to the specified user
//    func sendMessage(to userId: String, message: String) {
//        // Get the current timestamp as a string
//        let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short)
//
//        // Find the chat document for the specified user
//        db.collection("chats").whereField("userId", isEqualTo: userId).getDocuments { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents, let chatDocument = documents.first else {
//                print("Chat document for user \(userId) not found")
//                return
//            }
//
//            // Create a new message in the chat subcollection
//            let chatRef = chatDocument.reference.collection("chat").document()
//            let messageData: [String: Any] = [
//                "userId": userId,
//                "message": message,
//                "timestamp": timestamp
//            ]
//            chatRef.setData(messageData) { error in
//                if let error = error {
//                    print("Error sending message: \(error.localizedDescription)")
//                } else {
//                    print("Message sent successfully")
//                }
//            }
//        }
//    }
    
    var hasBooks: Bool {
        return !books.isEmpty
    }
}

struct Book: Identifiable {
    var id: String
    var userId: String
    var message: String
    var timestamp: String
}


//fake convo
// Example fake conversation data
let fakeConversation: [Book] = [
    Book(id: "1", userId: "user1", message: "Hello!", timestamp: "2024-06-29 10:00:00"),
    Book(id: "2", userId: "user2", message: "Hi there!", timestamp: "2024-06-29 10:05:00"),
    Book(id: "3", userId: "user1", message: "How are you?", timestamp: "2024-06-29 10:10:00"),
    Book(id: "4", userId: "user2", message: "I'm good, thanks!", timestamp: "2024-06-29 10:15:00"),
    Book(id: "5", userId: "user1", message: "What are you up to today?", timestamp: "2024-06-29 10:20:00"),
    Book(id: "6", userId: "user2", message: "Just working on some projects.", timestamp: "2024-06-29 10:25:00"),
    Book(id: "7", userId: "user1", message: "That sounds interesting!", timestamp: "2024-06-29 10:30:00"),
    Book(id: "8", userId: "user2", message: "Yeah, it's challenging but fun!", timestamp: "2024-06-29 10:35:00"),
    Book(id: "9", userId: "user1", message: "Good luck with that!", timestamp: "2024-06-29 10:40:00"),
    Book(id: "10", userId: "user2", message: "Thanks!", timestamp: "2024-06-29 10:45:00")
]
