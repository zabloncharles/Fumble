//
//  fetchLikedUsers.swift
//  Soul25
//
//  Created by Zablon Charles on 7/24/24.
//

import FirebaseAuth
import FirebaseFirestore

class AuthLikedModel: ObservableObject {
    @Published var user: UserStruct?
    @Published var likedUsers: [UserStruct] = []
    @Published var message: String?
    
    private var db = Firestore.firestore()
    
    func fetchLikedUsers() {
        guard let email = Auth.auth().currentUser?.email else {
            self.message = "No authenticated user found"
            return
        }
        
        let userDocRef = db.collection("users").document(email)
        
        userDocRef.getDocument { document, error in
            if let error = error {
                self.message = "Failed to fetch user document: \(error.localizedDescription)"
                return
            }
            
            guard let document = document, document.exists else {
                self.message = "User document does not exist"
                return
            }
            
            do {
                if let data = document.data() {
                   
                    let user = try document.data(as: UserStruct.self)
                    self.user = user
                    self.fetchUsersFromLikedList(emails: user.liked)
                } else {
                    self.message = "Document data is empty"
                }
            } catch {
                self.message = "Error decoding user document: \(error.localizedDescription)"
               
            }
        }
    }
    
    // Method to add an email to the liked list
    func addEmailToLiked(email: String) {
        guard let currentEmail = Auth.auth().currentUser?.email else {
            message = "No authenticated user found"
            return
        }
        
        let userDocRef = db.collection("users").document(currentEmail)
        
        // Fetch the current user document
        userDocRef.getDocument { (document, error) in
            if let error = error {
                self.message = "Failed to fetch user document: \(error.localizedDescription)"
                return
            }
            
            guard let document = document, document.exists else {
                self.message = "User document does not exist"
                return
            }
            
            // Get the current liked list
            var currentUser = try? document.data(as: UserStruct.self)
            if currentUser == nil {
                self.message = "Failed to decode user document"
                return
            }
            
            // Update the liked list
            if !currentUser!.liked.contains(email) {
                currentUser!.liked.append(email)
            }
            
            // Update Firestore document
            self.updateLikedField(userDocRef: userDocRef, likedList: currentUser!.liked)
        }
    }
    
    // Helper function to update the liked field
    private func updateLikedField(userDocRef: DocumentReference, likedList: [String]) {
        userDocRef.updateData(["liked": likedList]) { error in
            if let error = error {
                self.message = "Error updating liked list: \(error.localizedDescription)"
            } else {
//                self.message = "Successfully added email to liked list"
            }
        }
    }
    
    // Method to remove an email from the liked list and add it to the unliked list
    func removeEmailFromLiked(email: String) {
        guard let currentEmail = Auth.auth().currentUser?.email else {
            message = "No authenticated user found"
            return
        }
        
        let userDocRef = db.collection("users").document(currentEmail)
        
        db.runTransaction({ (transaction, errorPointer) -> Any? in
            let userDocument: DocumentSnapshot
            do {
                try userDocument = transaction.getDocument(userDocRef)
            } catch let fetchError as NSError {
                errorPointer?.pointee = fetchError
                return nil
            }
            
            guard var user = try? userDocument.data(as: UserStruct.self) else {
                errorPointer?.pointee = NSError(domain: "FirestoreErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "User document does not exist"])
                return nil
            }
            
            // Remove the email from the liked list
            if let index = user.liked.firstIndex(of: email) {
                user.liked.remove(at: index)
            }
            
            // Add the email to the unliked list
            if !user.unmatched.contains(email) {
                user.unmatched.append(email)
            }
            
            // Update the user document
            if let userDictionary = self.convertToDictionary(user) {
                transaction.setData(userDictionary, forDocument: userDocRef)
            }
            return nil
            
        }) { (object, error) in
            if let error = error {
                self.message = "Transaction failed: \(error.localizedDescription)"
            } else {
                self.message = "Successfully updated liked and unliked lists"
            }
        }
    }
    
    func convertToDictionary<T: Encodable>(_ object: T) -> [String: Any]? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        do {
            let data = try encoder.encode(object)
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print("Error converting to dictionary: \(error)")
            return nil
        }
    }
    
    private func fetchUsersFromLikedList(emails: [String]) {
        let userCollectionRef = db.collection("users")
        let group = DispatchGroup()
        var fetchedUsers: [UserStruct] = []
        
        for email in emails {
            group.enter()
            userCollectionRef.document(email).getDocument { document, error in
                if let error = error {
                    self.message = "Failed to fetch user document for \(email): \(error.localizedDescription)"
                    group.leave()
                    return
                }
                
                guard let document = document, document.exists else {
                    self.message = "User document for \(email) does not exist"
                    group.leave()
                    return
                }
                
                do {
                    let user = try document.data(as: UserStruct.self)
                    fetchedUsers.append(user)
                } catch {
                    self.message = "Error decoding user document for \(email): \(error.localizedDescription)"
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.likedUsers = fetchedUsers
            self.message = "Successfully fetched liked users"
        }
    }
}
