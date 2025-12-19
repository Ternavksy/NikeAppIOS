import Foundation

final class ProductsViewModel: ObservableObject {
    @Published var products: [ShopProduct] = []

    func load() {
        APIClient.shared.fetchProducts { apiProducts in
            self.products = apiProducts.map { api in
                ShopProduct(
                    title: api.title,
                    subtitle: "",
                    price: api.price,
                    image: api.image_url   // ← ВАЖНО: путь с бэка
                )
            }
        }
    }
}
