import SwiftUI

struct Fourth_Screen: View {
    @State private var currentPage: Int = 0
    @State private var showFifthScreen = false
    private let pages = 2

    var body: some View {
        NavigationStack {
            ZStack {

                RemoteImage(
                    imagePath: "/images/pizdec.png",
                    aspectMode: .fill,
                    failure: AnyView(
                        Image("pizdc")
                            .resizable()
                            .scaledToFill()
                    )
                )
                .ignoresSafeArea()

                LinearGradient(
                    colors: [
                        Color.black.opacity(0.65),
                        Color.black.opacity(0.35)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack {
                    VStack {
                        Spacer().frame(height: 14)

                        ZStack(alignment: .leading) {
                            Capsule()
                                .frame(
                                    width: UIScreen.main.bounds.width * 0.44,
                                    height: 6
                                )
                                .foregroundColor(Color.white.opacity(0.18))

                            Capsule()
                                .frame(
                                    width: (UIScreen.main.bounds.width * 0.44)
                                        * (CGFloat(currentPage + 1) / CGFloat(pages)),
                                    height: 6
                                )
                                .foregroundColor(.white)
                                .animation(.easeInOut(duration: 0.25), value: currentPage)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 20)

                    VStack(alignment: .leading, spacing: 2) {
                        Text("To personalize your")
                        Text("experience and")
                        Text("connect you to sport,")
                        Text("we've got a few")
                        Text("questions for you.")
                    }
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .offset(x: -30)

                    Spacer()

                    HStack {
                        Spacer()
                        Button("Get Started") {
                            showFifthScreen = true
                        }
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(width: 220, height: 54)
                        .background(Color.white)
                        .cornerRadius(27)
                        .shadow(
                            color: Color.black.opacity(0.25),
                            radius: 8,
                            x: 0,
                            y: 6
                        )
                        Spacer()
                    }
                    .padding(.bottom, 16)
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $showFifthScreen) {
                FifthScreen()
            }
        }
    }
}
