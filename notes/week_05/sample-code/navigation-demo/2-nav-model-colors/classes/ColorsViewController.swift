
import UIKit

class ColorsViewController: UIViewController {

    var model: Model! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let colorName = segue.identifier!
        let detail = segue.destination as! ColorDetailViewController
        detail.model = model
        detail.colorName = colorName

        detail.title = "A title"
     }
}

