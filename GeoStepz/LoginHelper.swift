import UIKit

// file not being used currently
class LoginHelper {
    static private var loggedIn:Bool = false
    static private var loggedInUser:User? = nil

    static func logInUser(user: User, currentViewController: UIViewController, targetViewControllerName: String) {
        self.loggedIn = true
        self.loggedInUser = user

        let storyboard = UtilitiesHelper.getStoryboard()
        let secondViewController = storyboard.instantiateViewControllerWithIdentifier(targetViewControllerName) as! MapViewController
        currentViewController.presentViewController(secondViewController, animated: true, completion: nil)
    }

    static func logOutUser() {
        self.loggedIn = false
    }

    static func getLoggedInUser() -> User {
        return loggedInUser!
    }
}
