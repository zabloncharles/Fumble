import SwiftUI
import FirebaseFirestore


struct SignUpView: View {
    @Binding var onboardComplete : Bool
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var age = ""
    @State private var gender = ""
    @State private var avatar = ""
    @State private var photos = ""
    @State var selectedImages: [UIImage?] = Array(repeating: nil, count: 6)
    @State private var occupation = ""
    @State private var education = ""
    @State private var location = ""
    @State private var coordinates = ""
    @State private var bio = ""
    @State private var interests = ""
    @State private var lookingFor = ""
    @State private var hometown = ""
    @State private var relationshipStatus = ""
    @State private var height = ""
    @State private var ethnicity = ""
    @State private var religion = ""
    @State private var politicalAffiliation = ""
    @State private var smokingHabit = ""
    @State private var drinkingHabit = ""
    @State private var exerciseFrequency = ""
    @State private var children = ""
    @State private var pets = ""
    @State private var errorMessage: String?
    @State private var successMessage: String?
    @State var currentPage = 0
    @State private var lottie = ""
    @State private var title = ""
    @State private var description = ""
   @State var lottieChanged = false
    @State var buttonColor = Color.gray
    @State var buttonLabel = "Continue"
    var body: some View {
        
        ZStack {
            BackgroundView().edgesIgnoringSafeArea(.all)
            VStack{
                HStack {
                    HStack(spacing: 1.98) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                            .font(.footnote)
                        
                      
                        .neoButton(isToggle: false) {
                            currentPage -= currentPage
                        }
                    }.foregroundColor(.gray)
                        .opacity(currentPage == 0 ? 0 : 1)
                    Spacer()
                    Text("Step \(currentPage)/5")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }.padding(.horizontal,25)
                    
                Spacer()
            }
            VStack {
               
                VStack {
                 
                    HStack {
                        Text(title)
                           
                             .font(.headline)
                             
                        
                    }.multilineTextAlignment(.leading)
                        .padding(.top, 50)
                        .padding(.bottom,5)
                
                        Text(description)
                            .foregroundColor(.secondary)
                        
                        .padding(.horizontal,6)
                   
                    ZStack {
                        
                        if lottieChanged {
                            LottieView(filename: "confetti" ,loop: false)
                                .onAppear{
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation(.easeInOut){
                                            
                                            lottieChanged = false
                                        }
                                    }
                                }
                        } else {
                            LottieView(filename: lottie ,loop: true)
                                .transition(.opacity)
                        }
                        
                    }.frame(height: 200)
                        .padding(.top, 0)
                        .padding(.bottom,10)
                 
                }
               
                    switch currentPage {
                        
                        case 0:
                            
                            PersonalInfoView(
                                firstName: $firstName,
                                lastName: $lastName,
                                email: $email,
                                age: $age,
                                gender: $gender
                            )
                            .transition(.opacity)
                         
                        case 1:
                            
                            DateOfBirthPickerView(age: $age)
                                .transition(.opacity)
                        case 2:
                        ProfileInfoView(
                            avatar: $avatar,
                            photos: $photos,
                            bio: $bio, selectedImages: $selectedImages
                        )
                        .transition(.opacity)
                   
                        case 3:
                        OccupationEducationView(
                            occupation: $occupation,
                            education: $education
                        )
                        .transition(.opacity)
                        
                        case 4:
                        LocationView(
                            location: $location,
                            coordinates: $coordinates,
                            hometown: $hometown
                        )
                        .transition(.opacity)
                   
                    
                        case 5:
                        InterestsView(
                            interests: $interests,
                            lookingFor: $lookingFor
                        )
                        .transition(.opacity)
                       
                        case 6:
                        AdditionalInfoView(
                            relationshipStatus: $relationshipStatus,
                            height: $height,
                            ethnicity: $ethnicity,
                            religion: $religion,
                            politicalAffiliation: $politicalAffiliation,
                            smokingHabit: $smokingHabit,
                            drinkingHabit: $drinkingHabit,
                            exerciseFrequency: $exerciseFrequency,
                            children: $children,
                            pets: $pets
                        )
                        .transition(.opacity)
                      
                        case 7:
                        SubmitView(
                            errorMessage: $errorMessage,
                            successMessage: $successMessage,
                            createUser: createUser
                        )
                        .transition(.opacity)
                            
                        default:
                            Text("hmm")
                      
                    }
                   
               
                   
                Spacer()  // This spacer will push the content to the top
              
                ContinueButton(btnColor:buttonColor, btnLabel:buttonLabel) {
                    changeButtonColor()
                }
            }.padding(.horizontal,10)
                .animation(.easeInOut, value: currentPage) // Apply easeInOut animation to smooth transitions
                .onChange(of: currentPage) { newValue in
                    changeLottie()
                }
                .onAppear{
                    changeLottie()
                }
        }
    }
    func changeLottie(){
        lottieChanged = true
      
        if currentPage == 0 {
            
            lottie = "girlpic1"
            title = "Enter Your Name"
            description = "Please provide your first and last name. This information helps us personalize your experience and ensures that your profile is complete."
        } else if currentPage == 1 {
            lottie = "telescope"
            title = "Enter Your Date of Birth"
            description = "Please enter your date of birth to help us verify your age and personalize your experience. Use the date picker to select your birth date accurately."}
        else if currentPage == 2{
            lottie = "telescope"
            title = "Profile images"
            description = "To complete your profile, please upload 6 pictures. Click on the placeholders to select photos from your gallery."}
        else if currentPage == 3{
            lottie = "telescope"
            title = "Occupation and Education"
            description = "Tell us about your occupation and educational background. This helps us understand your professional journey and interests better."}
        else if currentPage == 4{
            lottie = "telescope"
            title = "Hometown"
            description = "Share your hometown with us. Let others know where you're from and what makes your hometown special to you."}
        else if currentPage == 5{
            lottie = "telescope"
            title = "Interests and Relationship Type"
            description = "Let's explore your interests and relationship preferences. Tell us about the things you love doing and the type of relationship you're looking for. Share what makes you unique and what you're hoping to find."}
        else if currentPage == 6 {
            lottie = "telescope"
            title = "More info.."
            description = "Share more about your interests, your background, and what you're seeking in a relationship. This helps us match you with like-minded individuals and create meaningful connections based on your preferences and lifestyle."}
        else {
            lottie = "telescope"
            title = "Done.."
            description = "Congratulations on taking the next step! Fill out the remaining fields to complete your sign-up. Provide details about your occupation, education, hometown, interests, and what you're looking for in a relationship. Upload six photos that showcase your personality and interests to enhance your profile. Welcome aboard!"
        }
           
                
        
    }
    func changeButtonColor(){
       
        if currentPage == 0 {
            if firstName.isEmpty || lastName.isEmpty || email.isEmpty {
                buttonColor = Color.red
                buttonLabel = "Please fill all the fields!"
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    buttonLabel = "Continue"
                }
//                return
            } else {
                buttonColor = Color.blue
                
               
            }
            
        } else if currentPage == 1 {
          }
        else if currentPage == 2{
           }
        else if currentPage == 3{
            }
        else if currentPage == 4{
            }
        else if currentPage == 5{
            }
        else if currentPage == 6 {
           }
        else {
            
        }
        
        currentPage = currentPage + 1
        
    }
    func createUser() {
        guard let age = Int(age) else {
//            errorMessage = "Age must be a number"
            age = String(25)
            return
        }
        
        let user = UserStruct(
            firstName: firstName,
            lastName: lastName,
            email: email,
            age: age,
            gender: gender,
            avatar: avatar,
            photos: photos.components(separatedBy: ","),
            occupation: occupation,
            education: education,
            location: location.components(separatedBy: ","),
            coordinates: coordinates.components(separatedBy: ","),
            bio: bio,
            interests: interests.components(separatedBy: ","),
            lastActive: Date(),
            lookingFor: lookingFor,
            hometown: hometown,
            relationshipStatus: relationshipStatus,
            height: height,
            ethnicity: ethnicity,
            religion: religion,
            politicalAffiliation: politicalAffiliation,
            smokingHabit: smokingHabit,
            drinkingHabit: drinkingHabit,
            exerciseFrequency: exerciseFrequency,
            children: children,
            pets: pets,
            dateJoined: Date(),
            matched: [""],
            unmatched: [""],
            liked: [""],
            prompts: "other"
        )
        
        let userService = UserService()
        userService.createUser(user: user) { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.successMessage = nil
            } else {
                self.successMessage = "User created successfully"
                self.errorMessage = nil
                onboardComplete = true
            }
        }
    }
}

