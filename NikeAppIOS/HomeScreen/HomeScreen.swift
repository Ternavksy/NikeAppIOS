import SwiftUI

struct HomeScreen: View {
    @State private var selectedCategory = "All"

    let categories = ["All", "Men", "Women", "Kids", "Socks", "Accessories & Equipment"]

    // MARK: — Products by Categories
    let allProducts: [Product] = [
        Product(name: "Jordan Essentials",
                image: "man_red",
                price: 60,
                isSoldOut: false,
                details: "Men Fleece Pullover Hoodie · 5 Colours"),

        Product(name: "Jordan Essentials",
                image: "man_bag",
                price: 60,
                isSoldOut: false,
                details: "Men Fleece Pullover · 6 Colours"),

        Product(name: "Jordan Essentials",
                image: "man_black",
                price: 60,
                isSoldOut: false,
                details: "Pullover Hoodie · 4 Colours"),

        Product(name: "Jordan Essentials",
                image: "jeans_blue",
                price: 60,
                isSoldOut: false,
                details: "Men’s Woven Jacket"),
    ]

    let menProducts: [Product] = [
        Product(name: "Nike Men Tee",
                image: "man_bag",
                price: 32,
                isSoldOut: false,
                details: "Sports T-Shirt"),
    ]

    let accessoriesProducts: [Product] = [
        Product(name: "Nike Elite Pro",
                image: "man_bag",
                price: 85,
                isSoldOut: true,
                details: "Basketball Backpack (32L) · 3 Colours"),

        Product(name: "Nike Heritage",
                image: "heritage",
                price: 40.97,
                isSoldOut: true,
                details: "Backpack (32L) · 4 Colours"),

        Product(name: "Air Jordan",
                image: "bag",
                price: 95,
                isSoldOut: true,
                details: "Basketball Backpack"),

        Product(name: "Nike Crossbody",
                image: "nike_bag",
                price: 32,
                isSoldOut: true,
                details: "Crossbody Bag"),
    ]

    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    // MARK: — Filter Logic
    var filteredProducts: [Product] {
        switch selectedCategory {
        case "All": return allProducts
        case "Men": return menProducts
        case "Accessories & Equipment": return accessoriesProducts
        default: return []
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {

                // MARK: — Top Navbar
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                    Spacer()
                    Text("Jordan Flight Essentials")
                        .font(.headline)
                    Spacer()
                    HStack(spacing: 16) {
                        Image(systemName: "plus.square")
                        Image(systemName: "magnifyingglass")
                    }
                    .font(.title3)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)

                Divider()

                // MARK: — Category Tabs
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 24) {
                        ForEach(categories, id: \.self) { cat in
                            VStack(spacing: 4) {
                                Text(cat)
                                    .foregroundColor(cat == selectedCategory ? .black : .gray)
                                    .fontWeight(cat == selectedCategory ? .semibold : .regular)

                                if cat == selectedCategory {
                                    Rectangle()
                                        .frame(height: 2)
                                        .foregroundColor(.black)
                                } else {
                                    Color.clear.frame(height: 2)
                                }
                            }
                            .onTapGesture {
                                selectedCategory = cat
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }

                Divider()

                // MARK: — Products Grid
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(filteredProducts) { product in
                            ProductCard(product: product)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct ProductCard: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {

            ZStack(alignment: .topTrailing) {
                Image(product.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(4)

                Button(action: {}) {
                    Image(systemName: "heart")
                        .padding(8)
                        .background(Color.white.opacity(0.9))
                        .clipShape(Circle())
                }
                .padding(6)
            }

            if product.isSoldOut {
                Text("Sold Out")
                    .font(.caption)
                    .foregroundColor(.orange)
                    .padding(.top, 2)
            }

            Text(product.name)
                .font(.headline)

            Text(product.details)
                .font(.caption)
                .foregroundColor(.gray)

            Text("US$\(String(format: "%.2f", product.price))")
                .font(.headline)
                .padding(.top, 4)
        }
    }
}

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let price: Double
    let isSoldOut: Bool
    let details: String
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .previewDevice("iPhone 14 Pro")
    }
}
