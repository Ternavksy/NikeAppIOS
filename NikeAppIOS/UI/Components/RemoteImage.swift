import SwiftUI

struct RemoteImage<Content: View>: View {
    let imagePath: String?            // название ассета или относительный путь "/images/..."
    let content: (Image) -> Content   // как рисовать Image (для локальной)
    let placeholder: AnyView
    let failure: AnyView
    let aspectMode: ContentMode
    let height: CGFloat?

    init(
        imagePath: String?,
        aspectMode: ContentMode = .fill,
        height: CGFloat? = nil,
        @ViewBuilder content: @escaping (Image) -> Content = { img in img.resizable() },
        placeholder: AnyView = AnyView(ProgressView()),
        failure: AnyView = AnyView(Color(.systemGray5))
    ) {
        self.imagePath = imagePath
        self.content = content
        self.placeholder = placeholder
        self.failure = failure
        self.aspectMode = aspectMode
        self.height = height
    }

    var body: some View {
        Group {
            if let path = imagePath, !path.isEmpty {
                if path.starts(with: "http://") || path.starts(with: "https://") {
                    // абсолютный URL
                    loadRemote(urlString: path)
                } else if path.starts(with: "/") {
                    // относительный путь от API_BASE_URL
                    let base = AppConfig.apiBaseURL
                    loadRemote(urlString: "\(base)\(path)")
                } else {
                    // локальный ассет
                    content(Image(path))
                        .aspectRatio(contentMode: aspectMode)
                }
            } else {
                failure
            }
        }
        .frame(height: height)
        .clipped()
    }

    @ViewBuilder
    private func loadRemote(urlString: String) -> some View {
        if let url = URL(string: urlString) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    placeholder
                case .success(let image):
                    content(image)
                        .aspectRatio(contentMode: aspectMode)
                case .failure:
                    failure
                @unknown default:
                    failure
                }
            }
        } else {
            failure
        }
    }
}
