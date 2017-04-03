import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var playPauseButton: UIButton!
  
    var soundPlayer: AVAudioPlayer? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSoundPlayer()
    }

    func setupSoundPlayer() {
        guard let soundData = NSDataAsset(name: "At Last") else {
            print("asset not found")
            return
        }

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)

            soundPlayer = try AVAudioPlayer(data: soundData.data, fileTypeHint: AVFileTypeMPEGLayer3)
        } catch {
            print(error)
        }
    }

    @IBAction func playPausePressed(_ sender: UIButton) {
        guard let soundPlayer = soundPlayer else {
            print("No sound set!")
            return
        }

        if soundPlayer.isPlaying {
            soundPlayer.pause()
            playPauseButton.setTitle("Play", for: .normal)
        } else {
            soundPlayer.play()
            playPauseButton.setTitle("Pause", for: .normal)
        }
    }

    @IBAction func volumeChanged(_ sender: UISlider) {
        soundPlayer?.volume = sender.value
    }
}

