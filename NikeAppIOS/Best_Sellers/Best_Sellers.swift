import SwiftUI
import UIKit

struct Best_Sellers: View {
    @StateObject private var favManager = FavoritesManager()
    @StateObject private var bagManager = BagManager()
    
    @State private var selectedCategory = "Clothes"
    
    @State private var productFrames: [UUID: CGRect] = [:]
    struct ProductFrameKey: PreferenceKey {
        static var defaultValue: [UUID: CGRect] = [:]
        static func reduce(value: inout [UUID: CGRect], nextValue: () -> [UUID: CGRect]) {
            value.merge(nextValue(), uniquingKeysWith: { $1 })
        }
    }
    
    @State private var flyingImageName: String? = nil
    @State private var flyingVisible: Bool = false
    @State private var flyingPosition: CGPoint = .zero
    @State private var flyingSize: CGSize = .zero
    @State private var flyingScale: CGFloat = 1.0
    @State private var flyingOpacity: Double = 1.0
    
    private let flightDuration: Double = 0.8
    private let fadeDuration: Double = 0.18
    
    let categories = ["Clothes", "Socks", "Accessories & Equipment"]
    
    let allProducts: [ShopProduct] = [
        ShopProduct(title: "Nike Therma",
                    subtitle: "Men's Pullover Training Hoodie",
                    price: "US$33.97",
                    image: "therma-mens"),
        
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
                    image: "therma-mens"),
        
        ShopProduct(title: "Nike Sportwear Club Fleece",
                    subtitle: "Men's Pants",
                    price: "US$33.97",
                    image: "air-jordan1"),
        
        ShopProduct(title: "Nike Sportswear Club",
                    subtitle: "Men's",
                    price: "US$33.97",
                    image: "orange"),
        
        ShopProduct(title: "Nike Dri-FIT Miler",
                    subtitle: "Men's",
                    price: "US$33.97",
                    image: "raz-raz")
    ]
    
    let socksProducts: [ShopProduct] = [
        ShopProduct(title: "Nike Elite Socks",
                    subtitle: "Crew Length",
                    price: "US$14.97",
                    image: "air-jordan1"),
        
        ShopProduct(title: "Nike Cushioned Socks",
                    subtitle: "Ankle Height",
                    price: "US$12.97",
                    image: "raz-raz")
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
    
    // MARK: - Helpers to find UITabBar and its item frame
    private func findTabBar() -> UITabBar? {
        let scenes = UIApplication.shared.connectedScenes
        for scene in scenes {
            if let windowScene = scene as? UIWindowScene {
                for window in windowScene.windows {
                    if let tabBar = findTabBar(in: window) {
                        return tabBar
                    }
                }
            }
        }
        return nil
    }
    private func findTabBar(in view: UIView) -> UITabBar? {
        if let tb = view as? UITabBar { return tb }
        for sub in view.subviews {
            if let found = findTabBar(in: sub) { return found }
        }
        return nil
    }
    private func frameForTabBarItem(index: Int) -> CGRect? {
        guard let tabBar = findTabBar() else { return nil }
        let buttons = tabBar.subviews
            .filter { $0 is UIControl }
            .sorted { $0.frame.minX < $1.frame.minX }
        guard index >= 0 && index < buttons.count else { return nil }
        let button = buttons[index]
        if let window = button.window {
            return button.convert(button.bounds, to: window)
        } else if let rootWindow = UIApplication.shared.windows.first {
            return button.convert(button.bounds, to: rootWindow)
        } else {
            return nil
        }
    }
    
    // MARK: - Start flight animation
    private func startFlyToBag(product: ShopProduct) {
        guard let startFrame = productFrames[product.id] else {
            bagManager.add(product)
            return
        }
        
        let startCenter = CGPoint(x: startFrame.midX, y: startFrame.midY)
        let startSize = CGSize(width: startFrame.width, height: startFrame.height)
        
        let bagIndex = 3
        let targetFrame = frameForTabBarItem(index: bagIndex)
        
        flyingImageName = product.image
        flyingSize = startSize
        flyingPosition = startCenter
        flyingScale = 1.0
        flyingOpacity = 1.0
        flyingVisible = true
        let targetCenter: CGPoint
        let finalScale: CGFloat
        if let t = targetFrame {
            targetCenter = CGPoint(x: t.midX, y: t.midY)
            let targetWidth: CGFloat = min(t.width * 0.6, 28)
            finalScale = (targetWidth / startSize.width).clamped(to: 0.06...1.0)
        } else {
            let screen = UIScreen.main.bounds
            targetCenter = CGPoint(x: screen.maxX - 48, y: screen.maxY - 48)
            finalScale = 0.15
        }
        withAnimation(.interpolatingSpring(stiffness: 220, damping: 22).speed(1.0)) {
            flyingPosition = targetCenter
            flyingScale = finalScale
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + flightDuration) {
            withAnimation(.easeOut(duration: fadeDuration)) {
                flyingOpacity = 0.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + fadeDuration * 0.6) {
                bagManager.add(product)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + fadeDuration + 0.06) {
                flyingVisible = false
                flyingImageName = nil
            }
        }
    }
    
    // MARK: - Content
    private var contentView: some View {
        ZStack {
            VStack(spacing: 0) {
                // MARK: — Top Navbar
                HStack {
                    Button(action: {
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
                                    Button {
                                        startFlyToBag(product: product)
                                    } label: {
                                        Image(product.image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(height: 200)
                                            .frame(maxWidth: .infinity)
                                            .background(Color(.systemGray6))
                                            .cornerRadius(12)
                                            .background(
                                                GeometryReader { geo -> Color in
                                                    let frame = geo.frame(in: .global)
                                                    DispatchQueue.main.async {
                                                        productFrames[product.id] = frame
                                                    }
                                                    return Color.clear
                                                }
                                            )
                                    }
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
            
            // MARK: - Flying image overlay (absolute coords)
            if flyingVisible, let imgName = flyingImageName {
                GeometryReader { fullGeo in
                    let localPoint = CGPoint(x: flyingPosition.x - fullGeo.frame(in: .global).minX,
                    y: flyingPosition.y - fullGeo.frame(in: .global).minY)
                    
                    Image(imgName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: flyingSize.width, height: flyingSize.height)
                        .clipped()
                        .cornerRadius(12)
                        .scaleEffect(flyingScale)
                        .opacity(flyingOpacity)
                        .position(localPoint)
                        .shadow(radius: 6)
                        .allowsHitTesting(false)
                }
                .edgesIgnoringSafeArea(.all)
                .transition(.opacity)
                .zIndex(999)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            }
        }
    }
    
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
                
                BagScreen()
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
            .environmentObject(bagManager)
            .navigationBarHidden(true)
        }
    }
}

fileprivate extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}

struct Best_Sellers_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Best_Sellers()
        }
        .previewDevice("iPhone 14 Pro")
    }
}
