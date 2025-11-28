import SwiftUI

/// Главный контейнер со TabView
struct MainContentView: View {
    var body: some View {
        TabView {
            HomeTabView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            ShopTabView()
                .tabItem {
                    Image(systemName: "bag")
                    Text("Shop")
                }
            
            FavoritesTabView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
            
            BagTabView()
                .tabItem {
                    Image(systemName: "bag.fill")
                    Text("Bag")
                }
            
            ProfileTabView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

// MARK: - Profile Screen
// MARK: - Profile Screen — всё по канону Nike
// MARK: - Profile Screen — 100% как в оригинальном Nike App
struct ProfileTabView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // Коллаж 2×2
                    GeometryReader { geo in
                        let w = geo.size.width
                        HStack(spacing: 8) {
                            VStack(spacing: 8) {
                                CollageImage(name: "man_ten")
                                CollageImage(name: "girl_tens")
                            }
                            VStack(spacing: 8) {
                                CollageImage(name: "girl_ten")
                                CollageImage(name: "girl_profile")
                            }
                        }
                        .frame(width: w)
                    }
                    .frame(height: 380)
                    
                    // Точный отступ — как у Nike (примерно 28–32 pt)
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Welcome to the")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(.primary)
                        
                        Text("Nike App")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundStyle(.primary)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 150)          // ← вот эта строчка отвечает за «ниже опустить»
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Дальше будет твой контент (кнопки Sign In / Join и т.д.)
                    // Например:
                    // SignInButtons()
                    // Recommendations()
                    Spacer(minLength: 100)
                }
            }
            .background(Color(.systemBackground).ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

/// Одна картинка коллажа
struct CollageImage: View {
    let name: String
    
    var body: some View {
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
            .cornerRadius(4)
    }
}

// MARK: - Заглушки для остальных табов
struct HomeTabView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("HomeTab")
                    .font(.title)
                    .padding()
                Spacer()
            }
            .navigationTitle("Home")
        }
    }
}

struct ShopTabView: View {
    var body: some View {
        NavigationStack { Text("Shop").navigationTitle("Shop") }
    }
}

struct FavoritesTabView: View {
    var body: some View {
        NavigationStack { Text("Favorites").navigationTitle("Favorites") }
    }
}

struct BagTabView: View {
    var body: some View {
        NavigationStack { Text("Bag").navigationTitle("Bag") }
    }
}

// MARK: - Preview
struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
            .previewDevice("iPhone 14 Pro")
    }
}
