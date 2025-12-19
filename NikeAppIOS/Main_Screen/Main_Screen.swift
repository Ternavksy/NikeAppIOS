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

// MARK: - HomeTab

struct HomeTab: View {
    @EnvironmentObject var favManager: FavoritesManager
    @EnvironmentObject var bagManager: BagManager
    @EnvironmentObject var appState: AppState

    let shoes = [
        ("Air Jordan XXXVI", "US$185"),
        ("Air Jordan XXXVII", "US$190"),
        ("Air Jordan XXXVIII", "US$200")
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

                // MARK: Horizontal shoes
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(shoes, id: \.0) { shoe in
                            VStack(alignment: .leading) {
                                NavigationLink(
                                    destination: Best_Sellers()
                                        .environmentObject(favManager)
                                        .environmentObject(bagManager)
                                ) {
                                    RemoteImage(
                                        imagePath: "/images/air-jordan1.png",
                                        height: 260,
                                        failure: AnyView(
                                            Image("air-jordan1")
                                                .resizable()
                                                .scaledToFit()
                                        )
                                    )
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

                // MARK: Ronaldo banner
                RemoteImage(
                    imagePath: "/images/Ronaldo.jpeg",
                    aspectMode: .fit,
                    failure: AnyView(
                        Image("Ronaldo")
                            .resizable()
                            .scaledToFit()
                    )
                )
                .cornerRadius(16)
                .padding(.horizontal)

                // MARK: Interests
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Shop My Interests")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Spacer()
                        NavigationLink(
                            destination: Chapter_Shop_Screen()
                                .environmentObject(favManager)
                                .environmentObject(bagManager)
                        ) {
                            Text("Add Interest")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal)

                    VStack(spacing: 12) {
                        interestsRow(title1: "Running", title2: "Lifestyle")
                        interestsRow(title1: "Basketball", title2: "Training")
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 8)
            }
            .padding(.vertical)
        }
        .navigationTitle("Home")
    }

    // MARK: - Reusable interests row
    private func interestsRow(title1: String, title2: String) -> some View {
        HStack(spacing: 12) {
            interestCard(title: title1)
            interestCard(title: title2)
        }
    }

    private func interestCard(title: String) -> some View {
        NavigationLink(
            destination: Chapter_Shop_Screen()
                .environmentObject(favManager)
                .environmentObject(bagManager)
        ) {
            VStack(alignment: .leading, spacing: 8) {
                RemoteImage(
                    imagePath: "/images/air-jordan1.png",
                    height: 180,
                    failure: AnyView(
                        Image("air-jordan1")
                            .resizable()
                            .scaledToFill()
                    )
                )
                .clipped()
                .cornerRadius(12)

                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
            }
        }
    }
}

// MARK: - Preview
struct Main_Screen_Previews: PreviewProvider {
    static var previews: some View {
        Main_Screen()
            .previewDevice("iPhone 14 Pro")
    }
}
