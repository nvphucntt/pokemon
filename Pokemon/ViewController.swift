//
//  ViewController.swift
//  Pokemon
//
//  Created by Van Phu on 27/9/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    var countdownTimer: Timer?
    var remainingSeconds: Int = 5 * 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        updateLabel()
        startCountdown()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func didTappedCancelButton(_ sender: Any)
    {
        let homeVC = HomeViewController()
        navigationController?.pushViewController(homeVC, animated: false)
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
}

