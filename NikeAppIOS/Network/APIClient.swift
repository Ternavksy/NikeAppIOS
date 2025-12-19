import Foundation

final class APIClient {

    static let shared = APIClient()
    private init() {}

    func fetchProducts(completion: @escaping ([ProductAPI]) -> Void) {
        guard let url = URL(string: "\(AppConfig.apiBaseURL)\(Endpoints.products)") else {
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard
                let data,
                error == nil,
                let products = try? JSONDecoder().decode([ProductAPI].self, from: data)
            else {
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }

            DispatchQueue.main.async {
                completion(products)
            }
        }
        .resume()
    }
}
