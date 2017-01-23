import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var temperatureSlider: UISlider!
    @IBOutlet weak var segmentedControlLabel: UILabel!
    @IBOutlet weak var temperatureSliderLabel: UILabel!
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!

    @IBOutlet weak var segmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // This is an example of setting the initial state in code
        // Without doing this, you would see the placeholders like "<label>"
        // I didn't do it for each interface element, perhaps you could add this
        if let title = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex) {
            segmentedControlLabel.text = "Initial state: \(title)"
        }
    }

    @IBAction func temperatureSliderChanged(_ sender: UISlider) {
        temperatureSliderLabel.text = "Slider is \(sender.value)" + " (min \(sender.minimumValue), max \(sender.maximumValue)))"
    }

    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        if let title = sender.titleForSegment(at: sender.selectedSegmentIndex) {
            segmentedControlLabel.text = "Segment index \(sender.selectedSegmentIndex + 1) of \(sender.numberOfSegments), labelled '\(title)' is selected"
        } else {
            print("Uh oh. Error here, we expected a title to be available on the selected segment")
        }
    }

    @IBAction func switchChanged(_ sender: UISwitch) {
        let onOrOffText = sender.isOn ? "On" : "Off"
        switchLabel.text = "The switch is \(onOrOffText)"
    }

    @IBAction func stepperChanged(_ sender: UIStepper) {
        var message = "\(sender.value)"
        if sender.value > 29 {
            message += " (old)"
        }

        ageLabel.text = message
    }

}

