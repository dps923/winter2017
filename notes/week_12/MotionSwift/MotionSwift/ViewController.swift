import UIKit
import CoreMotion


class ViewController: UIViewController {

    let mgr = CMMotionManager()

    @IBOutlet weak var orientationStatus: UILabel!
    @IBOutlet weak var accelerometerX: UILabel!
    @IBOutlet weak var accelerometerY: UILabel!
    @IBOutlet weak var accelerometerZ: UILabel!
    @IBOutlet weak var gyroscopeX: UILabel!
    @IBOutlet weak var gyroscopeY: UILabel!
    @IBOutlet weak var gyroscopeZ: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if !mgr.isAccelerometerAvailable {
            showError()
            return
        }

        mgr.gyroUpdateInterval = 0.5
        mgr.accelerometerUpdateInterval = 0.5

        mgr.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
            if let error = error {
                self.mgr.stopAccelerometerUpdates()
                print(error)
                return
            }
            if let accel = data?.acceleration {
                self.accelerometerX.text = "\(accel.x)"
                self.accelerometerY.text = "\(accel.y)"
                self.accelerometerZ.text = "\(accel.z)"

            }
        }

        mgr.startGyroUpdates(to: OperationQueue.main) { (data, error) in

            if let error = error {
                self.mgr.stopGyroUpdates()
                print(error)
                return
            }

            if let gyro = data?.rotationRate {
                self.gyroscopeX.text = "\(gyro.x)"
                self.gyroscopeY.text = "\(gyro.y)"
                self.gyroscopeZ.text = "\(gyro.z)"
            }

            // Use the periodic updates of the gyro to update the orientation label
            switch (self.interfaceOrientation) {
            case .portrait:
                self.orientationStatus.text = "Portrait"

            case .landscapeLeft:
                self.orientationStatus.text = "Landscape left"

            case .landscapeRight:
                self.orientationStatus.text = "Landscape right"

            default:
                break
            }
        }
    }

    func showError() {
        orientationStatus.text = "App won't work on this device"
    }
}

