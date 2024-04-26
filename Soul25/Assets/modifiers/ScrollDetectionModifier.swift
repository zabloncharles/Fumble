
import SwiftUI



struct ScrollDetectionModifier: ViewModifier {
    @Binding var userScrolledDown: Bool // Binding to the userScrolledDown variable
    @Binding var userReloadingView : Bool
 
    
    func body(content: Content) -> some View {
        content
           
            .background(
                GeometryReader { proxy in
                    let offset = proxy.frame(in: .named("scroll")).minY
                    Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
                }
            )
            .onPreferenceChange(ScrollPreferenceKey.self) { offset in
          
                if offset > 155 {
                    userReloadingView = true
                   
                } 
                
                
                
                if offset > -55 {
                    withAnimation(.spring()) {
                        userScrolledDown = true
                    }
                } else {
                    withAnimation(.spring()) {
                        userScrolledDown = false
                    }
                  
                }
                
                
               
            }
    }
}

extension View {
    func scrollDetection(userScrolledDown: Binding<Bool>, userReloadingView: Binding<Bool>) -> some View {
        self.modifier(ScrollDetectionModifier(userScrolledDown: userScrolledDown, userReloadingView: userReloadingView))
    }
}
