import SwiftUI

struct Nine_Screen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var code = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var birthDate: Date? = nil
    @State private var showDatePicker = false
    @State private var showError = false

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Кнопка назад
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.black)
                            .frame(width: 44, height: 44)
                            .background(Color(.systemGray6))
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 50)

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 26) {
                        Image("nike_black")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                            .padding(.top, 20)
                            .padding(.leading, -30)

                        Text("Now let's make you a\nNike Member.")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.black)

                        // MARK: Code
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Code")
                                .font(.footnote)
                                .foregroundColor(.gray)

                            TextField("", text: $code)
                                .keyboardType(.numberPad)
                                .padding(.horizontal)
                                .frame(height: 50)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)

                            if showError && code.isEmpty {
                                Text("Please enter the code.")
                                    .font(.footnote)
                                    .foregroundColor(.red)
                            }
                        }

                        // MARK: First/Last name
                        HStack(spacing: 16) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("First name")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                TextField("", text: $firstName)
                                    .padding(.horizontal)
                                    .frame(height: 50)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                if showError && firstName.isEmpty {
                                    Text("Required field.")
                                        .font(.footnote)
                                        .foregroundColor(.red)
                                }
                            }

                            VStack(alignment: .leading, spacing: 8) {
                                Text("Surname")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                TextField("", text: $lastName)
                                    .padding(.horizontal)
                                    .frame(height: 50)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                if showError && lastName.isEmpty {
                                    Text("Required field.")
                                        .font(.footnote)
                                        .foregroundColor(.red)
                                }
                            }
                        }

                        // MARK: Password
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password")
                                .font(.footnote)
                                .foregroundColor(.gray)

                            HStack {
                                if showPassword {
                                    TextField("", text: $password)
                                        .padding(.horizontal)
                                } else {
                                    SecureField("", text: $password)
                                        .padding(.horizontal)
                                }

                                Button {
                                    showPassword.toggle()
                                } label: {
                                    Image(systemName: showPassword ? "eye.slash" : "eye")
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                }
                            }
                            .frame(height: 50)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)

                            if showError && password.isEmpty {
                                Text("Password is required.")
                                    .font(.footnote)
                                    .foregroundColor(.red)
                            }
                        }

                        // MARK: Birth Date
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Date of Birth")
                                .font(.footnote)
                                .foregroundColor(.gray)

                            Button {
                                showDatePicker = true
                            } label: {
                                HStack {
                                    Text(birthDate != nil ?
                                         birthDate!.formatted(date: .numeric, time: .omitted) :
                                         "Date of Birth")
                                        .foregroundColor(birthDate == nil ? .gray : .black)

                                    Spacer()
                                    Image(systemName: "calendar")
                                        .foregroundColor(.gray)
                                }
                                .padding(.horizontal)
                                .frame(height: 50)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                            }

                            if showError && birthDate == nil {
                                Text("Select your date of birth.")
                                    .font(.footnote)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .padding(.horizontal, 26)
                }

                // MARK: Continue Button
                Button(action: {
                    if code.isEmpty || firstName.isEmpty || lastName.isEmpty || password.isEmpty || birthDate == nil {
                        showError = true
                    } else {
                        // Закрываем весь стек навигации и переходим на Main_Screen
                        dismiss()
                        // Здесь можно добавить сохранение данных пользователя
                    }
                }) {
                    Text("Continue to Profile")
                        .font(.system(size: 18, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Capsule().fill(Color.black))
                        .foregroundColor(.white)
                        .padding(.horizontal, 80)
                }
                .padding(.top, 40)
                .padding(.bottom, 50)
            }
        }
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .sheet(isPresented: $showDatePicker) {
            VStack {
                DatePicker(
                    "Select your birthday",
                    selection: Binding(
                        get: { birthDate ?? Date() },
                        set: { birthDate = $0 }
                    ),
                    displayedComponents: .date
                )
                .datePickerStyle(.wheel)
                .labelsHidden()

                Button("Done") { showDatePicker = false }
                    .padding()
            }
        }
    }
}

struct Nine_Screen_Previews: PreviewProvider {
    static var previews: some View {
        Nine_Screen()
            .previewDevice("iPhone 14 Pro")
    }
}
