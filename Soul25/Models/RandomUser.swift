//
//  RandomUser.swift
//  Soul25
//
//  Created by Zablon Charles on 4/19/24.
//

import SwiftUI

// Step 1: Create Swift model structures
// Define structs to match the JSON structure
struct UserResponse: Codable {
    let results: [UserResult]
}

struct UserResult: Codable {
    let gender: String
    let name: UserName
    let location: Location
    let email: String
    let dob: DOB
    let registered: Registered
    let phone: String
    let cell: String
    let picture: Picture
    let nat: String
    
    // Add other properties as needed
}

struct UserName: Codable {
    let title: String
    let first: String
    let last: String
}

struct Location: Codable {
    let street: Street
    let city: String
    let state: String
    let country: String
    let coordinates: Coordinates
    let timezone: Timezone
}

struct Street: Codable {
    let number: Int
    let name: String
}

struct Coordinates: Codable {
    let latitude: String
    let longitude: String
}

struct Timezone: Codable {
    let offset: String
    let description: String
}



struct DOB: Codable {
    let date: String
    let age: Int
}

struct Registered: Codable {
    let date: String
    let age: Int
}



struct Picture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}
// Step 2: Fetch JSON data and decode it
// Fetch and parse JSON data from the API
func fetchUserData(parameter: String, userCount: String = "10", completion: @escaping ([UserStruct]?) -> Void) {
    guard let url = URL(string: parameter.isEmpty ? "https://randomuser.me/api/?gender=female&results=\(userCount)" : parameter) else {
        completion(nil)
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data else {
            completion(nil)
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let userResponse = try decoder.decode(UserResponse.self, from: data)
            let users = userResponse.results.map { result in
               
                UserStruct(
                    firstName: result.name.first,
                    lastName: result.name.last,
                    email:"fakeemail@gmail.com",
                    age: calculateAge(from: result.dob.date) ?? 30,
                    gender: "female",
                    avatar:result.picture.large,
                    photos: ["https://source.unsplash.com/random/?woman+friends+pretty", "https://source.unsplash.com/random/?girl+pretty"],
                    occupation: "Software Engineer",
                    education: "Bachelor's Degree",
                    location: [result.location.country,result.location.state,result.location.city],
                    coordinates: [result.location.coordinates.latitude,result.location.coordinates.longitude],
                    bio: "I enjoy hiking, playing guitar, and trying new foods.",
                    interests: ["Cooking"],
                    lastActive: Date(),
                    lookingFor: "male",
                    hometown: result.location.city,
                    relationshipStatus: .single,
                    height: .average,
                    ethnicity: .white,
                    religion: "Atheist",
                    politicalAffiliation: "Independent",
                    smokingHabit: .nonSmoker,
                    drinkingHabit: .socialDrinker,
                    exerciseFrequency: .regularly,
                    children: .noChildren,
                    pets: .hasPets,
                    dateJoined: Date(),
                    matched:[""],
                    unmatched:[""],
                    liked:[""],
                    prompts:.other
                    
                )
            }
            completion(users)
        } catch {
            print("Error decoding JSON: \(error)")
            completion(nil)
        }
    }.resume()
}


//get the age from the user dob
func calculateAge(from dateString: String) -> Int? {
    // Create a date formatter
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" // Adjust the date format for the provided string
    
    // Parse the string date into a Date object
    guard let birthDate = dateFormatter.date(from: dateString) else {
        return nil // Return nil if the string cannot be parsed
    }
    
    // Calculate the difference between the birth date and the current date in years
    let calendar = Calendar.current
    let ageComponents = calendar.dateComponents([.year], from: birthDate, to: Date())
    
    // Return the age as an integer
    return ageComponents.year
}
