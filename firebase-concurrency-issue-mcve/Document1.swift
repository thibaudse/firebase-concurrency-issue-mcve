import FirebaseCore
import FirebaseFirestore


struct Document1 {
  static let shared = Document1()
  func get() {
    let db = Firestore.firestore()
    Task {
      do {
        let querySnapshot = try await db.collection("collection1").getDocuments()
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
