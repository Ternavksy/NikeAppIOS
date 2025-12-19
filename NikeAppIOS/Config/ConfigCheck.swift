import Foundation

struct ConfigCheck {
    static func check() {
        print("API BASE URL:", AppConfig.apiBaseURL)
    }
}
