import UIKit

class UtilitiesHelper {
    static private let storyboard = UIStoryboard(name: "Main", bundle: nil)

    static func getStoryboard() -> UIStoryboard {
        return storyboard
    }

    static func getAlertInstance(currentViewController: UIViewController, title: String, message: String, hasTextField: Bool, textFieldValue: String = "") -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)

        if true == hasTextField {
            alert.addTextFieldWithConfigurationHandler({
                (textField) -> Void in textField.text = textFieldValue
            })
        }

        currentViewController.presentViewController(alert, animated: true, completion: nil)

        return alert
    }
}
