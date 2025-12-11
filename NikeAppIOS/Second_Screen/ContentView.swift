import SwiftUI

struct ContentView: View {

    @State private var isLoggedIn = false
    @State private var showForm = false

    var body: some View {
        if isLoggedIn {
            Main_Screen()
        } else {
            ZStack {
                Image("image_3")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                LinearGradient(
                    gradient: Gradient(colors: [.black.opacity(0.2), .black.opacity(0.8)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack {
                    Spacer()

                    HStack {
                        Image("nike")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                            .padding(.bottom, -40)
                        Spacer()
                    }
                    .padding(.leading, -68)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Nike App")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)

                        Text("""
                        Bringing Nike Members
                        the best products,
                        inspiration and stories
                        in sport.
                        """)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .lineSpacing(4)
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 40)

                    HStack(spacing: 16) {
                        Button {
                            showForm = true
                        } label: {
                            Text("Join Us")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(30)
                        }

                        Button {
                            showForm = true
                        } label: {
                            Text("Sign In")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.white, lineWidth: 1)
                                )
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 50)
                }
                .padding(.bottom, 20)
            }
            .sheet(isPresented: $showForm) {
                ThirdScreen(isLoggedIn: $isLoggedIn)
            }
        }
    }
}
