import SwiftUI

struct WebAuth_Screen: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: Top Bar (Safari style)
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundColor(.blue)
                
                Spacer()
                
                Text("accounts.nike.com")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Image(systemName: "arrow.clockwise")
                    .foregroundColor(.blue)
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: Nike Logo
                    Image("nike_black")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                        .padding(.top, 20)
                    
                    
                    // MARK: Avatar
                    Image("photo_man")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    
                    
                    // MARK: Info text
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Would you like to continue as John Mobbin?")
                            .font(.system(size: 24, weight: .bold))
                        
                        Text("john.mobbin1@gmail.com")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 32)
                    
                    
                    Text("By continuing, I agree to Nike's Privacy Policy and Terms of Use.")
                        .font(.system(size: 17))
                        .foregroundColor(.gray)
                        .padding(.trailing, 32)
                    
                    
                    Spacer(minLength: 40)
                }
                .padding(.horizontal, 24)
            }
            
            
            // MARK: Bottom Button Bar (fixed)
            // MARK: Bottom Button Bar (fixed)
            // MARK: Bottom Button Bar (fixed)
            VStack(spacing: 14) {
                
                Button(action: {}) {
                    Text("Continue")
                        .font(.system(size: 17, weight: .semibold))
                        .frame(width: 301, height: 60)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                }
                
                Button("No, use another account.") {}
                    .foregroundColor(.black)
                    .font(.system(size: 15))
                
            }
            .padding(.horizontal, 20)
            .offset(y: -90)  // ← вот здесь сдвигаем кнопки выше

        }
    }
}

#Preview {
    WebAuth_Screen()
}
