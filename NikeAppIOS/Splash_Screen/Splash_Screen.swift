import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                Image("nike")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    isActive = true
                }
            }
            .navigationDestination(isPresented: $isActive) {
                ContentView()
            }
        }
    }
}

#Preview {
    SplashScreen()
}
