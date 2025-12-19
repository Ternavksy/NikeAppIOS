import SwiftUI

// MARK: - Top-level Tabbed ShopScreen
struct ShopScreen: View {
    @EnvironmentObject var favManager: FavoritesManager
    @EnvironmentObject var bagManager: BagManager
    @EnvironmentObject var appState: AppState

    var body: some View {
        TabView {
            NavigationStack {
                HomeTab()
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }

            NavigationStack {
                ShopContent()
            }
            .tabItem {
                Image(systemName: "bag")
                Text("Shop")
            }

            NavigationStack {
                FavoritesScreen()
            }
            .tabItem {
                Image(systemName: "heart")
                Text("Favorites")
            }

            NavigationStack {
                BagScreen()
            }
            .tabItem {
                Image(systemName: "bag.fill")
                Text("Bag")
            }

            NavigationStack {
                ProfileTabView()
            }
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Shop Content
struct ShopContent: View {

    @State private var selectedTab = 0
    let tabs = ["Men", "Women", "Kids"]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {

                // MARK: Tabs
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 28) {
                        ForEach(tabs.indices, id: \.self) { index in
                            VStack {
                                Text(tabs[index])
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(
                                        selectedTab == index ? .black : .gray
                                    )

                                Rectangle()
                                    .fill(selectedTab == index ? .black : .clear)
                                    .frame(height: 2)
                                    .frame(width: 40)
                            }
                            .onTapGesture {
                                selectedTab = index
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }

                // MARK: Section 1
                VStack(alignment: .leading, spacing: 12) {

                    Text("Must-Haves, Best Sellers & More")
                        .font(.system(size: 22, weight: .bold))
                        .padding(.horizontal)

                    HStack(spacing: 12) {

                        // LEFT CARD
                        VStack(alignment: .leading, spacing: 8) {
                            NavigationLink(destination: Eight_Screen()) {
                                RemoteImage(
                                    imagePath: "/images/image 18.png",
                                    aspectMode: .fill,
                                    height: 200,
                                    failure: AnyView(
                                        Image("image 18")
                                            .resizable()
                                            .scaledToFill()
                                    )
                                )
                                .frame(
                                    width: UIScreen.main.bounds.width / 2 - 22,
                                    height: 200
                                )
                                .clipped()
                                .cornerRadius(10)
                            }
                            .buttonStyle(PlainButtonStyle())

                            Text("Best Sellers")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }

                        // RIGHT CARD
                        VStack(alignment: .leading, spacing: 8) {
                            NavigationLink(destination: Eight_Screen()) {
                                RemoteImage(
                                    imagePath: "/images/image 19.png",
                                    aspectMode: .fill,
                                    height: 200,
                                    failure: AnyView(
                                        Image("image 19")
                                            .resizable()
                                            .scaledToFill()
                                    )
                                )
                                .frame(
                                    width: UIScreen.main.bounds.width / 2 - 22,
                                    height: 200
                                )
                                .clipped()
                                .cornerRadius(10)
                            }
                            .buttonStyle(PlainButtonStyle())

                            Text("Featured in Nike Air")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)
                }

                // MARK: Section 2
                VStack(alignment: .leading, spacing: 12) {
                    ZStack(alignment: .bottomLeading) {
                        RemoteImage(
                            imagePath: "/images/nikeee.png",
                            aspectMode: .fill,
                            height: 111,
                            failure: AnyView(
                                Image("nikeee")
                                    .resizable()
                                    .scaledToFill()
                            )
                        )
                        .frame(width: 335, height: 111)
                        .clipped()
                        .cornerRadius(10)

                        Text("New & Featured")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                    }
                    .padding(.horizontal)
                }

                // MARK: Section 3
                VStack(alignment: .leading, spacing: 12) {
                    ZStack(alignment: .bottomLeading) {
                        RemoteImage(
                            imagePath: "/images/pacani.png",
                            aspectMode: .fill,
                            height: 111,
                            failure: AnyView(
                                Image("pacani")
                                    .resizable()
                                    .scaledToFill()
                            )
                        )
                        .frame(width: 335, height: 111)
                        .clipped()
                        .cornerRadius(10)

                        Text("Shoes")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                    }
                    .padding(.horizontal)
                }

                Spacer(minLength: 40)
            }
        }
        .navigationTitle("Shop")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
            }
        }
    }
}

// MARK: - Preview
struct ShopScreen_Previews: PreviewProvider {
    static var previews: some View {
        ShopScreen()
            .previewDevice("iPhone 14 Pro")
    }
}
