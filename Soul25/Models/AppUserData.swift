//  Created by Zablon Charles on 5/28/23.
import SwiftUI


var appbackground = BackgroundView()


//----------------------------------------
//new model
// Create a new user
var fakeUser = UserStruct(
    firstName: "Zack",
    lastName: "Benson",
    email:"zack@gmail.com",
    age: 30,
    gender: "male",
    avatar:"https://plus.unsplash.com/premium_photo-1670282393309-70fd7f8eb1ef?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    photos: ["https://images.pexels.com/photos/4311436/pexels-photo-4311436.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", "https://images.pexels.com/photos/4311435/pexels-photo-4311435.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/4311432/pexels-photo-4311432.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/2331507/pexels-photo-2331507.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/10757467/pexels-photo-10757467.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/2425012/pexels-photo-2425012.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"],
    occupation: "Software Engineer",
    education: "Bachelor's Degree",
    location: ["United States", "New Jersey", "Jersey City", "07305"],
    coordinates: ["40.728157","-74.077644"],
    bio: "I enjoy hiking, playing guitar, and trying new foods.",
   interests: ["Cooking"],
    lastActive: Date(),
    lookingFor: "female",
    hometown: "Chicago",
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
    matched:["fakeemail@gmail.com","emmasmith@example.com","johndoe@example.com"],
    unmatched:[""],
    liked:[""],
    prompts:.other
)

