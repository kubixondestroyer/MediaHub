//import Foundation
//import FirebaseFirestore
//import FirebaseAuth
//
//class MoviesListViewViewModel: ObservableObject {
//    @Published var showingAddMovieView: Bool = false
//
//    init () {
//
//    }
//
//    func delete(id: String) {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            return
//        }
//
//        let db = Firestore.firestore()
//        db.collection("users")
//            .document(userId)
//            .collection("movies")
//            .document(id)
//            .delete()
//    }
//}

//import Foundation
//import FirebaseFirestore
//import FirebaseAuth
//
//class MoviesListViewViewModel: ObservableObject {
//    @Published var showingAddMovieView: Bool = false
//    @Published var userData: User? // Dodaj model UserData na potrzeby przechowywania danych użytkownika
//
//    init() {
//        fetchUserData()
//    }
//
//    func fetchUserData() {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            return
//        }
//
//        let db = Firestore.firestore()
//        let userRef = db.collection("users").document(userId)
//
//        userRef.getDocument { document, error in
//            if let document = document, document.exists {
//                do {
//                    self.userData = try document.data(as: User.self)
//                } catch {
//                    print("Error decoding user data: \(error)")
//                }
//            } else {
//                print("User document does not exist")
//            }
//        }
//    }
//
//    func delete(id: String) {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            return
//        }
//
//        let db = Firestore.firestore()
//        db.collection("users")
//            .document(userId)
//            .collection("movies")
//            .document(id)
//            .delete()
//    }
//}
import Foundation
import FirebaseFirestore
import FirebaseAuth

class MoviesListViewViewModel: ObservableObject {
    @Published var showingAddMovieView: Bool = false
    @Published var userData: User?

    init() {
        fetchUserData()
    }

    func fetchUserData() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }

        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userId)

        userRef.getDocument { document, error in
            if let document = document, document.exists {
                do {
                    self.userData = try document.data(as: User.self)
                } catch {
                    print("Error decoding user data: \(error)")
                }
            } else {
                print("User document does not exist")
            }
        }
    }

    func delete(id: String) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }

        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("movies")
            .document(id)
            .delete()
    }
}



