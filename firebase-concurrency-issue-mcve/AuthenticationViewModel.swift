import Combine
import Foundation
import FirebaseAuth

@MainActor
@Observable
class AuthenticationViewModel {
  var userEmail: String = ""
  var isAuthenticated: Bool = false
  var errorMessage: String = ""

  private var idTokenListenerHandle: IDTokenDidChangeListenerHandle?

  init() {
    print("AuthenticationViewModel init")
    setupIDTokenListener()
  }

  deinit {
    print("AuthenticationViewModel deinit")
    Task.detached { [weak self] in
      if let handle = await self?.idTokenListenerHandle {
        Auth.auth().removeIDTokenDidChangeListener(handle)
      }
    }
  }

  private func setupIDTokenListener() {
    print("Setting up ID token listener")
    idTokenListenerHandle = Auth.auth().addIDTokenDidChangeListener { [weak self] _, user in
      print("ID Token listener fired")
      Task { @MainActor in
        guard let self = self else { return }

        if let user = user {
          self.userEmail = user.email ?? ""
          self.isAuthenticated = true

          print("ID Token fetched for user: \(user.uid)")
        } else {
          self.isAuthenticated = false
          self.userEmail = ""
          print("User signed out, ID token cleared")
        }
      }
    }
  }

  func signIn(email: String, password: String) async {
    do {
      let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
      self.userEmail = authResult.user.email ?? ""
      self.isAuthenticated = true
      self.errorMessage = ""
    } catch {
      self.errorMessage = error.localizedDescription
      self.isAuthenticated = false
    }
  }

  func signUp(email: String, password: String) async {
    do {
      let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
      self.userEmail = authResult.user.email ?? ""
      self.isAuthenticated = true
      self.errorMessage = ""
    } catch {
      self.errorMessage = error.localizedDescription
      self.isAuthenticated = false
    }
  }

  func signOut() {
    do {
      try Auth.auth().signOut()
      self.isAuthenticated = false
      self.userEmail = ""
      self.errorMessage = ""
    } catch {
      self.errorMessage = error.localizedDescription
    }
  }
}
