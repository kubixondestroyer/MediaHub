import Foundation
import FirebaseAuth
import FirebaseFirestore

class EditProfileViewViewModel: ObservableObject {
    @Published var name: String
    @Published var email: String
    @Published var joined: TimeInterval
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    
    init(name: String, email: String, joined: TimeInterval) {
        self.name = name
        self.email = email
        self.joined = joined
    }
    
    func save() -> Void {
        guard canSave else {
            return
        }
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let user = User(id: userId, name: name, email: email, joined: joined)
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .setData(user.asDisctionary())
    }

    var canSave: Bool {
        errorMessage = ""
        
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Profile's name cannot be empty. Please fill in the profile name field."

            return false;
        }

        return true
    }
}
