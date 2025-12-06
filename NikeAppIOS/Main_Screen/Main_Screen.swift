import SwiftUI

struct Main_Screen: View {
    var body: some View {
        TabView {
            HomeTab()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            ShopScreen()
                .tabItem {
                    Image(systemName: "bag")
                    Text("Shop")
                }

            Text("Favorites")
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }

            Text("Bag")
                .tabItem {
                    Image(systemName: "bag.fill")
                    Text("Bag")
                }

            // <-- Здесь заменили простой Text на твой экран профиля
            ProfileTabView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

struct HomeTab: View {
    let shoes = [
        ("Air Jordan XXXVI", "US$185", "Air_Jordan"),
        ("Air Jordan XXXVII", "US$190", "Air_Jordan2"),
        ("Air Jordan XXXVIII", "US$200", "Air_Jordan3")
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
            }
            .padding(.vertical)
        }
    }
}

struct Main_Screen_Previews: PreviewProvider {
    static var previews: some View {
        Main_Screen()
            .previewDevice("iPhone 14 Pro")
    }
}
