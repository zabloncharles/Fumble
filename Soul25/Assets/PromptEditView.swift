//
//  PromptEditView.swift
//  Soul25
//
//  Created by Zablon Charles on 4/30/24.
//

import SwiftUI

struct PromptEditView: View {
      @FocusState var isKeyboardFocused: Bool
        @Binding var isPresented: Bool
        @State var pickedPrompt  = ""
        var title : String = "Unveil Your Character"
        var title2 : String = "Express yourself! Choose a prompt and share your thoughts to showcase your personality on your profile."
        var list: [String] = [
        "My ideal Sunday morning involves...",
        "The last book I couldn't put down was...",
        "A hidden talent of mine is...",
        "If I could travel anywhere tomorrow, I'd go to...",
        "I'm passionate about...",
        "One thing on my bucket list is...",
        "The most spontaneous thing I've ever done is...",
        "I'm known for my...",
        "The best way to win me over is...",
        "My guilty pleasure TV show/movie is..."
        ]
        var lottie = "writing"
        @State var userAnswer = ""
        @State var textFieldPlaceholder = "Well ?"
        @State var prompt = ["What is your ideal friday..","Go out and enjoy my night"]
        @State var tappedComplete = false
        var body: some View {
            VStack {
                
                
                LottieView(filename: lottie ,loop: false)
                    .frame(height: 200)
                    .padding(.top, 30)
                    .padding(.bottom,10)
                
                Text(title)
                    .font(.headline)
                    .padding(.bottom,5)
                Text(title2)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,25)
                    .padding(.bottom,5)
                
                
                HStack {
                    VStack(alignment: .leading, spacing: 3.0) {
                        Text(prompt[0].isEmpty ? list[0] : pickedPrompt.isEmpty ? prompt[0] : pickedPrompt)
                            .foregroundColor(Color("black"))
                        Text(prompt[1].isEmpty ? "Answer the prompt:)" :  pickedPrompt.isEmpty ? prompt[1] : "Answer prompt..")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Picker("Picker", selection: $pickedPrompt) {
                        ForEach(list, id: \.self) { item in
                            Text(item).tag(item)
                        }
                 
                    }
                    .onChange(of: pickedPrompt) { V in
                       
                        tappedComplete = false
                        textFieldPlaceholder = ""
                        
                    }
                   
                }.padding(.horizontal)
                    .padding(.vertical,10)
                    .neoButtonOff(isToggle: true, cornerRadius: 13)
                    .padding(.horizontal)
                
                if !tappedComplete && !pickedPrompt.isEmpty {
                    TextField(textFieldPlaceholder, text: $userAnswer)
                        .focused($isKeyboardFocused)
                        .padding(.horizontal)
                        .padding(.vertical,10)
                        .padding(.bottom,100)
                        .neoButtonOff(isToggle: true, cornerRadius: 13)
                        .onTapGesture {
                            isKeyboardFocused = true
                        }
                        .padding(.horizontal)
                        .overlay{
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Text("\(userAnswer.count)/50")
                                        .font(.callout)
                                        .foregroundColor(userAnswer.count > 50 ? .red : .blue)
                                        .padding([.leading, .bottom, .trailing])
                                        .padding(.trailing,15)
                                }
                            }
                    }
                }
                
                Spacer()
                HStack(spacing: 5.0) {
                    Image(systemName: userAnswer.count < 10 ? "multiply" : "checkmark.circle")
                                    Text(userAnswer.count < 10 ? "Cancel" : "Complete")
                }
                .animation(.easeInOut, value: pickedPrompt.isEmpty)
                .padding(.horizontal,30)
                .padding(.vertical,10)
                .foregroundColor(!pickedPrompt.isEmpty ? userAnswer.count < 10 ? Color("black") : .green : Color("black"))
                .neoButtonOff(isToggle: false, cornerRadius: 13)
                .neoButton(isToggle: false, perform: {
                    //
                    tappedComplete = true
                    
                    if userAnswer.count > 10 {
                        if pickedPrompt.isEmpty {
                            prompt[0] = list[0]
                        } else {
                            prompt[0] = pickedPrompt
                            pickedPrompt = ""
                        }
                        
                        prompt[1] = userAnswer
                    } else {
                        isPresented = false
                    }
                    
                })
              
                
                
                
                
            }
            
                .background(Color("offwhiteneo"))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if value.translation.height > 150 {
                                isPresented = false
                            }
                        }
                )
        }
    }
    


struct PromptEditView_Previews: PreviewProvider {
    static var previews: some View {
        PromptEditView(isPresented: .constant(false))
    }
}
