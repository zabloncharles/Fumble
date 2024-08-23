//
//  SettingsView.swift
//  Soul25
//
//  Created by Zablon Charles on 4/20/24.
//
import SwiftUI
import MapKit

struct SettingsView: View {
    @AppStorage("currentUserData") var currentUserData: String?
    @Binding var currentUser: UserStruct?
    @State var userScrolledDown : CGFloat = 0
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var age: String = ""
    @State var gender: String = ""
    @State var occupation: String = ""
    @State var returnedChange = ""
    @State var isPresented = false
    @State var list : [String] = []
    @State var storedValues = ["Woman","Chicago"]
    @State var title = "title"
    @State var label = "label"
    @State var sublabel = "sublabel"
    @State var optionType = 500
    @State var trackChanges : Set<Int> = []
    @Binding var isSheetPresented: Bool
    @AppStorage("signedIn") var signedIn = false
    @StateObject private var authModel = AuthViewModel()
    
    @State private var isSpinning = false
    // Add more @State properties for other user profile information
    
    var body: some View {
       
            ZStack {
                BackgroundView()
              
                    ScrollView(.vertical, showsIndicators: false) {
      
                        HStack {
                            Text("Match Preferences: ")
                            
                                .foregroundColor(.gray)
                            Spacer()
                            Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                .foregroundColor(.gray)
                            
                        }.padding(.horizontal,10)
                            .padding(.vertical,10)
                            .neoButtonOff(isToggle: false, cornerRadius: 10)
                            .padding(.horizontal,20)
                            .padding(.top,10)
                          
                            VStack {
                                
                                NavigationLink(destination: picklistview
                                    .onAppear{
                                        label = "Gender"
                                        sublabel = "Woman"
                                        list = ["Male", "Female"]
                                    }
                                    .onDisappear{
                                         storedValues[0] = returnedChange
                                    }
                                
                                ) {
                                    VStack {
                                        PreferenceInfoCard(label: "Interested in", sublabel: storedValues[0])
                                    }
                                }
                                
                                NavigationLink(destination:
                                                mapview
                                    .onAppear{
                                        label = "Hometown"
                                      
                                        
                                    }
                                    .onDisappear{
                                        storedValues[1] = returnedChange
                                    }
                                
                                
                                ) {
                                    VStack {
                                        PreferenceInfoCard(label: "My hometown", sublabel: storedValues[1])
                                    }
                                }
                                
                                NavigationLink(destination: picklistview) {
                                    VStack {
                                        PreferenceInfoCard(label: "Maximum distance", sublabel: "100 mi")
                                    }
                                }
                                
                                NavigationLink(destination: picklistview) {
                                    VStack {
                                        PreferenceInfoCard(label: "Age range", sublabel: "Women 18 - 30")
                                    }
                                }
                                
                                NavigationLink(destination: picklistview) {
                                    VStack {
                                        PreferenceInfoCard(label: "Ethnicity", sublabel: "Black/African")
                                    }
                                }
                                
                                NavigationLink(destination: picklistview) {
                                    VStack {
                                        PreferenceInfoCard(label: "Religion", sublabel: "Christian")
                                    }
                                }
                                // Add more form fields for other personal information
                            }.padding()
                            .padding(.top,-10)
                            
                            
                            .padding(.horizontal)
                         
                            
                           
                           
                            // Add more sections for additional profile information
                        HStack {
                            Text("Subcribed Member Preferences: ")
                            
                                .foregroundColor(.gray)
                            Spacer()
                            Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                .foregroundColor(.gray)
                            
                        }.padding(.horizontal,10)
                            .padding(.vertical,10)
                            .neoButtonOff(isToggle: false, cornerRadius: 10)
                            .padding(.horizontal,20)
                      
                        VStack {
                            
                            NavigationLink(destination:picklistview) {
                                VStack {
                                    PreferenceInfoCard(label: "Height", sublabel: "Open")
                                       
                                }
                            }
                            
                            NavigationLink(destination: picklistview) {
                                VStack {
                                    PreferenceInfoCard(label: "Dating Intentions", sublabel: "Open")
                                }
                            }
                            
                            NavigationLink(destination: picklistview) {
                                VStack {
                                    PreferenceInfoCard(label: "Children", sublabel: "Open")
                                }
                            }
                            
                            NavigationLink(destination: picklistview) {
                                VStack {
                                    PreferenceInfoCard(label: "Family Plans", sublabel: "Open")
                                }
                            }
                            
                            NavigationLink(destination: picklistview) {
                                VStack {
                                    PreferenceInfoCard(label: "Drugs", sublabel: "Open")
                                }
                            }
                            
                            NavigationLink(destination: picklistview) {
                                VStack {
                                    PreferenceInfoCard(label: "Smoking", sublabel: "Open")
                                }
                            }
                            
                            NavigationLink(destination: picklistview) {
                                VStack {
                                    PreferenceInfoCard(label: "Marijuana", sublabel: "Open")
                                }
                            }
                            
                            NavigationLink(destination: picklistview) {
                                VStack {
                                    PreferenceInfoCard(label: "Drinking", sublabel: "Open")
                                }
                            }
                            
                            NavigationLink(destination: picklistview) {
                                VStack {
                                    PreferenceInfoCard(label: "Politics", sublabel: "Open")
                                }
                            }
                            
//                            NavigationLink(destination: picklistview) {
//                                VStack {
//                                    PreferenceInfoCard(label: "Education Level", sublabel: "Open")
//                                }
//                            }
                          
                            
                            VStack {
                                HStack {
                                    VStack(alignment: .leading, spacing: 3.0) {
                                        Text("Sign Out")
                                            .foregroundColor(Color("black"))
                                        Text(authModel.isSignedOut ? "Success":"Error signing out!")
                                            .font(.subheadline)
                                            .foregroundColor(authModel.isSignedOut ? .green : .gray)
                                    }
                                    Spacer()
                                    
                                    if authModel.isSignedOut {
                                        Image(systemName:"circle.dotted")
                                            .foregroundColor(.gray)
                                            .rotationEffect(.degrees(isSpinning ? 360 : 0))
                                            .animation(
                                                Animation.linear(duration: 5.0),
                                                value: isSpinning
                                            )
                                            .onAppear {
                                                self.isSpinning = true
                                                isSheetPresented = false
                                            }
                                            
                                           
                                    } else {
                                        Image(systemName:"arrow.right")
                                            .foregroundColor(.gray)
                                    }
                                    
                                    
                                   
                                    
                                }.background(Color("white").opacity(0.02))
                                Divider()
                            }.neoButton(isToggle: false, perform: {
                               
                                // Clear local storage
                                currentUserData = nil
                                currentUser = nil
                                signedIn = false
                                authModel.signOut()
                                
                                
                            })
                           
                            // Add more form fields for other personal information
                        } .padding()
                            .padding(.top,-10)
                            .padding(.horizontal)
                           
                        
                        
                
                        Spacer()
                    }
                    .padding(.top, 50)
                    
                    
                VStack {
                    HStack{
                       
                            Text("Settings")
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
                        
                        
                        
                        
                        
                        
                    }
                        .padding(.horizontal,25)
                        .padding(.vertical,5)
                        .background(Color("offwhiteneo"))
                    Spacer()
                }
                
    //        
               
            }
               
            
            .onChange(of: optionType) { newValue in
               
               
                if !isPresented && !returnedChange.isEmpty {
                    trackChanges.insert(optionType)
                }
                // if we are editing the gender preference
               
        }
        
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
                        storedValues[0] = returnedChange
                    }
                    
                }
            }
    }
    var mapview: some View {
        MapSheetView(isPresented: $isPresented, returned: $returnedChange, title: "Preferences", label: label, sublabel: sublabel, list: list)
            .onAppear{
             
            }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView( currentUser: .constant(fakeUser), isSheetPresented: .constant(false))
    }
}






