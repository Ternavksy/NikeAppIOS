import SwiftUI
import UIKit

struct Best_Sellers: View {
    @EnvironmentObject var favManager: FavoritesManager
    @EnvironmentObject var bagManager: BagManager
    
    @Environment(\.dismiss) private var dismiss

    @State private var selectedCategory = "Clothes"
    
    @State private var productFrames: [UUID: CGRect] = [:]

    @State private var flyingImagePath: String? = nil
    @State private var flyingVisible: Bool = false
    @State private var flyingPosition: CGPoint = .zero
    @State private var flyingSize: CGSize = .zero
    @State private var flyingScale: CGFloat = 1.0
    @State private var flyingOpacity: Double = 1.0
    
    private let flightDuration: Double = 0.8
    private let fadeDuration: Double = 0.18
    
    let categories = ["Clothes", "Socks", "Accessories & Equipment"]
    
    // MARK: - Products (image = backend path)
    let allProducts: [ShopProduct] = [
        ShopProduct(
            title: "Nike Therma",
            subtitle: "Men's Pullover Training Hoodie",
            price: "US$33.97",
            image: "/images/therma-mens.png"
        ),
        ShopProduct(
            title: "Nike Sportwear Club Fleece",
            subtitle: "Men's Pants",
            price: "US$33.97",
            image: "/images/air-jordan1.png"
        ),
        ShopProduct(
            title: "Nike Sportwear Club",
            subtitle: "Men's",
            price: "US$33.97",
            image: "/images/air-jordan1.png"
        ),
        ShopProduct(
            title: "Nike Dri-FIT Miler",
            subtitle: "Men's",
            price: "US$33.97",
            image: "/images/air-jordan1.png"
        )
    ]
    
    let clothesProducts: [ShopProduct] = [
        ShopProduct(
            title: "Nike Therma",
            subtitle: "Men's Pullover Training Hoodie",
            price: "US$33.97",
            image: "/images/therma-mens.png"
        ),
        ShopProduct(
            title: "Nike Sportwear Club Fleece",
            subtitle: "Men's Pants",
            price: "US$33.97",
            image: "/images/air-jordan1.png"
        ),
        ShopProduct(
            title: "Nike Sportwear Club",
            subtitle: "Men's",
            price: "US$33.97",
            image: "/images/orange.png"
        ),
        ShopProduct(
            title: "Nike Dri-FIT Miler",
            subtitle: "Men's",
            price: "US$33.97",
            image: "/images/raz-raz.png"
        )
    ]
    
    let socksProducts: [ShopProduct] = [
        ShopProduct(
            title: "Nike Elite Socks",
            subtitle: "Crew Length",
            price: "US$14.97",
            image: "/images/air-jordan1.png"
        ),
        ShopProduct(
            title: "Nike Cushioned Socks",
            subtitle: "Ankle Height",
            price: "US$12.97",
            image: "/images/raz-raz.png"
        )
    ]
    
