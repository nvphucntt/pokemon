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
    
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var countdownTimer: Timer?
    var remainingSeconds: Int = 5 * 60
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        updateConstraint()
        updateLabel()
        startCountdown()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateConstraint()
    }
    
    func startCountdown() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0,
                                              target: self,
                                              selector: #selector(updateCountdown),
                                              userInfo: nil,
                                              repeats: true)
    }
    
    func updateConstraint() {
        switch DataStore.shared.currentDevice {
        case .small_se:
            trailingConstraint.constant = 55
            bottomConstraint.constant = 175
            widthConstraint.constant = 128
            heightConstraint.constant = 26
            self.timeLabel.font = UIFont.boldSystemFont(ofSize: 18)
        case .small_6_7_8:
            trailingConstraint.constant = 55
            bottomConstraint.constant = 175
            widthConstraint.constant = 128
            heightConstraint.constant = 26
            self.timeLabel.font = UIFont.boldSystemFont(ofSize: 18)
        case .medium_x_xs_11Pro:
            trailingConstraint.constant = 108
            bottomConstraint.constant = 246.0
            widthConstraint.constant = 128
            heightConstraint.constant = 34
            self.timeLabel.font = UIFont.boldSystemFont(ofSize: 26)
        case .large_xr_11:
            trailingConstraint.constant = 108
            bottomConstraint.constant = 246.0
            widthConstraint.constant = 128
            heightConstraint.constant = 34
            self.timeLabel.font = UIFont.boldSystemFont(ofSize: 26)
        case .large_12normal:
            trailingConstraint.constant = 84
            bottomConstraint.constant = 228.0
            widthConstraint.constant = 140
            heightConstraint.constant = 34
            self.timeLabel.font = UIFont.boldSystemFont(ofSize: 27)
        case .large_12Pro:
            trailingConstraint.constant = 99.0
            bottomConstraint.constant = 228.0
            widthConstraint.constant = 128
            heightConstraint.constant = 34
            self.timeLabel.font = UIFont.boldSystemFont(ofSize: 27)
        case .pro_14Pro_15Pro:
            trailingConstraint.constant = 84
            bottomConstraint.constant = 232
            widthConstraint.constant = 140
            heightConstraint.constant = 34
            self.timeLabel.font = UIFont.boldSystemFont(ofSize: 28)
        case .proMax_14ProMax:
            trailingConstraint.constant = 104
            bottomConstraint.constant = 256
            widthConstraint.constant = 140
            heightConstraint.constant = 34
            self.timeLabel.font = UIFont.boldSystemFont(ofSize: 30)
        case .proMax_15ProMax:
            trailingConstraint.constant = 114
            bottomConstraint.constant = 268
            widthConstraint.constant = 140
            heightConstraint.constant = 34
            self.timeLabel.font = UIFont.boldSystemFont(ofSize: 30)
        case .large_xsmax_11ProMax:
            trailingConstraint.constant = 108
            bottomConstraint.constant = 244
            widthConstraint.constant = 128
            heightConstraint.constant = 34
            self.timeLabel.font = UIFont.boldSystemFont(ofSize: 29)
        case .other:
            trailingConstraint.constant = 99.0
            bottomConstraint.constant = 228.0
            widthConstraint.constant = 128
            heightConstraint.constant = 34
            self.timeLabel.font = UIFont.boldSystemFont(ofSize: 27)
        
        }
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
        DataStore.shared.isComplete = true
        self.navigationController?.popViewController(animated: false)
    }
    
}
