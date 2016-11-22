import UIKit
import FirebaseAuth
import FirebaseDatabase

class FirebaseDBHelper {
    static func getFIRDatabaseReference() -> FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    static func getUser(id: String) -> FIRDatabaseReference {
        return self.getFIRDatabaseReference().child("users").child(id)
    }
    static func logOut() {
        try! FIRAuth.auth()!.signOut()
    }
}

