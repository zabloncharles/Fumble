//
//  FirstView.swift
//  Soul25
//
//  Created by Zablon Charles on 4/25/24.
//

import SwiftUI

struct FeedView: View {
    @State var scrolled = false
    @State var report = false
    @Binding var profiles: [UserStruct]
    
    var body: some View {
        VStack {
          
                ForEach(profiles, id: \.id) { user in
                    
                    let randomNumber = Int.random(in: 0..<3)
                    switch randomNumber {
                        case 0:
                            QuoteAnswerCard(name: user.firstName, report: .constant(false))
                                .padding(.horizontal, 15)
                                .padding(.vertical, 10)
                        case 1:
                            QuotePillsCard(name: user.firstName, report: $report)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 10)
                        case 2:
                            QuoteImageCard(name:user.firstName, urlReturned: .constant(""), loaded: .constant(true), report: .constant(false))
                        
                        default:
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color("black")))
                    }
                   Divider()
                 
                }
            
        }.padding(.bottom,90)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView( profiles: .constant(fakeUsers))
    }
}
