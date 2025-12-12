import SwiftUI

struct Eight_Screen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedSize: String? = "11"
    @State private var showNine = false
    
    private let sizes: [String] = [
        "4","4.5","5","5.5",
        "6","6.5","7","7.5",
        "8","8.5","9","9.5",
        "10","10.5","11","11.5",
        "12","12.5","13","13.5",
        "14","14.5","15","16",
        "17","18"
    ]

    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 16), count: 4)

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(.black), Color(.sRGB, white: 0.08, opacity: 1.0)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                // Кнопка назад
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.black.opacity(0.3))
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 50)

                ProgressView(value: 0.38) {
                    EmptyView()
                }
                .progressViewStyle(LinearProgressViewStyle(tint: Color.white.opacity(0.9)))
                .frame(width: 150, height: 6)
                .padding(.leading, 25)
                .padding(.trailing, 12)

                Text("What's your shoe size?")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)

                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(sizes, id: \.self) { size in
                            SizeButton(size: size, isSelected: size == selectedSize) {
                                withAnimation(.spring()) {
                                    selectedSize = size
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                    .padding(.bottom, 40)
                }

                Spacer()

                Button(action: {
                    showNine = true
                }) {
                    Text("Next")
                        .font(.system(size: 18, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            Capsule()
                                .fill(Color.white)
                        )
                        .foregroundColor(.black)
                        .padding(.horizontal, 80)
                }
                .padding(.bottom, 28)
                .sheet(isPresented: $showNine) {
                    Nine_Screen()
                }
            }
        }
        // КРИТИЧЕСКИ ВАЖНО - эти модификаторы убирают таббар
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .ignoresSafeArea(.keyboard)
    }
}

private struct SizeButton: View {
    let size: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(size)
                .font(.system(size: 16, weight: .semibold))
                .frame(maxWidth: .infinity, minHeight: 56)
                .background(
                    ZStack {
                        if isSelected {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white)
                        } else {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(.sRGB, white: 0.14, opacity: 0.9))
                        }
                    }
                )
                .foregroundColor(isSelected ? .black : Color.white.opacity(0.95))
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct Eight_Screen_Previews: PreviewProvider {
    static var previews: some View {
        Eight_Screen()
            .previewDevice("iPhone 14 Pro")
    }
}
