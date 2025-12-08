import SwiftUI

struct Discover_Screen: View {
    @State private var showAuthSheet = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Discover")
                        .font(.system(size: 32, weight: .bold))
                    
                    Text("Tuesday, 3 May")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                }
                .padding(.horizontal)
                .padding(.top)
                
                
                ZStack(alignment: .bottomLeading) {
                    
                    Image("nike_jordan")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .cornerRadius(16)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("In Your Element")
                            .foregroundColor(.white.opacity(0.8))
                        
                        Text("JORDAN FLIGHT\nESSENTIALS")
                            .font(.system(size: 30, weight: .black))
                            .foregroundColor(.white)
                        
                        Button("Shop Now") {
                            showAuthSheet = true
                        }
                        .font(.system(size: 17, weight: .semibold))
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(30)
                        .padding(.top, 8)
                    }
                    .padding(20)
                }
                .padding(.horizontal)
                
                Spacer(minLength: 40)
            }
        }
        .background(Color.white)
        .sheet(isPresented: $showAuthSheet) {
            WebAuth_Screen()
        }
    }
}

#Preview {
    NavigationStack {
        Discover_Screen()
    }
}
