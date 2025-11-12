import FirebaseCore
import FirebaseFirestore


struct Document2 {
  static let shared = Document2()
  func get() {
    let db = Firestore.firestore()
    Task {
      do {
        let querySnapshot = try await db.collection("collection2").getDocuments()
        let documents = querySnapshot.documents.compactMap { document in
          return try? document.data(as: Document.self)
        }
        print(documents)
      } catch {
        print(error)
      }
    }
  }
}