    let accessoriesProducts: [ShopProduct] = [
        ShopProduct(
            title: "Nike Elite Pro",
            subtitle: "Basketball Backpack",
            price: "US$85.00",
            image: "/images/air-jordan1.png"
        ),
        ShopProduct(
            title: "Nike Heritage Backpack",
            subtitle: "Everyday Carry",
            price: "US$40.97",
            image: "/images/air-jordan1.png"
        )
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
    
    // MARK: - Fly to bag animation
    private func startFlyToBag(product: ShopProduct) {
        guard let startFrame = productFrames[product.id] else {
            bagManager.add(product)
            return
        }
        
        flyingImagePath = product.image
        flyingSize = startFrame.size
        flyingPosition = CGPoint(x: startFrame.midX, y: startFrame.midY)
        flyingScale = 1.0
        flyingOpacity = 1.0
        flyingVisible = true
        
        let screen = UIScreen.main.bounds
        let targetCenter = CGPoint(x: screen.maxX - 48, y: screen.maxY - 48)
        
        withAnimation(.interpolatingSpring(stiffness: 220, damping: 22)) {
            flyingPosition = targetCenter
            flyingScale = 0.15
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + flightDuration) {
            withAnimation(.easeOut(duration: self.fadeDuration)) {
                self.flyingOpacity = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + self.fadeDuration * 0.6) {
                self.bagManager.add(product)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + self.fadeDuration + 0.06) {
                self.flyingVisible = false
                self.flyingImagePath = nil
            }
        }
    }
    
    // MARK: - View
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                // MARK: Top Bar
                HStack {
                    Button { dismiss() } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                    }
                    
                    Spacer()
                    
                    Text("Best Sellers")
                        .font(.headline)
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        Image(systemName: "plus")
                        Image(systemName: "square.and.arrow.up")
                    }
                }
                .padding()
                
                Divider()
                
                // MARK: Categories
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 24) {
                        ForEach(categories, id: \.self) { cat in
                            VStack {
                                Text(cat)
                                    .foregroundColor(cat == selectedCategory ? .black : .gray)
                                    .fontWeight(cat == selectedCategory ? .semibold : .regular)
                                
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundColor(cat == selectedCategory ? .black : .clear)
                            }
                            .onTapGesture { selectedCategory = cat }
                        }
                    }
                    .padding()
                }
                
                Divider()
                
                // MARK: Products Grid
                ScrollView {
                    LazyVGrid(
                        columns: [GridItem(.flexible()), GridItem(.flexible())],
                        spacing: 24
                    ) {
                        ForEach(filteredProducts) { product in
                            VStack(alignment: .leading, spacing: 6) {
                                ZStack(alignment: .topTrailing) {
                                    Button {
                                        startFlyToBag(product: product)
                                    } label: {
                                        RemoteImage(
                                            imagePath: product.image,
                                            aspectMode: .fill,
                                            height: 200,
                                            failure: AnyView(
                                                Image("air-jordan1")
                                                    .resizable()
                                                    .scaledToFill()
                                            )
                                        )
                                        .frame(height: 200)
                                        .frame(maxWidth: .infinity)
                                        .cornerRadius(12)
                                        .background(
                                            GeometryReader { geo in
                                                Color.clear.onAppear {
                                                    productFrames[product.id] = geo.frame(in: .global)
                                                }
                                            }
                                        )
                                    }
                                    
                                    Button {
                                        favManager.toggle(product)
                                    } label: {
                                        Image(systemName: favManager.isFavorite(product) ? "heart.fill" : "heart")
                                            .foregroundColor(favManager.isFavorite(product) ? .red : .black)
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
                                
                                Text(product.subtitle)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                                
                                Text(product.price)
                                    .font(.caption)
                            }
                        }
                    }
                    .padding()
                    .padding(.bottom, 100)
                }
            }
            
            // MARK: Flying image
            if flyingVisible, let path = flyingImagePath {
                GeometryReader { geo in
                    RemoteImage(
                        imagePath: path,
                        aspectMode: .fill,
                        failure: AnyView(
                            Image("air-jordan1")
                                .resizable()
                                .scaledToFill()
                        )
                    )
                    .frame(width: flyingSize.width, height: flyingSize.height)
                    .cornerRadius(12)
                    .scaleEffect(flyingScale)
                    .opacity(flyingOpacity)
                    .position(
                        x: flyingPosition.x - geo.frame(in: .global).minX,
                        y: flyingPosition.y - geo.frame(in: .global).minY
                    )
                    .shadow(radius: 6)
                }
                .ignoresSafeArea()
                .zIndex(999)
            }
        }
        .navigationBarHidden(true)
    }
}

struct Best_Sellers_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Best_Sellers()
                .environmentObject(FavoritesManager())
                .environmentObject(BagManager())
        }
    }
}
