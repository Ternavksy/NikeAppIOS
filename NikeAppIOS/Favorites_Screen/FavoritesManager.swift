import SwiftUI

struct FavoriteItem: Identifiable, Codable, Equatable {
    let id: UUID
    let title: String
    let subtitle: String
    let price: String
    let image: String
   
    init(id: UUID = UUID(), title: String, subtitle: String, price: String, image: String) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.price = price
        self.image = image
    }
}

class FavoritesManager: ObservableObject {
    @Published var favorites: [FavoriteItem] = []
    private let favoritesKey = "favorites"
   
    init() {
        loadFavorites()
    }
   
    func toggle(_ product: ShopProduct) {
        print("🔄 Toggle: \(product.title) - \(product.subtitle)")
        if isFavorite(product) {
            removeFavorite(product)
        } else {
            addFavorite(product)
        }
        print("📊 Favorites count: \(favorites.count)")
    }
   
    func isFavorite(_ product: ShopProduct) -> Bool {
        favorites.contains { favorite in
            favorite.title == product.title &&
            favorite.subtitle == product.subtitle &&
            favorite.price == product.price
        }
    }
   
    func removeFavoriteItem(_ item: FavoriteItem) {
        favorites.removeAll { $0.id == item.id }
        saveFavorites()
        print("❌ Removed favorite: \(item.title)")
    }
   
    private func addFavorite(_ product: ShopProduct) {
        let favorite = FavoriteItem(
            title: product.title,
            subtitle: product.subtitle,
            price: product.price,
            image: product.image
        )
       
        // Исправлено: добавлено сравнение по price для consistency
        favorites.removeAll { $0.title == product.title && $0.subtitle == product.subtitle && $0.price == product.price }
        favorites.append(favorite)
        print("✅ Added: \(product.title)")
        saveFavorites()
    }
   
    private func removeFavorite(_ product: ShopProduct) {
        let initialCount = favorites.count
        favorites.removeAll { favorite in
            favorite.title == product.title &&
            favorite.subtitle == product.subtitle &&
            favorite.price == product.price
        }
        if favorites.count < initialCount {
            print("❌ Removed: \(product.title)")
        }
        saveFavorites()
    }
   
    private func saveFavorites() {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: favoritesKey)
            print("💾 Favorites saved. Total: \(favorites.count)")
        }
    }
   
    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: favoritesKey),
           let saved = try? JSONDecoder().decode([FavoriteItem].self, from: data) {
            self.favorites = saved
            print("📂 Loaded \(favorites.count) favorites")
        } else {
            print("📂 No saved favorites found")
            self.favorites = []
        }
    }
   
    func clearAllFavorites() {
        favorites.removeAll()
        UserDefaults.standard.removeObject(forKey: favoritesKey)
        print("🗑️ All favorites cleared")
    }
}
