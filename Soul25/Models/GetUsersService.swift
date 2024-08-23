//
//  GetUsersService.swift
//  Soul25
//
//  Created by Zablon Charles on 7/19/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth


class UserViewModel: ObservableObject {
    @Published var users: [UserStruct] = []
    @Published var searchUser: UserStruct?
    @Published var currentUser: UserStruct?
    private var db = Firestore.firestore()
    
    func fetchUsers() {
        db.collection("users").getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                if let snapshot = snapshot {
                    self.users = snapshot.documents.compactMap { document in
                        try? document.data(as: UserStruct.self)
                    }
                }
            }
        }
    }
    func fetchCurrentUser() {
        guard let currentUser = Auth.auth().currentUser else {
            print("No user is signed in.")
            return
        }
        
        let email = currentUser.email!
        let docRef = db.collection("users").document(email)
        
        docRef.getDocument { document, error in
            if let error = error {
                print("Error getting document: \(error)")
                return
            }
            if let document = document, document.exists {
                self.currentUser = try? document.data(as: UserStruct.self)
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func fetchUser(byEmail email: String) {
        let docRef = db.collection("users").document(email)
        docRef.getDocument { document, error in
            if let error = error {
                print("Error getting document: \(error)")
                return
            }
            if let document = document, document.exists {
                self.searchUser = try? document.data(as: UserStruct.self)
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func updateOnlineStatus(email: String, isOnline: Bool, completion: @escaping (Error?) -> Void) {
        let docRef = db.collection("users").document(email)
        
        docRef.updateData(["online": isOnline]) { error in
            completion(error)
        }
    }
}