// Subviews for each tab
struct PersonalInfoView: View {
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var email: String
    @Binding var age: String
    @Binding var gender: String
    
    var body: some View {
        VStack {
            TextFieldView(title: "First Name", text: $firstName)
            TextFieldView(title: "Last Name", text: $lastName)
            TextFieldView(title: "Email", text: $email)
            GenderPickerView(selectedGender: $gender )
         
            
           
        }
    }
}

struct DateOfBirthPickerView: View {
    @Binding var age: String
    @State var selectedDate = Date()
   
    
    var body: some View {
        VStack {
            DatePicker("", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden() // Hides the label
            
            Text("Selected Date: \(formattedDate(selectedDate))")
                .padding()
        }
        .padding()
        .onChange(of: selectedDate) { newValue in
            age = formattedDate(selectedDate)
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
struct GenderPickerView: View {
    @Binding var selectedGender: String
    let genders = ["Male", "Female", "Non-Binary", "Other", "Prefer not to say"]
    
    var body: some View {
        VStack(alignment: .leading) {
            GradientText(text: "Gender", gradient: [Color("black"), Color("black"), .purple],animate: false)
                .font(.subheadline)
                .multilineTextAlignment(.center)
            
            HStack {
                Text(!selectedGender.isEmpty ? "Successfully selected" : "Select gender...")
                    .foregroundColor(.gray.opacity(0.40))
                    .padding(.leading,10)
                Spacer()
                Picker(selection: $selectedGender, label: Text("Gender")) {
                    ForEach(genders, id: \.self) { gender in
                        Text(gender).tag(gender)
                    }
                }
                .pickerStyle(.automatic)
                
            }.padding(.vertical,8)
                .neoButtonOff(isToggle: false, cornerRadius: 10)
        }
        .padding(.horizontal)
    }
}

struct EducationPickerView: View {
    @Binding var selectedEducation: String
    let education = ["GED", "Highscool", "College", "Grad", "Phd"]
    
    var body: some View {
        VStack(alignment: .leading) {
            GradientText(text: "Education", gradient: [Color("black"), Color("black"), .purple],animate: false)
                .font(.subheadline)
                .multilineTextAlignment(.center)
            
            HStack {
                Text(!selectedEducation.isEmpty ? "Successfully selected" : "Select education...")
                    .foregroundColor(.gray.opacity(0.40))
                    .padding(.leading,10)
                Spacer()
                Picker(selection: $selectedEducation, label: Text("Education")) {
                    ForEach(education, id: \.self) { education in
                        Text(education).tag(education)
                    }
                }
                .pickerStyle(.automatic)
                
            }.padding(.vertical,8)
                .neoButtonOff(isToggle: false, cornerRadius: 10)
        }
        .padding(.horizontal)
    }
}


struct ProfileInfoView: View {
    @Binding var avatar: String
    @Binding var photos: String
    @Binding var bio: String
    @Binding var selectedImages: [UIImage?]
    @State private var showImagePicker = false
    @State private var imageIndexToReplace = 0
    
    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 16), count: 3), spacing: 16) {
                ForEach(0 ..< 6, id: \.self) { index in
                    ZStack {
                        Rectangle()
                            .fill(Color("white"))
                            .frame(width: 120, height: 150)
                            .neoButtonOff(isToggle: false, cornerRadius: 8)
                        
                        
                        if let image = selectedImages[index] {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 150)
                                .clipped()
                                .cornerRadius(8)
                        } else {
                            Image(systemName: "photo")
                        }
                        
                           
                    } .overlay(
                        
                        VStack {
                            if selectedImages[index] != nil {
                                HStack {
                                    Spacer()
                                    Image(systemName: "xmark")
                                        .foregroundColor(Color("black"))
                                        .padding(5)
                                        .background(Circle().fill(Color("offwhiteneo")))
                                        .offset(x:10, y:-15)
                                        .scaleEffect(0.77)
                                        .neoButton(isToggle: false) {
                                            //change the image
                                            imageIndexToReplace = index
                                            showImagePicker.toggle()
                                        }
                                }
                            } else {
                                HStack {
                                    Spacer()
                                    Image(systemName: "plus")
                                        .foregroundColor(Color("black"))
                                        .padding(5)
                                        .background(Circle().fill(Color("offwhiteneo")))
                                        .offset(x:10, y:-15)
                                        .scaleEffect(0.77)
                                        .neoButton(isToggle: false) {
                                            //change the image
                                            imageIndexToReplace = index
                                            showImagePicker.toggle()
                                        }
                                }
                            }
                            Spacer()
                        }
                    )
                  
                    .onTapGesture {
                        imageIndexToReplace = index
                        showImagePicker.toggle()
                    }
                }
            }
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $selectedImages[imageIndexToReplace])
            }
            .padding()
       
            
