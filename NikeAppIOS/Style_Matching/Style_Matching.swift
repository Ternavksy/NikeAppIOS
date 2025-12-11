import SwiftUI

struct Style_Matching: View {
    @StateObject private var favManager = FavoritesManager()
    
    private var contentView: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .medium))
                }

                Spacer()

                Text("Style Matching")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)

                Spacer()

                Button(action: {}) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .regular))
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)
            .padding(.bottom, 6)

            Divider()
            ScrollView {
                LazyVGrid(columns: columns, spacing: 24) {
                    ForEach(shoes.indices, id: \.self) { index in
                        ShoeCard(shoe: $shoes[index])
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 24)
            }
        }
        .navigationBarHidden(true)
    }
        struct Shoe: Identifiable {
        let id = UUID()
        let tag: String?
        let tagColor: Color
        let name: String
        let subtitle: String
        let price: String
        let imageName: String
        var isFavorite: Bool
    }

    @State private var shoes: [Shoe] = [
        Shoe(tag: "Bestseller", tagColor: .orange, name: "Nike Flex Experience Run 10", subtitle: "Women's Road Running Shoes", price: "US$65", imageName: "nike_gray", isFavorite: false),
        Shoe(tag: "Unavailable", tagColor: Color(red: 0.8, green: 0.4, blue: 0.4), name: "Nike Downshifter 11", subtitle: "Men's Road Running Shoes (Extra Wide)", price: "US$54.97", imageName: "nike_gray", isFavorite: false),
        Shoe(tag: "Bestseller", tagColor: .orange, name: "Nike Legend Essential 2", subtitle: "Men's Training Shoes", price: "US$60", imageName: "botinok", isFavorite: false),
        Shoe(tag: "Unavailable", tagColor: Color(red: 0.8, green: 0.4, blue: 0.4), name: "Nike Air Max Bella TR 4", subtitle: "Women's Training Shoes", price: "US$85", imageName: "style_botinok", isFavorite: false)
    ]

    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

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

struct ShoeCard: View {
    @Binding var shoe: Style_Matching.Shoe

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack(alignment: .topTrailing) {
                Rectangle()
                    .fill(Color(.systemGray6))
                    .frame(height: 150)
                    .overlay(
                        Image(shoe.imageName)
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 8)
                            .padding(.top, 12)
                    )
                    .cornerRadius(12)

                Button(action: {
                    shoe.isFavorite.toggle()
                }) {
                    Image(systemName: shoe.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(shoe.isFavorite ? .red : .black)
                        .padding(8)
                }
            }

            if let tag = shoe.tag {
                Text(tag)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(shoe.tagColor)
            }

            Text(shoe.name)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black)
                .lineLimit(2)

            Text(shoe.subtitle)
                .font(.system(size: 12))
                .foregroundColor(.gray)
                .lineLimit(2)

            Text(shoe.price)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.black)
                .padding(.top, 4)
        }
    }
}

struct Style_Matching_Previews: PreviewProvider {
    static var previews: some View {
        Style_Matching()
            .previewDevice("iPhone 14 Pro")
    }
}
