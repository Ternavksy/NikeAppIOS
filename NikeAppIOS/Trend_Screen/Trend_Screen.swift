import SwiftUI

struct TrendItem: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    var isSelected: Bool = false
}

struct Trend_Screen: View {

    @State private var items: [TrendItem] = [
        .init(title: "Baseball",      imageName: "Baseball"),
        .init(title: "Big & Tall",    imageName: "Tall"),
        .init(title: "Cross-Training",imageName: "Cross-Training"),
        .init(title: "Dance",         imageName: "Dance"),
        .init(title: "Lacrosse",      imageName: "Lacrosse"),
        .init(title: "Maternity",     imageName: "Maternity"),
        .init(title: "N7",            imageName: "N7"),
        .init(title: "Nike Sportswear", imageName: "Sportswear")
    ]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Rectangle()
                    .fill(Color.white.opacity(0.8))
                    .frame(height: 3)
                    .padding(.horizontal, 80)
                    .padding(.top, 12)
                List {
                    ForEach(items.indices, id: \.self) { index in
                        TrendRow(
                            title: items[index].title,
                            imageName: items[index].imageName,
                            isSelected: items[index].isSelected
                        )
                        .listRowBackground(Color.black)
                        .onTapGesture {
                            items[index].isSelected.toggle()
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
                Button(action: {
                }) {
                    Text("Next")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: 200)
                        .padding(.vertical, 14)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
                .padding(.bottom, 20)
            }
        }
    }
}

struct TrendRow: View {
    let title: String
    let imageName: String
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 16) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 54, height: 54)
                .clipShape(Circle())
                .clipped()

            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .semibold))

            Spacer()

            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.7), lineWidth: 2)
                    .frame(width: 26, height: 26)

                if isSelected {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 16, height: 16)
                }
            }
        }
        .padding(.vertical, 10)
        .background(Color.black)
    }
}

struct Trend_Screen_Previews: PreviewProvider {
    static var previews: some View {
        Trend_Screen()
            .previewDevice("iPhone 14 Pro")
    }
}

