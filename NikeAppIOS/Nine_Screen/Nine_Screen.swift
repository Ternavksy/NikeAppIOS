import SwiftUI

struct Nine_Screen: View {
    
    @State private var code: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var password: String = ""
    @State private var showPassword = false
    @State private var birthDate: Date? = nil
    @State private var showDatePicker = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .leading, spacing: 26) {
                
                // MARK: – Nike Logo (как на скриншоте)
                Image("nike_black")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .padding(.top, 20)
                    .padding(.leading, -30)
                
                
                // MARK: – Title
                Text("Now let's make you a\nNike Member.")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.black)
                
                
                // MARK: – Email info
                VStack(alignment: .leading, spacing: 4) {
                    Text("We've sent a code to")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                    
                    HStack(spacing: 4) {
                        Text("john.mobbin1@gmail.com")
                            .font(.subheadline)
                        
                        Text("Edit")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                }
                
                
                // MARK: – Code input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Code")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    HStack {
                        TextField("", text: $code)
                            .keyboardType(.numberPad)
                            .padding(.horizontal)
                        
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.gray)
                            .padding(.trailing)
                    }
                    .frame(height: 50)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
                
                
                // MARK: – First / Last name
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
                    }
                }
                
                
                // MARK: – Password
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
                    
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.green)
                            Text("Minimum of 8 characters")
                                .foregroundColor(.green)
                                .font(.footnote)
                        }
                        
                        HStack {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.green)
                            Text("Uppercase, lowercase letters and one number")
                                .foregroundColor(.green)
                                .font(.footnote)
                        }
                    }
                }
                
                
                // MARK: – Date of birth
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
                }
                
                Text("Get a Nike Member Reward on your birthday.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, -10)
                
            }
            .padding(.horizontal, 26)
        }
        .background(Color.white)
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
                
                Button("Done") {
                    showDatePicker = false
                }
                .padding()
            }
        }
    }
}


#Preview {
    Nine_Screen()
}