//            TextFieldView(title: "Avatar URL", text: $avatar)
//            TextFieldView(title: "Photos (comma separated URLs)", text: $photos)
//            TextFieldView(title: "Bio", text: $bio)
        }.padding(10)
    }
    func loadImage() {
        // Handle loaded image, e.g., perform any additional actions needed
    }
}


struct OccupationEducationView: View {
    @Binding var occupation: String
    @Binding var education: String
    
    var body: some View {
        VStack {
            TextFieldView(title: "Occupation", text: $occupation)
            EducationPickerView(selectedEducation: $education)
        }
    }
}

struct LocationView: View {
    @Binding var location: String
    @Binding var coordinates: String
    @Binding var hometown: String
    
    var body: some View {
        VStack {
//            TextFieldView(title: "Location (comma separated)", text: $location)
//            TextFieldView(title: "Coordinates (comma separated)", text: $coordinates)
//            TextFieldView(title: "Hometown", text: $hometown)
            MapSheetView(isPresented: .constant(true), returned: $coordinates, title: "Hometown", label: "Your Neighborhood", sublabel: "something", list: [""])
                .padding(.top,10)
                .neoButtonOff(isToggle: false, cornerRadius: 15)
        }
    }
}

struct InterestsView: View {
    @Binding var interests: String
    @Binding var lookingFor: String
    
