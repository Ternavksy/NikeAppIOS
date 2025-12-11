import SwiftUI

struct BagScreen: View {
    @EnvironmentObject var bagManager: BagManager
    
    var body: some View {
        NavigationStack {
            VStack {
                if bagManager.items.isEmpty {
                    Text("Your bag is empty")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(bagManager.items) { product in
                            HStack(spacing: 12) {
                                Image(product.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 70, height: 70)
                                    .clipped()
                                    .cornerRadius(8)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(product.title)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                    
                                    Text(product.subtitle)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    Text(product.price)
                                        .font(.caption)
                                }
                                
                                Spacer()
                            }
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                let product = bagManager.items[index]
                                bagManager.remove(product)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Bag")
        }
    }
}
