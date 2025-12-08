import SwiftUI

struct FavoritesScreen: View {
    @EnvironmentObject var favManager: FavoritesManager
   
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // MARK: — Header
                HStack {
                    Text("Favorites")
                        .font(.headline)
                   
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
               
                Divider()
               
                // MARK: — Content
                if favManager.favorites.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "heart")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                       
                        Text("No favorites yet")
                            .font(.headline)
                            .foregroundColor(.gray)
                       
                        Text("Tap the heart icon on items you love.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(favManager.favorites) { item in
                                HStack(spacing: 14) {
                                    Image(item.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 90, height: 90)
                                        .background(Color(.systemGray6))
                                        .cornerRadius(12)
 
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(item.title)
                                            .font(.headline)
                                       
                                        Text(item.subtitle)
                                            .font(.caption)
                                            .foregroundColor(.gray)
 
                                        Text(item.price)
                                            .foregroundColor(.gray)
                                            .font(.subheadline)
                                    }
 
                                    Spacer()
                                   
                                    Button(action: {
                                        favManager.removeFavoriteItem(item)
                                    }) {
                                        Image(systemName: "heart.fill")
                                            .foregroundColor(.red)
                                            .font(.system(size: 16))
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top)
                        .padding(.bottom, 100)
                    }
                }
            }
           
            // Кастомная tab bar удалена — используется основная из TabView
        }
        .navigationBarHidden(true)
    }
}

struct FavoritesScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesScreen()
            .environmentObject(FavoritesManager())
    }
}
