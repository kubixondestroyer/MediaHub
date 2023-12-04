import FirebaseAuth
import FirebaseFirestore
import Foundation

class EditMovieViewViewModel: ObservableObject {
    let id: String
    @Published var title: String
    @Published var director: String
    @Published var created: Date
    @Published var isWatched: Bool
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    
    init(id: String, title: String, director: String, created: Date, isWatched: Bool) {
        self.id = id
        self.title = title
        self.director = director
        self.created = created
        self.isWatched = isWatched
    }
    
    func toggleIsWatched() -> Void {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }

        self.isWatched = !self.isWatched
        
        let movie = Movie(id: id, title: title, director: director, created: created.timeIntervalSince1970, isWatched: isWatched)
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("movies")
            .document(self.id)
            .setData(movie.asDisctionary())
    }
    
    func save () -> Void {
        guard canSave else {
            return
        }
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let movie = Movie(id: id, title: title, director: director, created: created.timeIntervalSince1970, isWatched: isWatched)
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("movies")
            .document(self.id)
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
    
    func delete() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("movies")
            .document(self.id)
            .delete()
    }
}
