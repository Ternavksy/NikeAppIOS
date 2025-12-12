import SwiftUI

struct Main_Screen: View {
    @StateObject var favManager = FavoritesManager()
    @StateObject var bagManager = BagManager()
    @StateObject var appState = AppState()

    var body: some View {
        TabView {
            NavigationStack {
                HomeTab()
                    .environmentObject(favManager)
                    .environmentObject(bagManager)
                    .environmentObject(appState)
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            .tag(0)

            NavigationStack {
                if appState.onboardingCompleted {
                    ShopScreen()
                        .environmentObject(favManager)
                        .environmentObject(bagManager)
                        .environmentObject(appState)
                } else {
                    Discover_Screen()
                        .environmentObject(favManager)
                        .environmentObject(bagManager)
                        .environmentObject(appState)
                }
            }
            .tabItem {
                Image(systemName: "bag")
                Text("Shop")
            }
            .tag(1)

            NavigationStack {
                FavoritesScreen()
                    .environmentObject(favManager)
                    .environmentObject(bagManager)
                    .environmentObject(appState)
            }
            .tabItem {
                Image(systemName: "heart")
                Text("Favorites")
            }
            .tag(2)

            NavigationStack {
                BagScreen()
                    .environmentObject(bagManager)
                    .environmentObject(favManager)
                    .environmentObject(appState)
            }
            .tabItem {
                Image(systemName: "bag.fill")
                Text("Bag")
            }
            .tag(3)
            .badge(bagManager.items.count)
            NavigationStack {
                ProfileTabView()
                    .environmentObject(favManager)
                    .environmentObject(bagManager)
                    .environmentObject(appState)
            }
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
            .tag(4)
        }
        .navigationBarHidden(true)
    }
}

struct HomeTab: View {
    @EnvironmentObject var favManager: FavoritesManager
    @EnvironmentObject var bagManager: BagManager
    @EnvironmentObject var appState: AppState
    
    let shoes = [
        ("Air Jordan XXXVI", "US$185", "air-jordan1"),
        ("Air Jordan XXXVII", "US$190", "air-jordan1"),
        ("Air Jordan XXXVIII", "US$200", "air-jordan1")
    ]

    let shopItems = [
        ("Nike Air Force 1", "US$120", "air-force1"),
        ("Nike Air Max 90", "US$150", "air-max90")
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("What's new")
                        .font(.headline)
                    Text("The latest arrivals from Nike")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(shoes, id: \.0) { shoe in
                            VStack(alignment: .leading) {
                                NavigationLink(destination: Best_Sellers()
                                    .environmentObject(favManager)
                                    .environmentObject(bagManager)) {
                                    Image(shoe.2)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 260, height: 260)
                                        .background(Color(.systemGray6))
                                        .cornerRadius(12)
                                }
                                .buttonStyle(PlainButtonStyle())

                                Text(shoe.0)
                                    .font(.headline)
                                    .padding(.top, 8)
                                Text(shoe.1)
                                    .foregroundColor(.gray)
                            }
                            .frame(width: 260)
                        }
                    }
                    .padding(.horizontal)
                }

                Image("Ronaldo")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(16)
                    .padding(.horizontal)

                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Shop My Interests")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Spacer()
                        NavigationLink(destination: Chapter_Shop_Screen()
                            .environmentObject(favManager)
                            .environmentObject(bagManager)) {
                            Text("Add Interest")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal)

                    VStack(spacing: 12) {
                        HStack(spacing: 12) {
                            NavigationLink(destination: Chapter_Shop_Screen()
                                .environmentObject(favManager)
                                .environmentObject(bagManager)) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Image("air-jordan1")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 180)
                                        .clipped()
                                        .cornerRadius(12)
                                    Text("Running")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                }
                            }

                            NavigationLink(destination: Chapter_Shop_Screen()
                                .environmentObject(favManager)
                                .environmentObject(bagManager)) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Image("air-jordan1")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 180)
                                        .clipped()
                                        .cornerRadius(12)
                                    Text("Lifestyle")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                }
                            }
                        }

                        HStack(spacing: 12) {
                            NavigationLink(destination: Chapter_Shop_Screen()
                                .environmentObject(favManager)
                                .environmentObject(bagManager)) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Image("air-jordan1")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 180)
                                        .clipped()
                                        .cornerRadius(12)
                                    Text("Basketball")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                }
                            }

                            NavigationLink(destination: Chapter_Shop_Screen()
                                .environmentObject(favManager)
                                .environmentObject(bagManager)) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Image("air-jordan1")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 180)
                                        .clipped()
                                        .cornerRadius(12)
                                    Text("Training")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 8)
            }
            .padding(.vertical)
        }
        .navigationTitle("Home")
    }
}

struct Main_Screen_Previews: PreviewProvider {
    static var previews: some View {
        Main_Screen()
            .previewDevice("iPhone 14 Pro")
    }
}
