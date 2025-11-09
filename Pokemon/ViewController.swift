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
    case qrDone
    case home2
    case home4
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var bg_imgView: UIImageView!
    @IBOutlet weak var downLoadButton: UIButton!
    @IBOutlet weak var couponButton: UIButton!
    @IBOutlet weak var isValidView: UIView!
    @IBOutlet weak var topLineView: UIView!
    
    let screenBounds = UIScreen.main.bounds
    var statusHome: Status = .home
    var activityIndicator: NVActivityIndicatorView!
    
    private var maskView: UIView!
    private var overlayImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        maskView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 120))
        maskView.clipsToBounds = true
        view.addSubview(maskView)

        overlayImageView = UIImageView(frame: screenBounds)
        overlayImageView.image = UIImage(named: "img_6")
        overlayImageView.contentMode = .scaleAspectFill
        maskView.addSubview(overlayImageView)
        self.view.bringSubviewToFront(self.topLineView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.isValidView.isHidden = !DataStore.shared.isAfter9PMTomorrowInJapan()
        self.isValidView.isHidden = true
        
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
                                                    type: .ballSpinFadeLoader,
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
            self.maskView.isHidden = false
            self.overlayImageView.isHidden = false
        case .home2, .home4:
            self.downLoadButton.isHidden = true
            self.couponButton.isHidden = true
            self.maskView.isHidden = true
            self.overlayImageView.isHidden = true
        case .qr1:
            self.downLoadButton.isHidden = false
            self.couponButton.isHidden = true
            self.maskView.isHidden = true
            self.overlayImageView.isHidden = true
        case .qr2:
            self.downLoadButton.isHidden = true
            self.couponButton.isHidden = false
            self.maskView.isHidden = true
            self.overlayImageView.isHidden = true
        case .qrDone:
            self.downLoadButton.isHidden = true
            self.couponButton.isHidden = true
            self.maskView.isHidden = true
            self.overlayImageView.isHidden = true
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
    
    @IBAction func didTappedHome2Button(_ sender: Any) {
        self.bg_imgView.image = UIImage(named: "img_8")
        self.statusHome = .home2
        configUI()
    }
    
    
    @IBAction func didTappedQrButton(_ sender: Any) {
        if DataStore.shared.isComplete {
            self.statusHome = .qrDone
            self.bg_imgView.image = UIImage(named: "img_601")
        } else {
            self.statusHome = .qr1
            self.bg_imgView.image = UIImage(named: "img_2")
        }
        configUI()
    }
    
    @IBAction func didTappedHome4Button(_ sender: Any) {
        self.bg_imgView.image = UIImage(named: "img_7")
        self.statusHome = .home4
        configUI()
    }
    
    @IBAction func didTappedHome5Button(_ sender: Any) {
        if let url = URL(string: "https://auth.7id.omni7.jp/login-id/input?appid=bpc&userhash=GZKS74DFBQP6VCNTDWUWAER732PBZGPIV2AGS6I&ts=1762610319&tn=1762610319342GZKS74DFBQP6VCNTDWUWAER732PBZGPIV2AGS6I990&sig=2333f9b4d35c95909b17bfdb9827bee74a0a56de&ksappcd=03&ksappsitecd=0003&r_url=&utmparam=utm_campaign%3Diy_7mp%26utm_medium%3Dapp%26utm_source%3Dapp_iy") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
        if DataStore.shared.isComplete {
            self.bg_imgView.image = UIImage(named: "img_6")
        } else {
            self.bg_imgView.image = UIImage(named: "img_1")
        }
        self.statusHome = .home
        configUI()
        
    }
    
    
    @IBAction func didTappedDownloadButton(_ sender: Any) {
        self.statusHome = .qr2
        configUI()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
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
        
        let useAction = UIAlertAction(title: "利用する（元には戻せません)", style: .default) { _ in
            
            let homeVC = HomeViewController()
            self.navigationController?.pushViewController(homeVC, animated: false)
        }
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .default) { _ in
            self.dismiss(animated: true)
        }
        
        alert.addAction(useAction)
        alert.addAction(cancelAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }
}

