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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        activityIndicator = NVActivityIndicatorView(frame: frame,
                                                    type: .ballSpinFadeLoader, // kiểu gần giống hình bạn
                                                    color: .red,
                                                    padding: 0)
        
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.activityIndicator.stopAnimating()
        }
    }
}
