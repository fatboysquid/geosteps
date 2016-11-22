import UIKit

class UtilitiesHelper {
    static private let storyboard = UIStoryboard(name: "Main", bundle: nil)

    static func getStoryboard() -> UIStoryboard {
        return storyboard
    }

    static func getAlertInstance(
        currentViewController: UIViewController,
        title: String,
        message: String,
        hasTextField: Bool,
        textFieldValue: String = "",
        type: String
    ) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)

        if true == hasTextField {
            alert.addTextFieldWithConfigurationHandler({
                (textField) -> Void in textField.text = textFieldValue
            })
        }

        // TODO: extend to support passing of callback functions for buttons
        if type == "ok" {
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                print("OK clicked.")
            }))
        }

        currentViewController.presentViewController(alert, animated: true, completion: nil)

        return alert
    }
}
