//
//  EditProfileInfoDetailView.swift
//  Soul25
//
//  Created by Zablon Charles on 4/20/24.
//

import SwiftUI
import MapKit
import Firebase
import FirebaseAuth

struct EditProfileInfoDetailView: View {
    @Binding var signedIn : Bool
    @State var currentUser: UserStruct? = fakeUser // Variable to hold the user data
    @State var userScrolledDown : CGFloat = 0
    @State var showPromptEditView = false
    @State  var firstName: String = ""
    @State  var lastName: String = ""
    @State  var age: String = ""
    @State  var gender: String = ""
    @State  var occupation: String = ""
    @State var returnedChange = ""
    @State var photos = [""]
    @State var isPresented = false
    @State var list : [String] = []
    @State var title = "title"
    @State var label = "label"
    @State var sublabel = "sublabel"
    @State var optionType = 0
    @State var trackChanges : Set<Int> = []
    @Binding var isSheetPresented: Bool
    @State var showfullimageTapped = false
    @Namespace var namespace
    @State var imageNamespaceId = ""
    @State var imageIndex = 0
    @State var signOutLabel = "Sign Out!"
    // Add more @State properties for other user profile information
    
    var body: some View {
        ZStack {
        BackgroundView()
            VStack {
                HStack{
                    Text("Profile")
                        .font(.largeTitle)
                        .bold()
                       Spacer()
                      
                                    Image(systemName: "xmark")
                                        .font(.title2)
                                        .foregroundColor(Color("black"))
                                        .neoButton(isToggle: false) {
                                            withAnimation(.spring()) {
                                                isSheetPresented = false
                                            }
                                        }
                                
                             
                            
                            
                            
                        
                }.padding(.horizontal,25)
                    .padding(.vertical,5)
                
                ScrollView(.vertical, showsIndicators: false) {
                    HStack {
                        VStack(alignment: .center) {
                            Text("Profile Infomation")
                            
                                .foregroundColor(Color("black"))
                            
                                Text("Tap to edit your pictures")
                                    .font(.footnote)
                                
                                    .foregroundColor(.gray)
                               
                               
                            
                        }
                        
                    }.padding(.horizontal)
                        .padding(.bottom,-5)
                    
                   VStack {
                       
                            LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 16), count: 3), spacing: 16) {
                                ForEach(0 ..< 6) { item in
                                   
                                    ZStack {
                                        Rectangle()
                                            .fill(.gray)
                                            .frame(width: 120, height: 150)
                                            .cornerRadius(8)
                                        
                                        Image(systemName: "photo")
                                        
                                        GetImageAndUrl(url: currentUser?.photos[item] ?? "",width: 120, height: 150, loaded: .constant(true), imageUrl: .constant(""))
                                            .cornerRadius(8)
                                            .matchedGeometryEffect(id: "imageNamespaceId\(item)", in: namespace)
                                            .neoButton(isToggle: false) {
                                                withAnimation(.spring()) {
                                                    showfullimageTapped = true
                                                    imageNamespaceId = "imageNamespaceId\(item)"
                                                    imageIndex = item
                                                }
                                            }
                                           
                                    } .overlay(
                                        VStack {
                                            HStack {
                                                Spacer()
                                                Image(systemName: "xmark")
                                                    .foregroundColor(Color("white"))
                                                    .padding(5)
                                                    .background(Circle().fill(Color("black")))
                                                    .offset(x:10, y:-10)
                                                    .scaleEffect(0.87)
                                                    .neoButton(isToggle: false) {
                                                        //
                                                        
                                                    }
                                            }
                                            Spacer()
                                        }
                                    )
                                        
                                }
                            }.padding(.horizontal,25)
                                .padding(.top,10)
                            
                        
                     
                    }
                    
                    
                    
                    
                    HStack {
                        Text("Written Prompts: (3)")
                        
                            .foregroundColor(.gray)
                        Spacer()
                        Image(systemName: "rectangle.and.pencil.and.ellipsis")
                            .foregroundColor(.gray)

                    }.padding(.horizontal,10)
                        .padding(.vertical,10)
                        .neoButtonOff(isToggle: false, cornerRadius: 10)
                        .padding(.horizontal,10)
                        .padding(.top,10)
                    
                    VStack {
                        
                        NavigationLink(destination: promptedit) {
                            PreferenceInfoCard(label: "I recently discovered that", sublabel: "Hamburgers are made in germany")
                        }
                        
                        NavigationLink(destination: promptedit) {
                            PreferenceInfoCard(label: "My favorite hobby is", sublabel: "Hiking")
                        }
                        NavigationLink(destination: promptedit) {
                            PreferenceInfoCard(label: "I like to undwind by", sublabel: "Going out to eat")
                        }
                   
                        // Add more form fields for other personal information
                    }.padding(.horizontal,25)
                        .padding(.top,5)
                   
                    HStack {
                        Text("Virtues")
                        
                            .foregroundColor(.gray)
                        Spacer()
                        Image(systemName: "figure.barre")
                            .foregroundColor(.gray)
                    }.padding(.horizontal,10)
                        .padding(.vertical,10)
                        .neoButtonOff(isToggle: false, cornerRadius: 10)
                        .padding(.horizontal,10)
                    
                    VStack {
                        
                        NavigationLink(destination: picklistview) {
                            PreferenceInfoCard(label: "Work", sublabel: "Emonics")
                        }
                        NavigationLink(destination: picklistview) {
                            PreferenceInfoCard(label: "Job Title", sublabel: "Software Engineer")
                        }
                        NavigationLink(destination: picklistview) {
                            PreferenceInfoCard(label: "School", sublabel: "Minnesota State")
                        }
                        NavigationLink(destination: picklistview) {
                            PreferenceInfoCard(label: "Education Level", sublabel: "Undergrad")
                        }
                        NavigationLink(destination: picklistview) {
                            PreferenceInfoCard(label: "Religious Beliefs", sublabel: "Christian")
                        }
                        NavigationLink(destination: MapSheetView(isPresented: .constant(false), returned: .constant(""), title: "location", label: "Central Minneapolis", sublabel: "central", list: [""])) {
                            PreferenceInfoCard(label: "Hometown", sublabel: "Otsego")
                        }
                        NavigationLink(destination: picklistview) {
                            PreferenceInfoCard(label: "Languages Spoken", sublabel: "Swahili, English, Spanish")
                        }
                        NavigationLink(destination: picklistview) {
                            PreferenceInfoCard(label: "Dating Intentions", sublabel: "Long-term relationship")
                        }
                        NavigationLink(destination: picklistview) {
                            PreferenceInfoCard(label: "Relationship Type", sublabel: "Monogamy")
                        }
                        // Add more form fields for other personal information
                    }.padding(.horizontal,25)
                        .padding(.top,5)
                
                
                    secondsection
                    
                    thirdsection
                    
                    
                }
            }
          
            
            
            if showfullimageTapped {
                showfullimage
            }
          
        }
        .sheet(isPresented: $isPresented) {
            
            //optiontype helps us know where we are making the change
            
            if optionType != 1 {
                PicklistSheetView(isPresented: $isPresented, returned: $returnedChange, title: "Preferences", label: label, sublabel: sublabel, list: list)
                    .onAppear{
                        // if the modal sheet is showing
                        if isPresented {
                            
                            // if we are editing the gender preference
                            if  optionType == 0 {
                                
                                label = "Gender"
                                sublabel = "Woman"
                                list = ["Male", "Female"]
                            }
                            // if we are editing hometown
                            
                        }
                    }
                    .onDisappear{
                        list = []
                        label = ""
                        //                    title = ""
                        sublabel = ""
                    }
            } else {
                MapSheetView(isPresented: $isPresented, returned: $returnedChange, title: "Preferences", label: label, sublabel: sublabel, list: list)
                    .onAppear{
                        if isPresented {
                            if  optionType == 1 {
                                label = "Hometown"
                                sublabel = "Chicago"
                                list = ["Maryland", "Chestnut"]
                            }
                        }
                    }
            }
            
        }
