
import UIKit

class ViewController: UIViewController {

    var model: Model! = nil

     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detail = segue.destination as! DetailViewController
            detail.model = model
        }
     }


}

