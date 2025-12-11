import SwiftUI

struct Chapter_Shop_Screen: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var favManager = FavoritesManager()

    let interests = [
        "work_nike", "work_nike", "work_nike", "work_nike"
    ]

    let recommended = [
        ("Nike Air Force 1", "US$120", "white_shoes"),
        ("Nike Air Max 90", "US$150", "white_shoes"),
        ("Nike Cortez", "US$95", "white_shoes"),
        ("Nike Air Max 270", "US$160", "white_shoes")
    ]

    let nearbyStores = [
        ("Nike By Flatiron", "1.4mi inside", "store"),
        ("Nike Times Square", "2.1mi inside", "store"),
        ("Nike Downtown", "0.8mi inside", "store"),
        ("Nike Uptown", "3.0mi inside", "store")
    ]

    var body: some View {
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
    private var contentView: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "house.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.black)
                }
                Spacer()
                Text("Shop")
                    .font(.headline)
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18))
                    .foregroundColor(.black)
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            .background(Color(.systemBackground))
            .border(Color(.systemGray5), width: 1)

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .center, spacing: 12) {
                        HStack(spacing: 20) {
                            Image(systemName: "smiley")
                                .font(.system(size: 48))
                                .foregroundColor(.gray)
                            Image(systemName: "bag")
                                .font(.system(size: 48))
                                .foregroundColor(.gray)
                        }
                        Text("Store Locator")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Shop My Interests")
                                .font(.headline)
                                .fontWeight(.semibold)
                            Spacer()
                            NavigationLink(destination: Best_Sellers()
                                .environmentObject(favManager)) {
                                Text("Add Interest")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(interests, id: \.self) { imageName in
                                    Image(imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 180, height: 220)
                                        .clipped()
                                        .cornerRadius(12)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recommended for You")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(recommended, id: \.0) { product in
                                    NavigationLink(destination: Catalog_Shoes()) {
                                        VStack(alignment: .leading, spacing: 8) {
                                            Image(product.2)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 180, height: 220)
                                                .clipped()
                                                .cornerRadius(12)
                                            Text(product.0)
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                            Text(product.1)
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                        .frame(width: 180)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Nearby Stores")
                                .font(.headline)
                                .fontWeight(.semibold)
                            Spacer()
                            NavigationLink(destination: Text("Find a Store")) {
                                Text("Find a Store")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(nearbyStores, id: \.0) { store in
                                    VStack(alignment: .leading, spacing: 8) {
                                        Image(store.2)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 180, height: 220)
                                            .clipped()
                                            .cornerRadius(12)
                                        Text(store.0)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        Text(store.1)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    .frame(width: 180)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical, 16)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Chapter_Shop_Screen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Chapter_Shop_Screen()
        }
        .previewDevice("iPhone 14 Pro")
    }
}