var fakeUsers: [UserStruct] = [
    UserStruct(
        firstName: "Emily",
        lastName: "Johnson",
        email: "emilyjohnson@example.com",
        age: 20,
        gender: "female",
        avatar: "https://images.unsplash.com/photo-1618374595738-96f68c8e47bf?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        photos: ["https://source.unsplash.com/random/?woman+model", "https://source.unsplash.com/random/?girl+model"],
        occupation: "Student",
        education: "College",
        location: ["United States", "New York", "Brooklyn", "11201"],
        coordinates: ["40.712776", "-74.005974"],
        bio: "I'm a student passionate about art and photography.",
        interests: ["Art", "Photography", "Traveling"],
        lastActive: Date(),
        lookingFor: "male",
        hometown: "Chicago",
        relationshipStatus: .single,
        height: .short,
        ethnicity: .white,
        religion: "Agnostic",
        politicalAffiliation: "Liberal",
        smokingHabit: .nonSmoker,
        drinkingHabit: .socialDrinker,
        exerciseFrequency: .regularly,
        children: .noChildren,
        pets: .hasPets,
        dateJoined: Date(),
        matched: [""],
        unmatched: [""],
        liked: [""],
        prompts: .other
    ),
    // Second fake user
    UserStruct(
        firstName: "Sophia",
        lastName: "Smith",
        email: "sophiasmith@example.com",
        age: 22,
        gender: "female",
        avatar: "https://images.unsplash.com/photo-1618375279997-351e32d80a02?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        photos: ["https://source.unsplash.com/random/?woman+model", "https://source.unsplash.com/random/?girl+model"],
        occupation: "Graphic Designer",
        education: "Bachelor's Degree",
        location: ["United States", "California", "Los Angeles", "90001"],
        coordinates: ["34.052235", "-118.243683"],
        bio: "I'm a graphic designer who loves exploring new design trends.",
        interests: ["Design", "Traveling", "Fashion"],
        lastActive: Date(),
        lookingFor: "male",
        hometown: "Los Angeles",
        relationshipStatus: .single,
        height: .average,
        ethnicity: .white,
        religion: "Christian",
        politicalAffiliation: "Moderate",
        smokingHabit: .nonSmoker,
        drinkingHabit: .socialDrinker,
        exerciseFrequency: .regularly,
        children: .noChildren,
        pets: .hasPets,
        dateJoined: Date(),
        matched: [""],
        unmatched: [""],
        liked: [""],
        prompts: .other
    ),
    // Third fake user
    UserStruct(
        firstName: "Olivia",
        lastName: "Brown",
        email: "oliviabrown@example.com",
        age: 24,
        gender: "female",
        avatar: "https://images.unsplash.com/photo-1618375601660-3e6842f5b791?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        photos: ["https://source.unsplash.com/random/?woman+model", "https://source.unsplash.com/random/?girl+model"],
        occupation: "Software Engineer",
        education: "Master's Degree",
        location: ["United States", "Texas", "Austin", "78701"],
        coordinates: ["30.267153", "-97.743057"],
        bio: "I'm a software engineer who loves building innovative apps.",
        interests: ["Programming", "Hiking", "Reading"],
        lastActive: Date(),
        lookingFor: "male",
        hometown: "Austin",
        relationshipStatus: .single,
        height: .tall,
        ethnicity: .black,
        religion: "Atheist",
        politicalAffiliation: "Liberal",
        smokingHabit: .nonSmoker,
        drinkingHabit: .socialDrinker,
        exerciseFrequency: .regularly,
        children: .noChildren,
        pets: .hasPets,
        dateJoined: Date(),
        matched: [""],
        unmatched: [""],
        liked: [""],
        prompts: .other
    ),
    // Fourth fake user
    UserStruct(
        firstName: "Lily",
        lastName: "Williams",
        email: "lilywilliams@example.com",
        age: 19,
        gender: "female",
        avatar: "https://images.unsplash.com/photo-1617059400269-0ef496bc0c37?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        photos: ["https://source.unsplash.com/random/?woman+model", "https://source.unsplash.com/random/?girl+model"],
        occupation: "Student",
        education: "College",
        location: ["United States", "Florida", "Miami", "33101"],
        coordinates: ["25.761680", "-80.191790"],
        bio: "I'm a student who loves exploring nature and trying new foods.",
        interests: ["Nature", "Food", "Traveling"],
        lastActive: Date(),
        lookingFor: "male",
        hometown: "Miami",
        relationshipStatus: .single,
        height: .average,
        ethnicity: .black,
        religion: "Christian",
        politicalAffiliation: "Moderate",
        smokingHabit: .nonSmoker,
        drinkingHabit: .socialDrinker,
        exerciseFrequency: .regularly,
        children: .noChildren,
        pets: .hasPets,
        dateJoined: Date(),
        matched: [""],
        unmatched: [""],
        liked: [""],
        prompts: .other
    ),
    // Fifth fake user
    UserStruct(
        firstName: "Ava",
        lastName: "Jones",
        email: "avajones@example.com",
        age: 23,
        gender: "female",
        avatar: "https://images.unsplash.com/photo-1617058717173-5b171b787725?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        photos: ["https://source.unsplash.com/random/?woman+model", "https://source.unsplash.com/random/?girl+model"],
        occupation: "Journalist",
        education: "Bachelor's Degree",
        location: ["United States", "Washington", "Seattle", "98101"],
        coordinates: ["47.606209", "-122.332069"],
        bio: "I'm a journalist who loves writing and exploring the city.",
        interests: ["Writing", "Exploring", "Reading"],
        lastActive: Date(),
        lookingFor: "male",
        hometown: "Seattle",
        relationshipStatus: .single,
        height: .tall,
        ethnicity: .white,
        religion: "Agnostic",
        politicalAffiliation: "Liberal",
        smokingHabit: .nonSmoker,
        drinkingHabit: .socialDrinker,
        exerciseFrequency: .regularly,
        children: .noChildren,
        pets: .hasPets,
        dateJoined: Date(),
        matched: [""],
        unmatched: [""],
        liked: [""],
        prompts: .other
    ),
    // Sixth fake user
    UserStruct(
        firstName: "Mia",
        lastName: "Thompson",
        email: "miathompson@example.com",
        age: 21,
        gender: "female",
        avatar: "https://images.unsplash.com/photo-1617059322001-a61ce9551e08?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        photos: ["https://source.unsplash.com/random/?woman+model", "https://source.unsplash.com/random/?girl+model"],
        occupation: "Student",
        education: "College",
        location: ["United States", "California", "San Francisco", "94101"],
        coordinates: ["37.774929", "-122.419416"],
        bio: "I'm a student who loves technology and exploring the city.",
        interests: ["Technology", "Exploring", "Music"],
        lastActive: Date(),
        lookingFor: "male",
        hometown: "San Francisco",
        relationshipStatus: .single,
        height: .average,
        ethnicity: .white,
        religion: "Atheist",
        politicalAffiliation: "Liberal",
        smokingHabit: .nonSmoker,
        drinkingHabit: .socialDrinker,
        exerciseFrequency: .regularly,
        children: .noChildren,
        pets: .hasPets,
        dateJoined: Date(),
        matched: [""],
        unmatched: [""],
        liked: [""],
        prompts: .other
    ),
    // Seventh fake user
    UserStruct(
        firstName: "Chloe",
        lastName: "Miller",
        email: "chloemiller@example.com",
        age: 24,
        gender: "female",
        avatar: "https://images.unsplash.com/photo-1527628217451-b2414a1ee733?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        photos: ["https://source.unsplash.com/random/?woman+model", "https://source.unsplash.com/random/?girl+model"],
        occupation: "Marketing Specialist",
        education: "Bachelor's Degree",
        location: ["United States", "Texas", "Houston", "77001"],
        coordinates: ["29.760427", "-95.369804"],
        bio: "I'm a marketing specialist who loves traveling and meeting new people.",
        interests: ["Marketing", "Traveling", "Socializing"],
        lastActive: Date(),
        lookingFor: "male",
        hometown: "Houston",
        relationshipStatus: .single,
        height: .average,
        ethnicity: .black,
        religion: "Christian",
        politicalAffiliation: "Moderate",
        smokingHabit: .nonSmoker,
        drinkingHabit: .socialDrinker,
        exerciseFrequency: .regularly,
        children: .noChildren,
        pets: .hasPets,
        dateJoined: Date(),
        matched: [""],
        unmatched: [""],
        liked: [""],
        prompts: .other
    ),
    // Eighth fake user
    UserStruct(
        firstName: "Isabella",
        lastName: "Anderson",
        email: "isabellaanderson@example.com",
        age: 18,
        gender: "female",
        avatar: "https://images.unsplash.com/photo-1522938974444-f12497b69347?q=80&w=2818&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        photos: ["https://source.unsplash.com/random/?woman+model", "https://source.unsplash.com/random/?girl+model"],
        occupation: "Student",
        education: "High School",
        location: ["United States", "Florida", "Orlando", "32801"],
        coordinates: ["28.538336", "-81.379234"],
        bio: "I'm a high school student who loves sports and outdoor activities.",
        interests: ["Sports", "Outdoor Activities", "Music"],
        lastActive: Date(),
        lookingFor: "male",
        hometown: "Orlando",
        relationshipStatus: .single,
        height: .short,
        ethnicity: .white,
        religion: "Christian",
        politicalAffiliation: "Conservative",
        smokingHabit: .nonSmoker,
        drinkingHabit: .socialDrinker,
        exerciseFrequency: .regularly,
        children: .noChildren,
        pets: .hasPets,
        dateJoined: Date(),
        matched: [""],
        unmatched: [""],
        liked: [""],
        prompts: .other
    ),
    // Ninth fake user
    UserStruct(
        firstName: "Charlotte",
        lastName: "Garcia",
        email: "charlottegarcia@example.com",
        age: 25,
        gender: "female",
        avatar: "https://images.unsplash.com/photo-1539800925050-60b19309954e?q=80&w=2815&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        photos: ["https://source.unsplash.com/random/?woman+model", "https://source.unsplash.com/random/?girl+model"],
        occupation: "Teacher",
        education: "Master's Degree",
        location: ["United States", "Illinois", "Chicago", "60601"],
        coordinates: ["41.878113", "-87.629799"],
        bio: "I'm a teacher who loves educating and inspiring young minds.",
        interests: ["Teaching", "Traveling", "Reading"],
        lastActive: Date(),
        lookingFor: "male",
        hometown: "Chicago",
        relationshipStatus: .single,
        height: .average,
        ethnicity: .hispanic,
        religion: "Christian",
        politicalAffiliation: "Liberal",
        smokingHabit: .nonSmoker,
        drinkingHabit: .socialDrinker,
        exerciseFrequency: .regularly,
        children: .noChildren,
        pets: .hasPets,
        dateJoined: Date(),
        matched: [""],
        unmatched: [""],
        liked: [""],
        prompts: .other
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
        relationshipStatus: .single,
        height: .average,
        ethnicity: .black,
        religion: "Christian",
        politicalAffiliation: "Moderate",
        smokingHabit: .nonSmoker,
        drinkingHabit: .socialDrinker,
        exerciseFrequency: .regularly,
        children: .noChildren,
        pets: .hasPets,
        dateJoined: Date(),
        matched: [""],
        unmatched: [""],
        liked: [""],
        prompts: .other
    )
]





