import SwiftUI

struct FifthScreen: View {
    @State private var currentPage: Int = 0
    private let pages = 2
    
    @State private var selectedId: UUID? = nil
    @State private var showShopScreen = false // Добавлено для навигации
    
    private var items: [Option] = [
        Option(title: "Mens", imageName: "Mens"),
        Option(title: "Womens", imageName: "Womens"),
        Option(title: "Boys", imageName: "boys"),
        Option(title: "Girls", imageName: "Girls"),
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                LinearGradient(
                    colors: [Color.black.opacity(0.65), Color.black.opacity(0.35)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    VStack {
                        Spacer().frame(height: 14)
                        ZStack(alignment: .leading) {
                            Capsule()
                                .frame(width: UIScreen.main.bounds.width * 0.44, height: 6)
                                .foregroundColor(Color.white.opacity(0.18))
                            Capsule()
                                .frame(
                                    width: (UIScreen.main.bounds.width * 0.44) * (CGFloat(currentPage + 1) / CGFloat(pages)),
                                    height: 6
                                )
                                .foregroundColor(.white)
                                .animation(.easeInOut(duration: 0.25), value: currentPage)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 20)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("First up, which")
                        Text("products do you use")
                        Text("the most")
                    }
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .offset(x: -30)
                    .padding(.bottom, 30)
                    
                    VStack(spacing: 0) {
                        OptionRow(
                            option: items[0],
                            isSelected: selectedId == items[0].id,
                            onTap: { handleOptionTap(items[0]) }
                        )
                        .padding(.horizontal, 18)
                        .padding(.vertical, 18)
                        
                        Divider()
                            .background(Color.white.opacity(0.08))
                            .padding(.leading, 18)
                        
                        OptionRow(
                            option: items[1],
                            isSelected: selectedId == items[1].id,
                            onTap: { handleOptionTap(items[1]) }
                        )
                        .padding(.horizontal, 18)
                        .padding(.vertical, 18)
                        
                        Divider()
                            .background(Color.white.opacity(0.08))
                            .padding(.leading, 18)
                        
                        HStack {
                            Text("Any others?")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color.white.opacity(0.6))
                            Spacer()
                        }
                        .padding(.horizontal, 18)
                        .padding(.vertical, 18)
                        
                        Divider()
                            .background(Color.white.opacity(0.08))
                            .padding(.leading, 18)
                        
                        OptionRow(
                            option: items[2],
                            isSelected: selectedId == items[2].id,
                            onTap: { handleOptionTap(items[2]) }
                        )
                        .padding(.horizontal, 18)
                        .padding(.vertical, 18)
                        
                        Divider()
                            .background(Color.white.opacity(0.08))
                            .padding(.leading, 18)
                        
                        OptionRow(
                            option: items[3],
                            isSelected: selectedId == items[3].id,
                            onTap: { handleOptionTap(items[3]) }
                        )
                        .padding(.horizontal, 18)
                        .padding(.vertical, 18)
                    }
                    .background(Color.clear)
                    .cornerRadius(12)
                    .padding(.top, 6)
                    
                    Spacer()
                    Capsule()
                        .frame(width: 140, height: 6)
                        .foregroundColor(Color.white.opacity(0.9))
                        .padding(.bottom, 12)
                }
                .padding(.top, 8)
            }
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $showShopScreen) {
                ShopScreen()
            }
        }
    }
    
    private func toggleSelection(for option: Option) {
        withAnimation(.easeInOut) {
            if selectedId == option.id {
                selectedId = nil
            } else {
                selectedId = option.id
            }
        }
    }
    
    // Новая функция для обработки нажатия на опцию
    private func handleOptionTap(_ option: Option) {
        toggleSelection(for: option)
        // Переход на ShopScreen через небольшую задержку для показа анимации выбора
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            showShopScreen = true
        }
    }
}

// MARK: - Option Model
fileprivate struct Option: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let imageName: String
}

// MARK: - Option Row View
fileprivate struct OptionRow: View {
    let option: Option
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                AvatarView(imageName: option.imageName)
                    .frame(width: 56, height: 56)
                
                Text(option.title)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.white.opacity(0.9))
                
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.3), lineWidth: 2)
                        .frame(width: 34, height: 34)
                    
                    if isSelected {
                        Circle()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.white)
                            .transition(.scale)
                    }
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Avatar View
fileprivate struct AvatarView: View {
    let imageName: String
    
    var body: some View {
        Group {
            if UIImage(named: imageName) != nil {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFill()
                    .padding(6)
            }
        }
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.white.opacity(0.12), lineWidth: 1.5)
        )
        .shadow(color: Color.black.opacity(0.6), radius: 4, x: 0, y: 1)
    }
}

struct FifthScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FifthScreen()
                .previewDevice("iPhone 14 Pro")
        }
    }
}
