//
//  LogViewModel.swift
//  Soul25
//
//  Created by Zablon Charles on 7/1/24.
//
import FirebaseFirestore


class LogViewModel: ObservableObject {
    @Published var books: [Book] = []
    private var db = Firestore.firestore()
    
    func fetchData(for email: String, completion: @escaping ([Book]) -> Void) {
        db.collection("chats").whereField("userId", isEqualTo: email).getDocuments { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents, !documents.isEmpty else {
                print("No documents with matching email")
                completion([])
                return
            }
            
            var fetchedBooks: [Book] = []
            let dispatchGroup = DispatchGroup()
            
            for document in documents {
                dispatchGroup.enter()
                document.reference.collection("chat").getDocuments { (subcollectionSnapshot, error) in
                    defer { dispatchGroup.leave() }
                    
                    guard let subcollectionDocuments = subcollectionSnapshot?.documents else {
                        print("No documents in messages subcollection for chat ID \(document.documentID)")
                        return
                    }
                    
                    let newBooks = subcollectionDocuments.compactMap { queryDocumentSnapshot -> Book? in
                        let data = queryDocumentSnapshot.data()
                        let userId = data["userId"] as? String ?? ""
                        let message = data["message"] as? String ?? ""
                        let timestamp = data["timestamp"] as? String ?? ""
                        
                        return Book(id: queryDocumentSnapshot.documentID, userId: userId, message: message, timestamp: timestamp)
                    }
                    
                    fetchedBooks.append(contentsOf: newBooks)
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                completion(fetchedBooks)
            }
        }
    }
}
