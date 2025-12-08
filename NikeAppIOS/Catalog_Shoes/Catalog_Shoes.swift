import SwiftUI

struct Catalog_Shoes: View {
    @Environment(\.presentationMode) var presentationMode
    
    enum ShoeColor {
        case white
        case black
    }
    
    @State private var selectedColor: ShoeColor = .black
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text("Nike Air Force 1 '07")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18))
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.systemBackground))
            .border(Color(.systemGray5), width: 1)
            
            // Content
            VStack(spacing: 0) {
                // Main big image
                Group {
                    if selectedColor == .black {
                        Image("black_shoes")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 360)
                            .background(Color(.systemGray6))
                    } else {
                        Image("white_shoes")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 360)
                            .background(Color(.systemGray6))
                    }
                }
                .frame(maxWidth: .infinity)
                
                // Selector like on screenshot
                VStack(spacing: 12) {
                    
                    // Horizontal bar with left/right fill (ИНДИКАТОР НАД ПРЕВЬЮ)
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color(.systemGray5))
                                .frame(height: 4)
                            
                            if selectedColor == .white {
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(Color.black)
                                    .frame(width: geo.size.width / 2, height: 4)
                            } else {
                                HStack(spacing: 0) {
                                    Spacer()
                                    RoundedRectangle(cornerRadius: 2)
                                        .fill(Color.black)
                                        .frame(width: geo.size.width / 2, height: 4)
                                }
                            }
                        }
                    }
                    .frame(height: 4)
                    .padding(.horizontal, 80)
                    .padding(.bottom, 6)
                    
                    HStack(spacing: 16) {
                        Button {
                            selectedColor = .white
                        } label: {
                            Image("white_shoes")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 70)
                                .clipped()
                        }
                        
                        Button {
                            selectedColor = .black
                        } label: {
                            Image("black_shoes")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 70)
                                .clipped()
                        }
                    }
                    .padding(.horizontal, 40)
                }
                .padding(.top, 24)
                
                Spacer()
            }
            
            // HomeTab (тот же набор вкладок, что и в Main_Screen)
            TabView {
                HomeTab()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
                Discover_Screen()
                    .tabItem {
                        Image(systemName: "bag")
                        Text("Shop")
                    }
                
                Text("Favorites")
                    .tabItem {
                        Image(systemName: "heart")
                        Text("Favorites")
                    }
                
                Text("Bag")
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
            .frame(height: 60) // можно подогнать под нужную высоту
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Catalog_Shoes_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Catalog_Shoes()
        }
        .previewDevice("iPhone 14 Pro")
    }
}
