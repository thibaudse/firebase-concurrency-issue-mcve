import SwiftUI

struct ContentView: View {
  @State private var authViewModel = AuthenticationViewModel()

  var body: some View {
    if authViewModel.isAuthenticated {
      VStack(spacing: 20) {
        Text("Welcome!")
          .font(.largeTitle)
          .bold()

        Text("Email: \(authViewModel.userEmail)")
          .font(.body)

        Button("Trigger", action: Trigger.shared.toggle)
          .padding()
          .background(Color.green)
          .foregroundColor(.white)
          .cornerRadius(10)

        Button("Sign Out", action: authViewModel.signOut)
          .padding()
          .background(Color.red)
          .foregroundColor(.white)
          .cornerRadius(10)
      }
      .padding()
    } else {
      LoginView(authViewModel: $authViewModel)
    }
  }
}

#Preview {
  ContentView()
}
