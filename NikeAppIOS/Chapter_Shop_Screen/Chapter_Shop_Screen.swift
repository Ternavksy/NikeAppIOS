import SwiftUI

struct Chapter_Shop_Screen: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var favManager: FavoritesManager
    @EnvironmentObject var bagManager: BagManager
    @EnvironmentObject var appState: AppState
    
    let interests = ["work_nike", "work_nike", "work_nike", "work_nike"]
    let recommended = [
        ("Nike Air Force 1", "US$120", "white_shoes"),
        ("Nike Air Max 90", "US$150", "white_shoes"),
        ("Nike Cortez", "US$95", "white_shoes"),
        ("Nike Air Max 270", "US$160", "white_shoes")
    ]
    let nearbyStores = [
        ("Nike By Flatiron", "1.4mi inside", "store"),
        ("Nike Times Square", "2.1mi inside", "store"),
        ("Nike Downtown", "0.8mi inside", "store"),
        ("Nike Uptown", "3.0mi inside", "store")
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Custom Navigation Bar
            HStack {
                Button { presentationMode.wrappedValue.dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20))
                        .foregroundColor(.blue)
                        .frame(width: 44, height: 44)
                }
                Spacer()
                Text("Shop").font(.headline).fontWeight(.semibold)
                Spacer()
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18))
                    .foregroundColor(.black)
                    .frame(width: 44, height: 44)
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            .background(Color(.systemBackground))
            .border(Color(.systemGray5), width: 1)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Store Locator
                    VStack(alignment: .center, spacing: 12) {
                        HStack(spacing: 20) {
                            Image(systemName: "smiley").font(.system(size: 48)).foregroundColor(.gray)
                            Image(systemName: "bag").font(.system(size: 48)).foregroundColor(.gray)
                        }
                        Text("Store Locator").font(.headline).fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
                    
                    // Shop My Interests
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Shop My Interests").font(.headline).fontWeight(.semibold)
                            Spacer()
                            NavigationLink(destination: Best_Sellers()
                                .environmentObject(favManager)
                                .environmentObject(bagManager)) {
                                Text("Add Interest").font(.caption).foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(interests, id: \.self) { imageName in
                                    Image(imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 180, height: 220)
                                        .clipped()
                                        .cornerRadius(12)
                                }
                            }.padding(.horizontal)
                        }
                    }
                    
                    // Recommended for You - ✅ БЕЗ appState!
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recommended for You")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(recommended, id: \.0) { product in
                                    NavigationLink(destination: Catalog_Shoes()
                                        .environmentObject(favManager)
                                        .environmentObject(bagManager)) {  // ✅ УБРАЛ appState
                                        VStack(alignment: .leading, spacing: 8) {
                                            Image(product.2)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 180, height: 220)
                                                .clipped()
                                                .cornerRadius(12)
                                            Text(product.0).font(.subheadline).fontWeight(.semibold)
                                            Text(product.1).font(.caption).foregroundColor(.gray)
                                        }
                                        .frame(width: 180)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }.padding(.horizontal)
                        }
                    }
                    
                    // Nearby Stores
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Nearby Stores").font(.headline).fontWeight(.semibold)
                            Spacer()
                            NavigationLink(destination: Trend_Screen()
                                .environmentObject(favManager)
                                .environmentObject(bagManager)) {
                                Text("Find a Store").font(.caption).foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(nearbyStores, id: \.0) { store in
                                    VStack(alignment: .leading, spacing: 8) {
                                        Image(store.2)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 180, height: 220)
                                            .clipped()
                                            .cornerRadius(12)
                                        Text(store.0).font(.subheadline).fontWeight(.semibold)
                                        Text(store.1).font(.caption).foregroundColor(.gray)
                                    }.frame(width: 180)
                                }
                            }.padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 8)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea(.keyboard)
    }
}
