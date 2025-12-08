import SwiftUI

struct Best_Sellers: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var favManager: FavoritesManager
    @State private var selectedCategory = "Clothes"
    
    let categories = ["Clothes", "Socks", "Accessories & Equipment"]
    
    let allProducts: [ShopProduct] = [
        ShopProduct(title: "Nike Therma",
                   subtitle: "Men's Pullover Training Hoodie",
                   price: "US$33.97",
                   image: "air-jordan1"),
        
        ShopProduct(title: "Nike Sportwear Club Fleece",
                   subtitle: "Men's Pants",
                   price: "US$33.97",
                   image: "air-jordan1"),
        
        ShopProduct(title: "Nike Sportswear Club",
                   subtitle: "Men's",
                   price: "US$33.97",
                   image: "air-jordan1"),
        
        ShopProduct(title: "Nike Dri-FIT Miler",
                   subtitle: "Men's",
                   price: "US$33.97",
                   image: "air-jordan1")
    ]
    
    let clothesProducts: [ShopProduct] = [
        ShopProduct(title: "Nike Therma",
                   subtitle: "Men's Pullover Training Hoodie",
                   price: "US$33.97",
                   image: "air-jordan1"),
        
        ShopProduct(title: "Nike Sportwear Club Fleece",
                   subtitle: "Men's Pants",
                   price: "US$33.97",
                   image: "air-jordan1"),
        
        ShopProduct(title: "Nike Sportswear Club",
                   subtitle: "Men's",
                   price: "US$33.97",
                   image: "air-jordan1"),
        
        ShopProduct(title: "Nike Dri-FIT Miler",
                   subtitle: "Men's",
                   price: "US$33.97",
                   image: "air-jordan1")
    ]
    
    let socksProducts: [ShopProduct] = [
        ShopProduct(title: "Nike Elite Socks",
                   subtitle: "Crew Length",
                   price: "US$14.97",
                   image: "air-jordan1"),
        
        ShopProduct(title: "Nike Cushioned Socks",
                   subtitle: "Ankle Height",
                   price: "US$12.97",
                   image: "air-jordan1")
    ]
    
    let accessoriesProducts: [ShopProduct] = [
        ShopProduct(title: "Nike Elite Pro",
                   subtitle: "Basketball Backpack",
                   price: "US$85.00",
                   image: "air-jordan1"),
        
        ShopProduct(title: "Nike Heritage Backpack",
                   subtitle: "Everyday Carry",
                   price: "US$40.97",
                   image: "air-jordan1")
    ]
    
    var filteredProducts: [ShopProduct] {
        switch selectedCategory {
        case "Clothes":
            return clothesProducts
        case "Socks":
            return socksProducts
        case "Accessories & Equipment":
            return accessoriesProducts
        default:
            return allProducts
        }
    }

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // MARK: — Top Navbar
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Text("Best Sellers")
                        .font(.headline)
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        Image(systemName: "plus")
                            .font(.system(size: 18))
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 18))
                    }
                    .foregroundColor(.black)
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
                
                Divider()
                
                // MARK: — Category Tabs
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 24) {
                        ForEach(categories, id: \.self) { cat in
                            VStack(spacing: 4) {
                                Text(cat)
                                    .foregroundColor(cat == selectedCategory ? .black : .gray)
                                    .fontWeight(cat == selectedCategory ? .semibold : .regular)
                                    .font(.subheadline)

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
                    .padding(.vertical, 8)
                }
                
                Divider()
                
                // MARK: — Products Grid
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()),
                                      GridItem(.flexible())],
                             spacing: 24) {
                        ForEach(filteredProducts) { product in
                            VStack(alignment: .leading, spacing: 6) {
                                ZStack(alignment: .topTrailing) {
                                    Image(product.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 200)
                                        .frame(maxWidth: .infinity)
                                        .background(Color(.systemGray6))
                                        .cornerRadius(12)
                                    
                                    Button(action: {
                                        favManager.toggle(product)
                                    }) {
                                        Image(systemName: favManager.isFavorite(product) ? "heart.fill" : "heart")
                                            .foregroundColor(favManager.isFavorite(product) ? .red : .black)
                                            .scaleEffect(favManager.isFavorite(product) ? 1.1 : 1.0)
                                            .padding(10)
                                            .background(Color.white.opacity(0.9))
                                            .clipShape(Circle())
                                            .padding(8)
                                    }
                                }
                                
                                Text("Bestseller")
                                    .font(.caption)
                                    .foregroundColor(.orange)
                                
                                Text(product.title)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                
                                Text(product.subtitle)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                                
                                Text(product.price)
                                    .font(.caption)
                                    .foregroundColor(.black)
                            }
                            .padding(.horizontal, 4)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    .padding(.bottom, 100)
                }
            }
            
            // MARK: — Bottom TabBar
            VStack {
                Spacer()
                
                VStack(spacing: 0) {
                    Divider()
                    
                    HStack(spacing: 0) {
                        TabBarItemView(icon: "house.fill", label: "Home", action: {
                            presentationMode.wrappedValue.dismiss()
                        })
                        
                        TabBarItemView(icon: "square.grid.2x2", label: "Shop", action: {})
                        
                        TabBarItemView(icon: "heart", label: "Favorites", action: {})
                        
                        TabBarItemView(icon: "bag", label: "Bag", action: {})
                        
                        TabBarItemView(icon: "person", label: "Profile", action: {})
                    }
                    .frame(height: 60)
                    .background(Color.white)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct Best_Sellers_Previews: PreviewProvider {
    static var previews: some View {
        Best_Sellers()
            .environmentObject(FavoritesManager())
    }
}
