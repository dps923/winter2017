import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!

    var rowNumber: Int? = nil

    func getSplitView() -> UISplitViewController {
        return UIApplication.shared.keyWindow?.rootViewController as! UISplitViewController
    }

    override func viewDidLoad() {
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = getSplitView().displayModeButtonItem

        if let rowNumber = rowNumber {
            label.text = "Row Num \(rowNumber)"
        }
    }
}

