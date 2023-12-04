import FirebaseAuth
import FirebaseFirestore
import Foundation

class AddMovieViewViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var director: String = ""
    @Published var created: Date = Date()
    @Published var isWatched: Bool = false
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    
    init () {
        
    }
    
    func save () -> Void {
        guard canSave else {
            return
        }
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let id = UUID().uuidString
        let movie = Movie(id: id, title: title, director: director, created: created.timeIntervalSince1970, isWatched: isWatched)
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("movies")
            .document(id)
            .setData(movie.asDisctionary())
    }
    
    var canSave: Bool {
        errorMessage = ""
        
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Movie's title cannot be empty. Please fill in the title field."

            return false;
        }
        
        guard !director.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Movie's director cannot be empty. Please fill in the director field."

            return false;
        }

        guard created < Date() else {
            errorMessage = "Movie could not be created in the future. Please select date from the past."
            return false
        }

        return true
    }
}
