//
//  PicklistSheetView.swift
//  Soul25
//
//  Created by Zablon Charles on 4/30/24.
//

import SwiftUI

struct PicklistSheetView: View {
    @Binding var isPresented: Bool
    
    @Binding var returned : String
    var title : String
    var label : String
    var sublabel : String
    var list : [String]
    var lottie = "telescope"
    
    
    var body: some View {
        VStack {
            
            
            LottieView(filename: lottie ,loop: false)
                .frame(height: 200)
                .padding(.top, 30)
                .padding(.bottom,10)
            
            Text("Tailor Your Preferences")
                .font(.headline)
                .padding(.bottom,5)
            Text("Your choices will help us refine your matches and make your experience more tailored to your preferences.")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal,25)
                .padding(.bottom,5)
            
            
            HStack {
                VStack(alignment: .leading, spacing: 3.0) {
                    Text(label)
                        .foregroundColor(Color("black"))
                    Text(returned.isEmpty ? sublabel :  returned)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                Picker("Picker", selection: $returned) {
                    ForEach(list, id: \.self) { item in
                        Text(item).tag(item)
                    }
                    
                    // Add more gender options as needed
                }
            }.padding(.horizontal)
                .padding(.vertical,10)
                .neoButtonOff(isToggle: true, cornerRadius: 13)
                .padding(.horizontal)
            
            Spacer()
            HStack(spacing: 2.0) {
                Image(systemName: returned.isEmpty ? "multiply" : "checkmark")
                //                Text(returned.isEmpty ? "Cancel" : "Done")
            }
            .animation(.easeInOut, value: returned.isEmpty)
            .padding(.horizontal,30)
            .padding(.vertical,10)
            .foregroundColor(!returned.isEmpty ? .green : Color("black"))
            .neoButtonOff(isToggle: false, cornerRadius: 13)
            .onTapGesture {
                
                //
                isPresented = false
                
            }
            
        }.navigationBarTitle(title, displayMode: .inline)
        
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

//struct PicklistSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        PicklistSheetView()
//    }
//}
