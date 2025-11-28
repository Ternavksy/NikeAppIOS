import SwiftUI

struct ShopScreen: View {
    
    @State private var selectedTab = 0
    let tabs = ["Men", "Women", "Kids"]
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: - Tabs Men / Women / Kids
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 28) {
                            ForEach(tabs.indices, id: \.self) { index in
                                VStack {
                                    Text(tabs[index])
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(selectedTab == index ? .black : .gray)
                                    
                                    Rectangle()
                                        .fill(selectedTab == index ? .black : .clear)
                                        .frame(height: 2)
                                        .frame(width: 40)
                                }
                                .onTapGesture {
                                    selectedTab = index
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                    }
                    
                    // MARK: - Section 1
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text("Must-Haves, Best Sellers & More")
                            .font(.system(size: 22, weight: .bold))
                            .padding(.horizontal)
                        
                        HStack(spacing: 12) {
                            Image("image 18")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width/2 - 22, height: 200)
                                .clipped()
                                .cornerRadius(10)
                            
                            Image("image 19")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width/2 - 22, height: 200)
                                .clipped()
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Text("Best Sellers")
                                .font(.system(size: 14))
                            
                            Text("Featured in Nike Air")
                                .font(.system(size: 14))
                        }
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    }
                    
                    // MARK: - Section 2
                    VStack(alignment: .leading, spacing: 12) {
                        ZStack(alignment: .bottomLeading) {
                            Image("nikeee")
                                .resizable()
                                .frame(width: 335, height: 111)
                                .clipped()
                                .cornerRadius(10)
                            
                            Text("New & Featured")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                        }
                        .padding(.horizontal)
                    }
                    
                    // MARK: - Section 3
                    VStack(alignment: .leading, spacing: 12) {
                        ZStack(alignment: .bottomLeading) {
                            Image("pacani")
                                .resizable()
                                .frame(width: 335, height: 111)
                                .clipped()
                                .cornerRadius(10)
                            
                            Text("Shoes")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 40)
                }
            }
            .navigationTitle("Shop")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

struct ShopScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ShopScreen()
                .previewDevice("iPhone 14 Pro")
        }
    }
}
