//
//  SaveUserFake.swift
//  Soul25
//
//  Created by Zablon Charles on 7/19/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SaveUserFake: View {
    @State var message = ""
  
    
    
    var body: some View {
        VStack {
            Text("Hello, world!\(message)")
                .padding()
            Text(" Save User ")
                .neoButtonOff(isToggle: false, cornerRadius: 10)
                .onTapGesture {
                    
                   saveUser()
                    
                }
        }
          
    }
    func signUp(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(false, error)
                return
            }
            guard (authResult?.user) != nil else {
                completion(false, nil)
                return
            }
           
           
        }
    }
    func saveUser() {
        let db = Firestore.firestore()
        let user = FakeStruct(
            firstName: "Zachary",
            lastName: "Benson",
            email:"zack@gmail.com",
            age: 30,
            gender: "male",
            avatar:"https://plus.unsplash.com/premium_photo-1670282393309-70fd7f8eb1ef?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            photos: ["", "","","","",""],
            occupation: "Software Engineer",
            education: "Bachelor's Degree",
            location: ["United States", "New Jersey", "Jersey City", "07305"],
            coordinates: ["40.728157","-74.077644"],
            bio: "this is a local profile",
            interests: ["Cooking"],
            lastActive: Date(),
            lookingFor: "female",
            hometown: "Chicago",
            relationshipStatus: "single",
            height: "average",
            ethnicity: "black",
            religion: "Christian",
            politicalAffiliation: "Moderate",
            smokingHabit: "nonSmoker",
            drinkingHabit: "socialDrinker",
            exerciseFrequency: "regularly",
            children: "noChildren",
            pets: "hasPets",
            dateJoined: Date(),
            matched: [""],
            unmatched: [""],
            liked: [""],
            prompts: "other"
        
        )
        
        do {
            
            signUp(email: user.email, password: "123456") { success, error in
                if success {
                    print("User signed up and saved successfully")
                } else if error != nil {
                   return
                }
            }
            
            try db.collection("users").document(user.email).setData(from: user)
            
         
            
            
            message = "\(user.firstName) Successfully saved"
        } catch let error {
            message = "User failed to save"
            print("Error writing user to Firestore: \(error)")
        }
    }
}



struct SaveUserFake_Previews: PreviewProvider {
    static var previews: some View {
        SaveUserFake()
    }
}


struct FakeStruct: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var age: Int
    var gender: String
    var avatar: String
    var photos: [String]
    var occupation: String
    var education: String
    var location: [String]
    var coordinates: [String]
    var bio: String
    var interests: [String]
    var lastActive: Date
    var lookingFor: String
    var hometown: String
    var relationshipStatus: String
    var height: String
    var ethnicity: String
    var religion: String
    var politicalAffiliation: String
    var smokingHabit: String
    var drinkingHabit: String
    var exerciseFrequency: String
    var children: String
    var pets: String
    var dateJoined: Date
    var matched: [String]
    var unmatched: [String]
    var liked: [String]
    var prompts: String
}

