import SwiftUI

struct ThirdScreen: View {

    @Environment(\.dismiss) var dismiss
    @State private var email: String = ""
    @State private var showError: Bool = false
    @State private var goMain: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
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

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {

                        Image("nike_black")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 160, height: 90)
                            .padding(.leading, -30)
                            .padding(.top, 20)

                        Text("Enter your email to join\nus or sign in.")
                            .font(.system(size: 28, weight: .bold))
                            .multilineTextAlignment(.leading)

                        HStack {
                            Text("United States")
                                .font(.subheadline)

                            Button("Change") { }
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text("Email")
                                .font(.footnote)
                                .foregroundColor(.gray)

                            TextField("", text: $email)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(showError ? Color.red : Color.gray.opacity(0.4), lineWidth: 1)
                                )
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)

                            if showError {
                                Text("Invalid email address")
                                    .foregroundColor(.red)
                                    .font(.caption)
                            }
                        }

                        Spacer()
                    }
                    .padding(.horizontal, 24)
                }

                VStack {
                    Button("Done") {
                        validate()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(UIColor.systemGray5))
                }
            }
            .ignoresSafeArea(edges: .bottom)
            
            .navigationDestination(isPresented: $goMain) {
                Main_Screen()
            }
        }
    }

    private func validate() {
        let lower = email.lowercased()

        let valid =
            (lower.hasSuffix("@gmail.com") ||
             lower.hasSuffix("@mail.ru") ||
             lower.hasSuffix("@yandex.ru"))

        if valid {
            showError = false
            goMain = true
        } else {
            showError = true
        }
    }
}

struct ThirdScreen_Previews: PreviewProvider {
    static var previews: some View {
        ThirdScreen()
    }
}