struct MapSheetView: View {
    @Binding var isPresented: Bool
    @Binding var returned : String
    var title : String
    var label : String
    var sublabel : String
    var list : [String]
    var lottie = "telescope"
    @State var cityName = ""
    @State private var middleCoordinate: CLLocationCoordinate2D?
    @State private var coordinates = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194) // San Francisco coordinates
    
    var body: some View {
        ZStack {
            //our map
            MapView(middleCoordinate: $middleCoordinate, coordinates: $coordinates, cityName: $returned)
                .overlay(
                    ZStack{
                        RippleCircle()
                            .frame(width:140)
                        Circle()
                            .fill(.red.opacity(0.60))
                            .frame(width: 20)
                        VStack {
                            Spacer()
                            HStack {
                                Text("Coordinates: \(middleCoordinate?.latitude ?? 0.00), \(middleCoordinate?.longitude ?? 0.00)")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                    .rotationEffect(.degrees(90))
                                    .offset(x: -110, y:-110)
                                Spacer()
                            }.padding()
                                .padding(.bottom,70)
                        }
                    }
                    
                    
                    
                    
                )
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack(alignment: .center) {
                    
                    HStack {
                        Spacer()
                        
                        
                        VStack(alignment: .center, spacing: 3.0) {
                            Text(label)
                                .foregroundColor(Color("black"))
                            HStack {
                                Image(systemName: "location.north")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text(cityName.isEmpty ? returned : cityName)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                        }.multilineTextAlignment(.center)
                        
                        Spacer()
                        
                    }.padding(.horizontal)
                        .padding(.vertical,10)
                        .padding(.top,-30)
                    
                    
                    
                }
                .padding(.top,20)
                .background(Color("offwhiteneo"))
                
                
                
                
                
                
                Spacer()
                
                
                HStack {
                    
                    Text(returned.isEmpty ? "Cancel" : "Done")
                }
                .animation(.easeInOut, value: returned.isEmpty)
                .padding(.horizontal,30)
                .padding(.vertical,10)
                
                .foregroundColor(Color("black"))
                .neoButtonOff(isToggle: false, cornerRadius: 19)
                .onTapGesture {
                  
                    isPresented = false
                    
                }
                
                
            }
            
            
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.height > 150 {
                            isPresented = false
                        }
                    }
            )
            
            
        }.navigationBarTitle(title, displayMode: .inline)
    }
}
