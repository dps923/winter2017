import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var playPauseButton: UIButton!
  
    var soundPlayer: AVAudioPlayer? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSoundPlayer()
    }

    func setupSoundPlayer() {
        let url = URL(string: "http://example.com/movie.mov")
        let player = AVPlayer(url: url!)

        let playerViewController = AVPlayerViewController()
        playerViewController.player = player

        present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
        
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

