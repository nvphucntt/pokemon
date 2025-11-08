//
//  ViewController.swift
//  Pokemon
//
//  Created by Van Phu on 27/9/25.
//

import UIKit
import NVActivityIndicatorView

enum Status {
    case home
    case qr1
    case qr2
}

class ViewController: UIViewController {
    
    @IBOutlet weak var bg_imgView: UIImageView!
    
    @IBOutlet weak var downLoadButton: UIButton!
    
    @IBOutlet weak var couponButton: UIButton!
    
    var statusHome: Status = .home
    
    var activityIndicator: NVActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        if DataStore.shared.isComplete {
            self.bg_imgView.image = UIImage(named: "img_6")
            self.showLoadingView()
        } else {
            self.bg_imgView.image = UIImage(named: "img_1")
        }
    }
    
    func showLoadingView() {
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
    
    func configUI() {
        switch self.statusHome {
        case .home:
            self.downLoadButton.isHidden = true
            self.couponButton.isHidden = true
        case .qr1:
            self.downLoadButton.isHidden = false
            self.couponButton.isHidden = true
        case .qr2:
            self.downLoadButton.isHidden = true
            self.couponButton.isHidden = false
        }
    }
    
    @IBAction func didTappedCancelButton(_ sender: Any)
    {
        let homeVC = HomeViewController()
        navigationController?.pushViewController(homeVC, animated: false)
    }
    
    @IBAction func didTappedHomeButton(_ sender: Any) {
        self.bg_imgView.image = UIImage(named: "img_1")
        self.statusHome = .home
        configUI()
    }
    
    @IBAction func didTappedQrButton(_ sender: Any) {
        self.statusHome = .qr1
        self.bg_imgView.image = UIImage(named: "img_2")
        configUI()
    }
    
    @IBAction func didTappedDownloadButton(_ sender: Any) {
        self.statusHome = .qr2
        configUI()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.bg_imgView.image = UIImage(named: "img_3")
        }
    }
    
    @IBAction func didTappedShowCoupon(_ sender: Any) {
        configUI()
        showCouponAlert(on: self)
    }
    
    func showCouponAlert(on viewController: UIViewController) {
        let title = "クーポンを利用しますか"
        
        let message = """
        クーポンには当日まで有効なもの、制限時間内のみ有効なものがありますのでご注意ください。「利用する」を押下すると、もとに戻すことはできません。
        """
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let useAction = UIAlertAction(title: "利用する（元には戻せません）", style: .default) { _ in
            
            let homeVC = HomeViewController()
            self.navigationController?.pushViewController(homeVC, animated: false)
        }
        
        let cancelAction = UIAlertAction(title: "キャンセル）", style: .default) { _ in
            self.dismiss(animated: true)
        }
        
        alert.addAction(useAction)
        alert.addAction(cancelAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }
}

