import SwiftUI

struct NineteenthScreen: View {
    @StateObject private var favManager = FavoritesManager()
    
    private var contentView: some View {
        ZStack(alignment: .bottom) {
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    Image("Nineteenth_top")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 420)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .padding(.top, 120)
                    Image("Nineteenth_bottom")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .padding(.top, 10)
                    Text("The future of women in\nsneaker culture looks like a steal top and growth")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(10)
                        .padding(.top, 20)
                        .padding(.horizontal, 50)

                    Spacer(minLength: 40)
                }
                .padding(.bottom, 140)
            }
            Button(action: {}) {
                Text("Shop Air Max")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(
                        Capsule()
                            .fill(Color.black)
                    )
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 50)
        }
        .ignoresSafeArea(edges: .top)
    }
    
    var body: some View {
        NavigationStack {
            TabView {
                contentView
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }

                Discover_Screen()
                    .tabItem {
                        Image(systemName: "bag")
                        Text("Shop")
                    }

                FavoritesScreen()
                    .tabItem {
                        Image(systemName: "heart")
                        Text("Favorites")
                    }

                Text("Bag")
                    .tabItem {
                        Image(systemName: "bag.fill")
                        Text("Bag")
                    }

                ProfileTabView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
            }
            .environmentObject(favManager)
            .navigationBarHidden(true)
        }
    }
}

struct NineteenthScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NineteenthScreen()
        }
        .previewDevice("iPhone 14 Pro")
    }
}
