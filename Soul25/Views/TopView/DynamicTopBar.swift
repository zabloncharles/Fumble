//
//  DynamicTopBar.swift
//  Soul25
//
//  Created by Zablon Charles on 4/21/24.
//

import SwiftUI

struct DynamicTopBar: View {
    @AppStorage("currentPage") var selected = 0
    var label : String
    var labelicon : String
    var trailinglabel = ""
    var trailinglabelicon = ""
    var notification = false
    @State var scrolledUp = false
    @State var typeText = ""
    let completion: () -> Void
    var body: some View {
        HStack(alignment: .center) {
         
                VStack {
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(height:40)
                
                .overlay(
                    VStack(alignment: .center, spacing: 8) {
                        HStack {
                            HStack(spacing: 3.0) {
                                
                                Text(label)
                                    .font(.title)
                                    .bold()
                                
                                  
                                   
                                
                                
                                Image(systemName: labelicon)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                
                            }
                            
                            Spacer()
                            
                            if notification {
                                Text(trailinglabel)
                                    .padding(5)
                                    .background(Circle()
                                        .fill(.red)
                                                
                                    .padding(-2))
                                    .neoButton(isToggle: false) {
                                        withAnimation(.spring()) {
                                            completion()
                                        }
                                    }
                            } else {
                                
                                HStack(alignment: .center) {
                                  
                                    
                                    Image(systemName: trailinglabelicon)
                                        .font(.title)
                                        .foregroundColor(selected == 4 ? Color("black") : .red)
                                    //number of messages
                                    if  !trailinglabel.isEmpty {
                                        Text(trailinglabel)
                                    }
                                }.padding(.horizontal,12)
                                    .padding(.vertical,5)
                                    .background(Color.red.opacity(!trailinglabelicon.isEmpty ? trailinglabel.isEmpty && !trailinglabelicon.isEmpty ? 0 : 0.8 : 0))
                                    .cornerRadius(20)
                                    .neoButton(isToggle: false) {
                                        withAnimation(.spring()) {
                                            completion()
                                        }
                                    }
                                
                            }
                            
                        }.padding(.top,10)
                            .padding(.horizontal,8)
                        
                        Divider()
                            .foregroundColor(.secondary)
                            .opacity(0.9)
                        
                        
                            .accessibilityElement(children: .combine)
                    }
                    
                        .background(
                            Rectangle()
                                .fill(Color("offWhite"))
                                
                        )
                    
                        .padding(.leading, 10)
                )
            
        } .onAppear{
          
        }
    }
    
    func typeWriter(_ text: String, completion: @escaping () -> Void) {
        
//        typeText = "hey"
        var currentIndex = 0
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
            if currentIndex < text.count {
                let index = text.index(text.startIndex, offsetBy: currentIndex)
                let character = text[index]
                
                DispatchQueue.main.async {
                    withAnimation(.easeIn) {
                        typeText += String(character)
                    } // Update the typedText property on the main queue
                }
                
                currentIndex += 1
            } else {
                
                timer.invalidate()
                completion()
                // Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { timer in
                //   withAnimation(.easeInOut) {
                //  typeText = original
                //
                //   }
                // }
                
            }
        }
    }
}


