import Foundation

enum AppConfig {

    static var apiBaseURL: String {
        guard let value = Bundle.main.object(
            forInfoDictionaryKey: "API_BASE_URL"
        ) as? String else {
            fatalError("❌ API_BASE_URL not set in Info.plist")
        }
        return value
    }
}
