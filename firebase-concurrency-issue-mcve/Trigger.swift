class Trigger {
  static let shared = Trigger()
  
  func toggle() {
    Document1.shared.get()
    Document2.shared.get()
    AppRemoteConfig.shared.fetch()
  }
}
