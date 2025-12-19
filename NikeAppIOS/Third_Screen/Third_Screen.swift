import SwiftUI

struct ThirdScreen: View {

    @Environment(\.dismiss) var dismiss
    @State private var email: String = ""
    @State private var showError: Bool = false

    @Binding var isLoggedIn: Bool

    @FocusState private var isEmailFocused: Bool

    var body: some View {
        VStack(spacing: 0) {

            // MARK: Top bar
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

                    // MARK: Logo (ВОЗВРАЩЕНО НА МЕСТО)
                    RemoteImage(
                        imagePath: "/images/nike_black.png",
                        aspectMode: .fit,
                        failure: AnyView(
                            Image("nike_black")
                                .resizable()
                                .scaledToFit()
                        )
                    )
                    .frame(width: 160, height: 90)
                    .padding(.leading, -30)
                    .padding(.top, 20)

                    Text("Enter your email to join\nus or sign in.")
                        .font(.system(size: 28, weight: .bold))

                    HStack {
                        Text("United States")
                            .font(.subheadline)

                        Button("Change") {}
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Email")
                            .font(.footnote)
                            .foregroundColor(.gray)

                        TextField("Email", text: $email)
                            .focused($isEmailFocused)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(
                                        showError ? Color.red : Color.gray.opacity(0.4),
                                        lineWidth: 1
                                    )
                            )
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .submitLabel(.done)
                            .onSubmit {
                                validate()
                            }

                        if showError {
                            Text("Invalid email address")
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }

                    Spacer()
                }
                .padding(.horizontal, 24)
            }

            Button("Done") {
                validate()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(UIColor.systemGray5))
        }
        .onTapGesture {
            isEmailFocused = false
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isEmailFocused = true
            }
        }
    }

    private func validate() {
        let lower = email.lowercased()

        let valid =
            lower.hasSuffix("@gmail.com") ||
            lower.hasSuffix("@mail.ru") ||
            lower.hasSuffix("@yandex.ru")

        if valid {
            showError = false
            isLoggedIn = true
            dismiss()
        } else {
            showError = true
            isEmailFocused = true
        }
    }
}
