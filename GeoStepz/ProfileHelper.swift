import UIKit
import FirebaseAuth
import FirebaseDatabase

class ProfileHelper {
    static private var loggedIn:Bool = false
    static private var loggedInUserId:String? = nil
    static private var loggedInUser:User? = nil

    static func registerUser(
        currentViewController: UIViewController,
        email: String,
        username: String,
        password: String
        ) {
        FIRAuth.auth()?.createUserWithEmail(email, password: password) { (user, error) in
            if let user = user {
                print("Successfully created user!")
                
                let user:User = User(
                    id: user.uid,
                    username: username,
                    email: email,
                    password: password
                )

                FirebaseDBHelper.getUser(user.getId()).setValue([
                    "id": user.getId(),
                    "username": user.getUsername(),
                    "email": user.getEmail(),
                    "password": user.getPassword()
                ])
                //self.logInUser(currentViewController, email: email, password: password)
            } else {
                print("Error creating user!")
                UtilitiesHelper.getAlertInstance(currentViewController, title: "Register Error", message: "Error authenticating.", hasTextField: false, textFieldValue: "", type: "ok")
            }
        }
    }

    static func logInUser(currentViewController: UIViewController, email: String, password: String) {
        FIRAuth.auth()?.signInWithEmail(email, password: password) { (user, error) in
            if let user = user {
                self.setLoggedInVariables(user)
                print("Successfully signed-in user!")
                self.redirectUser(currentViewController, state: "signed_in")
            } else {
                print("Error signing-in user!")
                UtilitiesHelper.getAlertInstance(currentViewController, title: "Login Error", message: "Error authenticating.", hasTextField: false, textFieldValue: "", type: "ok")
            }
        }
    }

    static func setLoggedInVariables(user: FIRUser) {
        let userRef = FirebaseDBHelper.getUser(user.uid)
        self.loggedIn = true
        self.loggedInUser = User(
            id: "",//userRef.valueForKey("id")!.stringValue!,
            username: userRef.valueForKey("username")!.stringValue!,
            email: userRef.valueForKey("email")!.stringValue!,
            password: userRef.valueForKey("password")!.stringValue!
        )
        print("B")
    }

    static func logOutUser(currentViewController: UIViewController) {
        FirebaseDBHelper.logOut()

        self.unsetLoggedInVariables()
        print("Successfully signed-out user!")
        self.redirectUser(currentViewController, state: "signed_out")
    }

    static func unsetLoggedInVariables() {
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

    static func redirectUser(currentViewController: UIViewController, state: String) {
        let viewController = state == "signed_in" ? "UITabBarControllerMain" : "SignInViewController"
        let storyboard = UtilitiesHelper.getStoryboard()
        let secondViewController = storyboard.instantiateViewControllerWithIdentifier(viewController)// as! UITabBarController
        currentViewController.presentViewController(secondViewController, animated: true, completion: nil)
    }

    /*
    static func redirectSignedInUser(currentViewController: UIViewController) {
        let storyboard = UtilitiesHelper.getStoryboard()
        let secondViewController = storyboard.instantiateViewControllerWithIdentifier("UITabBarControllerMain") as! UITabBarController
        currentViewController.presentViewController(secondViewController, animated: true, completion: nil)
    }

    static func redirectSignedOutUser(currentViewController: UIViewController) {
        let storyboard = UtilitiesHelper.getStoryboard()
        let secondViewController = storyboard.instantiateViewControllerWithIdentifier("SignInViewController")
        currentViewController.presentViewController(secondViewController, animated: true, completion: nil)
    }
    */
}
