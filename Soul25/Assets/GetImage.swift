//
//  GetImage.swift
//  ionicFusion
//
//  Created by Zablon Charles on 5/23/23.
//

import SwiftUI

struct GetImageAndUrl: View {
    @State private var image: Image?
    @State var url = ""
    var width : CGFloat = 0
    var height : CGFloat = 0
    @Binding var loaded : Bool
    @Binding var imageUrl : String
    @State var animate = false
    
    var body: some View {
       VStack {
            
              
                    if image != nil {
                        
                       
                            image!
                               
                                
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(width: height != 0 ? width : nil, height: height != 0 ? height : nil)
                            
                                .clipped()
                                .contentShape(Rectangle())

                                .onAppear{
                                    
                                    withAnimation(.spring()){
                                        loaded = true
                                    }
                                  
                                }
                               
                      
                        
                        
                    } else {
                        
                        
                        ZStack {
                            
                            HStack {
                                LinearGradient(
                                    gradient: Gradient(colors: [.gray.opacity(0.10)]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                    
                                ).frame(width: 30)
                                    .blur(radius: 20)
                                    .offset(x: animate ? -UIScreen.main.bounds.width : UIScreen.main.bounds.width)
                                  
                                    .animation(.spring().repeatCount(10), value: animate)
                                
                                Spacer()
                                    
                            }
                            Color.gray.opacity(0.50)
                            
                                    ProgressView()
                                   
                                    Image(systemName: "photo")
                                        .font(.title)
                                   
                              
                   
                            
                           
                               
                        } .frame(width: height != 0 ? width : nil, height: height != 0 ? height : nil)
                            .onAppear{
                                animate = true
                            }
                     
                    }
                
               
            
       }
            
          
        .onAppear {
            loadImageFromAPI()
        }
    }
    
    func loadImageFromAPI() {
        guard let url = URL(string: url.isEmpty ? "https://source.unsplash.com/random/?bikini" : url) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = Image(uiImage: uiImage)
                }
                
                // Get the actual URL from the response
                if let httpResponse = response as? HTTPURLResponse {
                    let actualURL = httpResponse.url
                    imageUrl = ("\(actualURL?.absoluteString ?? "Unknown")")
                }
            }
        }.resume()
    }
}


