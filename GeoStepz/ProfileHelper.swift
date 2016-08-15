import UIKit
import FirebaseAuth
import FirebaseDatabase

class ProfileHelper {
    static private var loggedIn:Bool = false
    static private var loggedInUserId:String? = nil
    static private var loggedInUser:User? = nil

    static func registerUser(user: User) {
        let ref = FIRDatabase.database().reference()
        ref.child("users").child(user.getId()).setValue(user)
    }

    static func logInUser(user: User, currentViewController: UIViewController) {
        self.loggedIn = true
        self.loggedInUser = user

        let storyboard = UtilitiesHelper.getStoryboard()
        let secondViewController = storyboard.instantiateViewControllerWithIdentifier("UITabBarControllerMain") as! UITabBarController
        currentViewController.presentViewController(secondViewController, animated: true, completion: nil)
    }

    static func logOutUser() {
        try! FIRAuth.auth()!.signOut()

        self.loggedIn = false
        self.loggedInUserId = ""
        self.loggedInUser = nil
    }

    static func isLoggedIn() -> Bool {
        return loggedIn
    }

    static func getLoggedInUserId() -> String {
        return loggedInUserId!
    }

    static func getLoggedInUser() -> User {
        return loggedInUser!
    }
}
