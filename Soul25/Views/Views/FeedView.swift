//
//  FirstView.swift
//  Soul25
//
//  Created by Zablon Charles on 4/25/24.
//

import SwiftUI

struct FeedView: View {
    @Binding var profiles: [UserStruct]
    @Binding var profile: UserStruct
    @Binding var showProfile: Bool
    @State var report = false
    @State private var shuffledViews: Bool = Bool.random()
    
    var body: some View {
        VStack {
            ForEach(Array(profiles.enumerated()), id: \.element.id) { index, user in
                if index % 3 == 0 {
                    QuoteImageCard(name: user.firstName, urlReturned: .constant(""), loaded: .constant(true), report: .constant(false))
                        .neoButton(isToggle: false) {
                            profile = user
                            showProfile = true
                        }
                } else if index % 3 == 1 {
                  
                        QuotePillsCard(name: user.firstName, report: $report)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 10)
                            .neoButton(isToggle: false) {
                                profile = user
                                showProfile = true
                            }
               
                } else {
                    QuoteAnswerCard(name: user.firstName, report: .constant(false))
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .neoButton(isToggle: false) {
                            profile = user
                            showProfile = true
                        }
                }
                Divider()
            }
        }
        .padding(.bottom, 90)
      
    }
}


//struct FeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView( profiles: .constant(fakeUsers))
//    }
//}