struct UserStruct {
    var id = UUID()
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
    var relationshipStatus: RelationshipStatus
    var height: Height
    var ethnicity: Ethnicity
    var religion: String
    var politicalAffiliation: String
    var smokingHabit: SmokingHabit
    var drinkingHabit: DrinkingHabit
    var exerciseFrequency: ExerciseFrequency
    var children: ChildrenStatus
    var pets: PetsStatus
    var dateJoined: Date
    var matched: [String]
    var unmatched: [String]
    var liked: [String]
    var prompts: Prompts

}


enum Prompts {
    case quote
    case opinion
    case other
}

enum RelationshipStatus {
    case single
    case inARelationship
    case married
    case divorced
    case widowed
}

enum Height {
    case short
    case average
    case tall
}

enum Ethnicity {
    case asian
    case black
    case latino
    case white
    case hispanic
    case other
}

enum SmokingHabit {
    case nonSmoker
    case socialSmoker
    case regularSmoker
}

enum DrinkingHabit {
    case nonDrinker
    case socialDrinker
    case regularDrinker
}

enum ExerciseFrequency {
    case rarely
    case occasionally
    case regularly
}

enum ChildrenStatus {
    case noChildren
    case wantChildren
    case haveChildren
}

enum PetsStatus {
    case hasPets
    case noPets
}



