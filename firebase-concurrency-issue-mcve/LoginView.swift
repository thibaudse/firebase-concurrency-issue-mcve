import SwiftUI

struct LoginView: View {
  @Binding var authViewModel: AuthenticationViewModel
  
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var isSignUpMode: Bool = false

  var body: some View {
    VStack(spacing: 20) {
      Text(isSignUpMode ? "Sign Up" : "Sign In")
        .font(.largeTitle)
        .bold()

      TextField("Email", text: $email)
        .textFieldStyle(.roundedBorder)
        .textContentType(.emailAddress)
        .autocapitalization(.none)
        .keyboardType(.emailAddress)
        .padding(.horizontal)

      SecureField("Password", text: $password)
        .textFieldStyle(.roundedBorder)
        .textContentType(.password)
        .padding(.horizontal)

      if !authViewModel.errorMessage.isEmpty {
        Text(authViewModel.errorMessage)
          .foregroundColor(.red)
          .font(.caption)
          .padding(.horizontal)
      }

      Button {
        Task {
          if isSignUpMode {
            await authViewModel.signUp(email: email, password: password)
          } else {
            await authViewModel.signIn(email: email, password: password)
          }
        }
      } label: {
        Text(isSignUpMode ? "Sign Up" : "Sign In")
          .frame(maxWidth: .infinity)
          .padding()
          .background(Color.blue)
          .foregroundColor(.white)
          .cornerRadius(10)
      }
      .padding(.horizontal)

      Button {
        isSignUpMode.toggle()
      } label: {
        Text(isSignUpMode ? "Already have an account? Sign In" : "Don't have an account? Sign Up")
          .font(.caption)
      }
    }
    .padding()
  }
}
