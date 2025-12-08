import SwiftUI

struct Main_Screen: View {
    @StateObject var favManager = FavoritesManager()
    var body: some View {
        NavigationStack {
            TabView {
                HomeTab()
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

struct HomeTab: View {
    let shoes = [
        ("Air Jordan XXXVI", "US$185", "Air_Jordan"),
        ("Air Jordan XXXVII", "US$190", "Air_Jordan2"),
        ("Air Jordan XXXVIII", "US$200", "Air_Jordan3")
    ]

    let shopItems = [
        ("Nike Air Force 1", "US$120", "air-force1"),
        ("Nike Air Max 90", "US$150", "air-max90")
    ]

    var body: some View {
        NavigationStack {
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
                                    Image("air-jordan1")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 260, height: 260)
                                        .background(Color(.systemGray6))
                                        .cornerRadius(12)
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

                    // Shop Section
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Shop My Interests")
                                .font(.headline)
                                .fontWeight(.semibold)
                            Spacer()
                            NavigationLink(destination: Chapter_Shop_Screen()) {
                                Text("Add Interest")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal)

                        VStack(spacing: 12) {
                            HStack(spacing: 12) {
                                NavigationLink(destination: Chapter_Shop_Screen()) {
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

                                NavigationLink(destination: Chapter_Shop_Screen()) {
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
                                NavigationLink(destination: Chapter_Shop_Screen()) {
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

                                NavigationLink(destination: Chapter_Shop_Screen()) {
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
        }
    }
}

struct Main_Screen_Previews: PreviewProvider {
    static var previews: some View {
        Main_Screen()
            .previewDevice("iPhone 14 Pro")
    }
}
