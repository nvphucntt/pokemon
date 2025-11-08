//
//  HomeViewController.swift
//  Pokemon
//
//  Created by Van Phu on 27/9/25.
//

import UIKit
import NVActivityIndicatorView

class HomeViewController: UIViewController {
    var activityIndicator: NVActivityIndicatorView!
    
    var countdownTimer: Timer?
    var remainingSeconds: Int = 5 * 60
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        updateLabel()
        startCountdown()
    }
    
    
    func startCountdown() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0,
                                              target: self,
                                              selector: #selector(updateCountdown),
                                              userInfo: nil,
                                              repeats: true)
    }
    
    @objc func updateCountdown() {
        if remainingSeconds > 0 {
            remainingSeconds -= 1
            updateLabel()
        } else {
            countdownTimer?.invalidate()
            timeLabel.text = "00:00:00"
            print("⏰ Countdown finished!")
        }
    }
    
    func updateLabel() {
        let hours = remainingSeconds / 3600
        let minutes = (remainingSeconds % 3600) / 60
        let seconds = remainingSeconds % 60
        
        timeLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    @IBAction func didTappedCancelButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
}
