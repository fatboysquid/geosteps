import UIKit
import SwiftMongoDB

class DBHelper {
    static private var connectionSuccess:Bool = false
    static private let connection:MongoDB = MongoDB(database: "geo")

    static func showConnectionError(viewController: UIViewController) {
        print("Database connection error")
        let alert = UtilitiesHelper.getAlertInstance(viewController, title: "Error", message: "There was a problem connecting to the database. Please try again later.", hasTextField: false, textFieldValue: "")
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            print("OK clicked.")
        }))
    }

    static func getConnectionSuccess() -> Bool {
        return self.connection.connectionStatus == .Success
    }

    static func getConnection() -> MongoDB {
        return self.connection
    }
}
