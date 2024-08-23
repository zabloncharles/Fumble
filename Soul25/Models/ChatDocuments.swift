//
//  ChatDocuments.swift
//  Soul25
//
//  Created by Zablon Charles on 8/23/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct UserProfile: Identifiable {
    var id: String
    var avatar: String
    var name: String
    var lastMessage: String
    var timestamp: String
    var userId: String
    var myEmail: String
}

class CollectionViewModel: ObservableObject {
    @Published var userProfiles: [UserProfile] = []
    private var db = Firestore.firestore()
    
    init() {
        fetchChatsDocumentIds()
    }
    
    func fetchChatsDocumentIds() {
        guard let userEmail = Auth.auth().currentUser?.email else {
            print("No user is currently signed in.")
            self.userProfiles = []
            return
        }
        
        let userDocRef = db.collection("users").document(userEmail).collection("chats")
        
        userDocRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error.localizedDescription)")
                return
            }
            
            if let documents = querySnapshot?.documents {
                let documentIds = documents.map { $0.documentID }
                self.fetchUserProfiles(forEmails: documentIds, myEmail: userEmail)
            } else {
                print("No documents found in chats subcollection")
                DispatchQueue.main.async {
                    self.userProfiles = []
                }
            }
        }
    }
    
    func fetchUserProfiles(forEmails emails: [String], myEmail: String) {
        let group = DispatchGroup()
        var profiles: [UserProfile] = []
        
        for email in emails {
            group.enter()
            db.collection("users").document(email).getDocument { (document, error) in
                if let error = error {
                    print("Error fetching user profile for \(email): \(error.localizedDescription)")
                }
                
                if let document = document, document.exists {
                    let data = document.data() ?? [:]
                    let avatar = data["avatar"] as? String ?? ""
                    let name = data["firstName"] as? String ?? ""
                    
                    // Fetch the last message for this user
                    self.fetchLastMessage(forChat: email) { lastMessage, timestamp, userId in
                        let profile = UserProfile(
                            id: email,
                            avatar: avatar,
                            name: name,
                            lastMessage: lastMessage,
                            timestamp: timestamp,
                            userId: userId,
                            myEmail: myEmail
                        )
                        profiles.append(profile)
                        group.leave()
                    }
                } else {
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            self.userProfiles = profiles
        }
    }
    
    func fetchLastMessage(forChat chatId: String, completion: @escaping (String, String, String) -> Void) {
        db.collection("users").document(Auth.auth().currentUser?.email ?? "")
            .collection("chats").document(chatId)
            .collection("messages").order(by: "timestamp", descending: true).limit(to: 1)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching last message for chat \(chatId): \(error.localizedDescription)")
                    completion("No message", "No timestamp", "No userId")
                    return
                }
                
                if let document = querySnapshot?.documents.first {
                    let data = document.data()
                    let lastMessage = data["message"] as? String ?? "No message"
                    let timestamp = data["timestamp"] as? String ?? "No timestamp"
                    let userId = data["userId"] as? String ?? "No userId"
                    completion(lastMessage, timestamp, userId)
                } else {
                    completion("No message", "No timestamp", "No userId")
                }
            }
    }
}

