
import UIKit

class ColorDetailViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    var model: Model! = nil
    var colorName = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        label.text = colorName;
        imageView.image = model.getImage(named: colorName)
    }
}
