//  Created by Zablon Charles on 5/28/23.
import SwiftUI


var appbackground = BackgroundView()


//----------------------------------------
//new model
// Create a new user
var fakeUser = UserStruct(
    firstName: "fake",
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

var fakeUsers: [UserStruct] = [
    UserStruct(
        firstName: "Emily",
        lastName: "Johnson",
        email: "emilyjohnson@example.com",
        age: 20,
        gender: "female",
        avatar: "https://plus.unsplash.com/premium_photo-1664464229692-44046bfd6b7d?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        photos: ["https://plus.unsplash.com/premium_photo-1664464227921-cda481c1b8fa?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1pbi1zYW1lLXNlcmllc3wxfHx8ZW58MHx8fHx8", "https://plus.unsplash.com/premium_photo-1664464228149-f93436b48c1b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1pbi1zYW1lLXNlcmllc3wyfHx8ZW58MHx8fHx8"],
        occupation: "Student",
        education: "College",
        location: ["United States", "New York", "Brooklyn", "11201"],
        coordinates: ["40.712776", "-74.005974"],
        bio: "I'm a student passionate about art and photography.",
        interests: ["Art", "Photography", "Traveling"],
        lastActive: Date(),
        lookingFor: "male",
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
    ),
    // Second fake user
    UserStruct(
        firstName: "Sophia",
        lastName: "Smith",
        email: "sophiasmith@example.com",
        age: 22,
        gender: "female",
        avatar: "https://images.unsplash.com/photo-1646337427114-678dfd1851d8?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        photos: ["https://images.unsplash.com/photo-1646337430117-7662ce0f60eb?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDF8fHxlbnwwfHx8fHw%3D", "https://images.unsplash.com/photo-1646337429056-00906c1aab7b?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDJ8fHxlbnwwfHx8fHw%3D"],
        occupation: "Graphic Designer",
        education: "Bachelor's Degree",
        location: ["United States", "California", "Los Angeles", "90001"],
        coordinates: ["34.052235", "-118.243683"],
        bio: "I'm a graphic designer who loves exploring new design trends.",
        interests: ["Design", "Traveling", "Fashion"],
        lastActive: Date(),
        lookingFor: "male",
        hometown: "Los Angeles",
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
    ),
    // Third fake user
    UserStruct(
        firstName: "Olivia",
        lastName: "Brown",
        email: "oliviabrown@example.com",
        age: 24,
        gender: "female",
        avatar: "https://images.unsplash.com/photo-1519852208746-9ee7ab07e77c?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        photos: ["https://images.unsplash.com/photo-1519330377309-9ee1c6783348?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDF8fHxlbnwwfHx8fHw%3D", "https://images.unsplash.com/photo-1525200237491-55f7e4814781?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDN8fHxlbnwwfHx8fHw%3D"],
        occupation: "Software Engineer",
        education: "Master's Degree",
        location: ["United States", "Texas", "Austin", "78701"],
        coordinates: ["30.267153", "-97.743057"],
        bio: "I'm a software engineer who loves building innovative apps.",
        interests: ["Programming", "Hiking", "Reading"],
        lastActive: Date(),
        lookingFor: "male",
        hometown: "Austin",
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
    ),
    // Fourth fake user
    UserStruct(
        firstName: "Lily",
        lastName: "Williams",
        email: "lilywilliams@example.com",
        age: 19,
        gender: "female",
        avatar: "https://images.unsplash.com/photo-1531944342704-649d95a5838d?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDJ8fHxlbnwwfHx8fHw%3D",
        photos: ["https://images.unsplash.com/photo-1533077650324-5cca2426cd20?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDR8fHxlbnwwfHx8fHw%3D", "https://images.unsplash.com/photo-1531947110440-22515de7eacc?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDN8fHxlbnwwfHx8fHw%3D"],
        occupation: "Student",
        education: "College",
        location: ["United States", "Florida", "Miami", "33101"],
        coordinates: ["25.761680", "-80.191790"],
        bio: "I'm a student who loves exploring nature and trying new foods.",
        interests: ["Nature", "Food", "Traveling"],
        lastActive: Date(),
        lookingFor: "male",
        hometown: "Miami",
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
    ),
    // Fifth fake user
    UserStruct(
        firstName: "Ava",
        lastName: "Jones",
        email: "avajones@example.com",
        age: 23,
        gender: "female",
        avatar: "https://images.unsplash.com/photo-1508970707-f6426fb47503?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        photos: ["https://images.unsplash.com/photo-1508970566-7e0cca18e5d7?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDF8fHxlbnwwfHx8fHw%3D", "https://images.unsplash.com/photo-1508970436-b2150a27d7dd?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDJ8fHxlbnwwfHx8fHw%3D"],
        occupation: "Journalist",
        education: "Bachelor's Degree",
        location: ["United States", "Washington", "Seattle", "98101"],
        coordinates: ["47.606209", "-122.332069"],
        bio: "I'm a journalist who loves writing and exploring the city.",
        interests: ["Writing", "Exploring", "Reading"],
        lastActive: Date(),
        lookingFor: "male",
        hometown: "Seattle",
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
    ),
    // Sixth fake user
    UserStruct(
        firstName: "Mia",
        lastName: "Thompson",
        email: "miathompson@example.com",
        age: 21,
        gender: "female",
        avatar: "https://images.unsplash.com/photo-1495490140452-5a226aef25d4?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        photos: ["https://images.unsplash.com/photo-1522390108011-5f8667fd551d?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDR8fHxlbnwwfHx8fHw%3D", "https://plus.unsplash.com/premium_photo-1661315484619-15203e063255?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE2fHx8ZW58MHx8fHx8"],
        occupation: "Student",
        education: "College",
        location: ["United States", "California", "San Francisco", "94101"],
        coordinates: ["37.774929", "-122.419416"],
        bio: "I'm a student who loves technology and exploring the city.",
        interests: ["Technology", "Exploring", "Music"],
        lastActive: Date(),
        lookingFor: "male",
        hometown: "San Francisco",
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
    ),
    // Seventh fake user
    UserStruct(
        firstName: "Chloe",
        lastName: "Miller",
        email: "chloemiller@example.com",
        age: 24,
        gender: "female",
        avatar: "https://images.unsplash.com/photo-1592101667236-ab434fc33dad?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDF8fHxlbnwwfHx8fHw%3D",
        photos: ["https://images.unsplash.com/photo-1585890483046-9461ebc1dace?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDR8fHxlbnwwfHx8fHw%3D", "https://images.unsplash.com/photo-1507691754536-1d2b755da326?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDZ8fHxlbnwwfHx8fHw%3D"],
        occupation: "Marketing Specialist",
        education: "Bachelor's Degree",
        location: ["United States", "Texas", "Houston", "77001"],
        coordinates: ["29.760427", "-95.369804"],
        bio: "I'm a marketing specialist who loves traveling and meeting new people.",
        interests: ["Marketing", "Traveling", "Socializing"],
        lastActive: Date(),
        lookingFor: "male",
        hometown: "Houston",
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
    ),
    // Eighth fake user
    UserStruct(
        firstName: "Isabella",
        lastName: "Anderson",
        email: "isabellaanderson@example.com",
        age: 18,
        gender: "female",
        avatar: "https://images.unsplash.com/photo-1591752270708-d2de0f30f7ec?q=80&w=1293&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        photos: ["https://images.unsplash.com/photo-1591751675630-498149a1aa89?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDJ8fHxlbnwwfHx8fHw%3D", "https://images.unsplash.com/photo-1591753115350-8902397bf3cb?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDF8fHxlbnwwfHx8fHw%3D"],
        occupation: "Student",
        education: "High School",
        location: ["United States", "Florida", "Orlando", "32801"],
        coordinates: ["28.538336", "-81.379234"],
        bio: "I'm a high school student who loves sports and outdoor activities.",
        interests: ["Sports", "Outdoor Activities", "Music"],
        lastActive: Date(),
        lookingFor: "male",
        hometown: "Orlando",
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
    ),
    // Ninth fake user
    UserStruct(
        firstName: "Charlotte",
        lastName: "Garcia",
        email: "charlottegarcia@example.com",
        age: 25,
        gender: "female",
        avatar: "https://images.unsplash.com/photo-1594434911783-e509961ee25c?q=80&w=1286&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        photos: ["https://images.unsplash.com/photo-1594435763464-05f0624e04c9?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDF8fHxlbnwwfHx8fHw%3D", "https://images.unsplash.com/photo-1593129747951-db31f82963da?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDJ8fHxlbnwwfHx8fHw%3D"],
        occupation: "Teacher",
        education: "Master's Degree",
        location: ["United States", "Illinois", "Chicago", "60601"],
        coordinates: ["41.878113", "-87.629799"],
        bio: "I'm a teacher who loves educating and inspiring young minds.",
        interests: ["Teaching", "Traveling", "Reading"],
        lastActive: Date(),
        lookingFor: "male",
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
    ),
    // Tenth fake user
    UserStruct(
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
]





struct UserStruct: Codable {
//    var id = UUID()
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





