//
//  SaveUserService.swift
//  Soul25
//
//  Created by Zablon Charles on 7/3/24.
//

import FirebaseFirestore

class UserService {
    private var db = Firestore.firestore()
    
    func createUser(user: UserStruct, completion: @escaping (Error?) -> Void) {
        let userRef = db.collection("users").document()
        
        let userData: [String: Any] = [
            "firstName": user.firstName,
            "lastName": user.lastName,
            "email": user.email,
            "age": user.age,
            "gender": user.gender,
            "avatar": user.avatar,
            "photos": user.photos,
            "occupation": user.occupation,
            "education": user.education,
            "location": user.location,
            "coordinates": user.coordinates,
            "bio": user.bio,
            "interests": user.interests,
            "lastActive": user.lastActive,
            "lookingFor": user.lookingFor,
            "hometown": user.hometown,
            "relationshipStatus": user.relationshipStatus,
            "height": user.height,
            "ethnicity": user.ethnicity,
            "religion": user.religion,
            "politicalAffiliation": user.politicalAffiliation,
            "smokingHabit": user.smokingHabit,
            "drinkingHabit": user.drinkingHabit,
            "exerciseFrequency": user.exerciseFrequency,
            "children": user.children,
            "pets": user.pets,
            "dateJoined": user.dateJoined,
            "matched": user.matched,
            "unmatched": user.unmatched,
            "liked": user.liked,
            "prompts": user.prompts
        ]
        
        userRef.setData(userData) { error in
            if let error = error {
                print("Error creating user: \(error.localizedDescription)")
                completion(error)
            } else {
                print("User created successfully")
                completion(nil)
            }
        }
    }
}

// Usage
let user = UserStruct(
    firstName: "Amelia",
    lastName: "Martinez",
    email: "ameliamartinez@example.com",
    age: 22,
    gender: "female",
    avatar: "https://images.unsplash.com/photo-1523673671576-35ff54e94bae?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    photos: ["https://images.pexels.com/photos/9675102/pexels-photo-9675102.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", "https://images.pexels.com/photos/19113337/pexels-photo-19113337/free-photo-of-portrait-of-a-young-elegant-woman-in-a-glamour-makeup-look.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"],
    occupation: "Nurse",
    education: "Associate Degree",
    location: ["United States", "Michigan", "Detroit", "48201"],
    coordinates: ["42.331429", "-83.045753"],
    bio: "I'm a nurse who loves caring for others and making a difference.",
    interests: ["Nursing", "Traveling", "Cooking"],
    lastActive: Date(),
    lookingFor: "male",
    hometown: "Detroit",
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


