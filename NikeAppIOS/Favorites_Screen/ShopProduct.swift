import SwiftUI

struct ShopProduct: Identifiable, Equatable {
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
    
    static func == (lhs: ShopProduct, rhs: ShopProduct) -> Bool {
        lhs.title == rhs.title &&
        lhs.subtitle == rhs.subtitle &&
        lhs.price == rhs.price
    }
}

final class BagManager: ObservableObject {
    @Published var items: [ShopProduct] = []
    
    func add(_ product: ShopProduct) {
        items.append(product)
    }
    
    func remove(_ product: ShopProduct) {
        items.removeAll { $0 == product }
    }
}
