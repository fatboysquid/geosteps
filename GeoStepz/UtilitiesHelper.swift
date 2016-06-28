import UIKit

class UtilitiesHelper {
    static func getAlertInstance(title: String, message: String, hasTextField: Bool, textFieldValue: String = "") -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)

        if true == hasTextField {
            alert.addTextFieldWithConfigurationHandler({
                (textField) -> Void in textField.text = textFieldValue
            })
        }

        return alert
    }
}