//        .navigationTitle("Profile")
//        .navigationBarTitleDisplayMode(.large)
        .onChange(of: isPresented) { newValue in
            
            
            if !isPresented && !returnedChange.isEmpty {
                trackChanges.insert(optionType)
            }
        }
    }
    var secondsection : some View {
        VStack{
           
           HStack {
                Text("Vitals")
                
                    .foregroundColor(.gray)
                Spacer()
                Image(systemName: "sailboat")
                    .foregroundColor(.gray)
           }.padding(.horizontal,10)
                .padding(.vertical,10)
                .neoButtonOff(isToggle: false, cornerRadius: 10)
                .padding(.horizontal,10)
            
            VStack {
                
                NavigationLink(destination: picklistview) {
                    PreferenceInfoCard(label: "Name", sublabel: "Charles")
                }
                NavigationLink(destination: picklistview) {
                    PreferenceInfoCard(label: "Gender", sublabel: "Man")
                }
                NavigationLink(destination: picklistview) {
                    PreferenceInfoCard(label: "Pronouns", sublabel: "None")
                }
                NavigationLink(destination: picklistview) {
                    PreferenceInfoCard(label: "Sexuality", sublabel: "Straight")
                }
                NavigationLink(destination: picklistview) {
                    PreferenceInfoCard(label: "Age", sublabel: "24")
                }
                NavigationLink(destination: picklistview) {
                    PreferenceInfoCard(label: "Height", sublabel: "6' 0\"")
                }
                NavigationLink(destination: MapSheetView(isPresented: .constant(false), returned: .constant(""), title: "location", label: "Central Minneapolis", sublabel: "central", list: [""])) {
                    PreferenceInfoCard(label: "Location", sublabel: "Central Minneapolis")
                }
                NavigationLink(destination: picklistview) {
                    PreferenceInfoCard(label: "Ethnicity", sublabel: "Black/African Descent")
                }
                NavigationLink(destination: picklistview) {
                    PreferenceInfoCard(label: "Children", sublabel: "Prefer not to say")
                }
            
                // Add more form fields for other personal information
            }.padding(.horizontal,25)
                .padding(.top,5)
            
           
        }
    }
    
    var thirdsection: some View {
        VStack{
            
            HStack {
                Text("Account")
                
                    .foregroundColor(.gray)
                Spacer()
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.gray)
            }.padding(.horizontal,10)
                .padding(.vertical,10)
                .neoButtonOff(isToggle: false, cornerRadius: 10)
                .padding(.horizontal,10)
            VStack {
                PreferenceInfoCard(label: "Sign Out", sublabel: "Log out of your account!")
                   
                    .overlay{
                        HStack {
                            Spacer()
                            Text(signOutLabel)
                                .padding(.horizontal,13)
                                .padding(.vertical,6)
                             
                                .background(.red)
                                .cornerRadius(10)
                                .neoButton(isToggle: false, perform: {
                                    // sign out using firebase
                                    signout()
                                    
                                })
                        } .padding(.horizontal,0)
                           
                }
                PreferenceInfoCard(label: "Hibernate", sublabel: "Pause your account")
                PreferenceInfoCard(label: "Delete", sublabel: "Delete your account")
            } .padding(.horizontal,25)
                .padding(.top,5)
         
           
           
            
           
        }
           
    }
    
    var promptedit: some View {
        PromptEditView(isPresented: $showPromptEditView)
    }
    var picklistview : some View{
        PicklistSheetView(isPresented: $isPresented, returned: $returnedChange, title: "Preferences", label: label, sublabel: sublabel, list: list)
            .onAppear{
                // if the modal sheet is showing
                
            }
            .onDisappear{
                list = []
                label = ""
                //                    title = ""
                sublabel = ""
                if  optionType == 0 {
                    withAnimation(){
//                        storedValues[0] = returnedChange
                    }
                    
                }
            }
    }
    
    var showfullimage: some View {
        FullImageView(showfullimageTapped: $showfullimageTapped, namespace: namespace,imageNamespaceId:imageNamespaceId, imageIndex: imageIndex)
    }
    
    func signout(){
        signOutLabel = "Signing Out!"
        
        
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        // Set the data to update
        
        db.collection("users").whereField("email", isEqualTo: user?.email ?? "")
            .getDocuments() { (querySnapshot, error) in
                if error != nil {
                    //there was an error
                    
                    signOutLabel = "There was an error"
                    
                } else {
                    for document in querySnapshot!.documents {
                        db.collection("users").document("\(document.documentID)").setData(["online": false], merge: true) { error in
                            
                            if error == nil {
                                
                               
                                
                                isSheetPresented = false
                                    signedIn = false
                               
                            }
                        }
                    }
                }
            }
        try! Auth.auth().signOut()
        
     
    }
}


struct EditProfileInfoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileInfoDetailView( signedIn: .constant(false), isSheetPresented: .constant(false))
    }
}