    var body: some View {
        VStack {
            TextFieldView(title: "Interests (comma separated)", text: $interests)
            TextFieldView(title: "Looking For", text: $lookingFor)
        }
    }
}

struct AdditionalInfoView: View {
    @Binding var relationshipStatus: String
    @Binding var height: String
    @Binding var ethnicity: String
    @Binding var religion: String
    @Binding var politicalAffiliation: String
    @Binding var smokingHabit: String
    @Binding var drinkingHabit: String
    @Binding var exerciseFrequency: String
    @Binding var children: String
    @Binding var pets: String
    
    var body: some View {
        ScrollView {
            VStack {
                TextFieldView(title: "Relationship Status", text: $relationshipStatus)
                TextFieldView(title: "Height", text: $height)
                TextFieldView(title: "Ethnicity", text: $ethnicity)
                TextFieldView(title: "Religion", text: $religion)
                TextFieldView(title: "Political Affiliation", text: $politicalAffiliation)
                TextFieldView(title: "Smoking Habit", text: $smokingHabit)
                TextFieldView(title: "Drinking Habit", text: $drinkingHabit)
                TextFieldView(title: "Exercise Frequency", text: $exerciseFrequency)
                TextFieldView(title: "Children", text: $children)
                TextFieldView(title: "Pets", text: $pets)
            }
        }
    }
}

struct SubmitView: View {
    @Binding var errorMessage: String?
    @Binding var successMessage: String?
    let createUser: () -> Void
    
    var body: some View {
        VStack {
            if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            } else if let successMessage = successMessage {
                Text(successMessage)
                    .foregroundColor(.green)
            }
            
            Button(action: {
                createUser()
            }) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ViewController()
    }
}


struct ContinueButton : View {
    
    var btnColor = Color.gray
//    var buttonIcon = "mail"
    var btnLabel = "Continue"
    let next: () -> Void
    var body : some View {
        HStack(spacing: 2.0) {
            Image(systemName: "mail")
                .foregroundColor(.white)
            Divider()
                .frame(height:8)
            Text(btnLabel)
                .foregroundColor(.white)
            
        }.padding(.horizontal,27)
            .padding(.vertical,10)
            .background(btnColor)
            .cornerRadius(10)
            .neoButton(isToggle: false, perform: {
                withAnimation(.easeInOut) {
                    next()
                    
                }
            })
    }
}


