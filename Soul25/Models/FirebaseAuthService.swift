//
//  FirebaseAuthService.swift
//  Soul25
//
//  Created by Zablon Charles on 7/2/24.
//

import FirebaseAuth
import FirebaseFirestore

class FirebaseAuthService {
    
    static let shared = FirebaseAuthService()
    private var db = Firestore.firestore()
    
    private init() {}
    
    func getCurrentUserEmail() -> String? {
        return Auth.auth().currentUser?.email
    }
    
    func signIn(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(false, error)
                return
            }
            // Sign-in successful
            completion(true, nil)
        }
    }
    
    func signOut(completion: @escaping (Bool, Error?) -> Void) {
        guard let email = getCurrentUserEmail() else {
            completion(false, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user is signed in."]))
            return
        }
        
        // Update the online status to false
        let docRef = db.collection("users").document(email)
        docRef.updateData(["online": false]) { error in
            if let error = error {
                completion(false, error)
                return
            }
            
            // Sign out from FirebaseAuth
            do {
                try Auth.auth().signOut()
                completion(true, nil)
            } catch let signOutError as NSError {
                completion(false, signOutError)
            }
        }
    }
}


class AuthViewModel: ObservableObject {
    @Published var isSignedOut = false
    @Published var signOutError: Error?
    
    func signIn(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        FirebaseAuthService.shared.signIn(email: email, password: password) { success, error in
            if success {
                DispatchQueue.main.async {
                    self.isSignedOut = false
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    self.signOutError = error
                }
            }
            completion(success, error)
        }
    }
    
    func getCurrentUserEmail() -> String? {
        return FirebaseAuthService.shared.getCurrentUserEmail()
    }
    
    func signOut() {
        FirebaseAuthService.shared.signOut { [weak self] success, error in
            if success {
                DispatchQueue.main.async {
                    self?.isSignedOut = true
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    self?.signOutError = error
                }
            }
        }
    }
}
