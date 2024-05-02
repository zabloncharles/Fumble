//
//  FullImageView.swift
//  Soul25
//
//  Created by Zablon Charles on 4/30/24.
//

import SwiftUI

struct FullImageView: View {
        @Binding var showfullimageTapped : Bool
        let namespace: Namespace.ID
        var imageNamespaceId = ""
        @State var currentUser: UserStruct? = fakeUser // Variable to hold the user data
        var imageIndex = 0
        
        var body: some View {
            VStack {
                GetImageAndUrl(url: currentUser?.photos[imageIndex] ?? "",width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, loaded: .constant(true), imageUrl: .constant(""))
                    .cornerRadius(8)
                
                    .overlay{
                        VStack {
                            HStack {
                                Spacer()
                                Image(systemName: "xmark")
                                    .font(.title2)
                                    .foregroundColor(Color("white"))
                                    .neoButton(isToggle: false) {
                                        withAnimation(.spring()) {
                                            showfullimageTapped = false
                                        }
                                    }
                            }.padding(.horizontal,30)
                                .padding(.top,50)
                            Spacer()
                        }
                        
                        
                    }
            }.edgesIgnoringSafeArea(.all)
                .matchedGeometryEffect(id: imageNamespaceId, in: namespace)
        }
    }

//struct FullImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        FullImageView()
//    }
//}
