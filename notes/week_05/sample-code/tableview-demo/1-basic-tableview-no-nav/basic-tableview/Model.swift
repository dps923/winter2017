import UIKit
import Foundation

class Model {

    let colorNames: [String]

    init() {
        let path = Bundle.main.path(forResource: "Colors", ofType: "plist")

        // In this case it is an NSArray at the root of the plist,
        // if it is an NSDictionary at the root, then code might look like:
        //  colorDict = NSDictionary(contentsOfFile: path!) as! [String: AnyObject]

        colorNames = NSArray(contentsOfFile: path!) as! [String]
    }

    func getImage(named: String) -> UIImage? {
        return UIImage(named: named)
    }
}
