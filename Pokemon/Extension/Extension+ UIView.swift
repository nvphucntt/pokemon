//
//  UIView + Extensions.swift
//  FimasFlower
//
//  Created by Van Phu on 12/12/24.
//

import UIKit

extension UIView {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    static var name: String {
        return String(describing: self)
    }

    var parentViewController: UIViewController? {
        get {
            let retValue: UIViewController?
            var responder: UIResponder? = self

            while nil != responder && !(responder is UIViewController) {
                responder = responder?.next
            }

            if let viewCtrl = responder as? UIViewController {
                retValue = viewCtrl
            }
            else {
                retValue = nil
            }
            return retValue
        }
    }
}

extension UIView {

  var safeTopAnchor: NSLayoutYAxisAnchor {
    if #available(iOS 11.0, *) {
      return safeAreaLayoutGuide.topAnchor
    }
    return topAnchor
  }

  var safeLeftAnchor: NSLayoutXAxisAnchor {
    if #available(iOS 11.0, *){
      return safeAreaLayoutGuide.leftAnchor
    }
    return leftAnchor
  }

  var safeRightAnchor: NSLayoutXAxisAnchor {
    if #available(iOS 11.0, *){
      return safeAreaLayoutGuide.rightAnchor
    }
    return rightAnchor
  }

  var safeBottomAnchor: NSLayoutYAxisAnchor {
    if #available(iOS 11.0, *) {
      return safeAreaLayoutGuide.bottomAnchor
    }
    return bottomAnchor
  }
}

extension UITextField{
   @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
            
        }
    }
}

@IBDesignable
extension UITextField {
    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
}

extension UILabel {
    var isTruncated: Bool {

        guard let labelText = text else {
            return false
        }

        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: .greatestFiniteMagnitude, height: frame.size.height),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font as Any],
            context: nil).size

        return labelTextSize.width > bounds.size.width
    }
}

extension UIView {
    func layerGradient() {
        let layer : CAGradientLayer = CAGradientLayer()
        layer.frame = self.bounds
        layer.startPoint = CGPoint(x: 0.0, y: 0.0)
        layer.endPoint = CGPoint(x: 1.0, y: 1.0)

        let color0 = UIColor(red: 254/255, green: 169/255, blue: 123/255, alpha: 1.0).cgColor
        let color1 = UIColor(red: 254/255, green: 149/255, blue: 111/255, alpha: 1.0).cgColor
        let color2 = UIColor(red: 254/255, green: 91/255, blue: 77/255, alpha: 1.0).cgColor
        let color3 = UIColor(red: 254/255, green: 91/255, blue: 77/255, alpha: 1.0).cgColor

        layer.colors = [color0, color1, color2, color3]
        self.layer.insertSublayer(layer, at: 0)
    }
}

extension UIImageView {
    func setImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
        task.resume()
    }
}

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}


extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    // Bóng đổ - Độ dịch chuyển X
    @IBInspectable
    var shadowX: CGFloat {
        get { return layer.shadowOffset.width }
        set { layer.shadowOffset.width = newValue }
    }
    
    // Bóng đổ - Độ dịch chuyển Y
    @IBInspectable
    var shadowY: CGFloat {
        get { return layer.shadowOffset.height }
        set { layer.shadowOffset.height = newValue }
    }
    
    // Bóng đổ - Độ mờ (blur)
    @IBInspectable
    var shadowBlur: CGFloat {
        get { return layer.shadowRadius * 2 }
        set { layer.shadowRadius = newValue / 2 }
    }
    
    // Bóng đổ - Độ lan rộng (spread)
    @IBInspectable
    var shadowSpread: CGFloat {
        get { return 0 } // Không có giá trị trực tiếp để lấy, chỉ hỗ trợ set
        set {
            if newValue == 0 {
                layer.shadowPath = nil
            } else {
                let rect = bounds.insetBy(dx: -newValue, dy: -newValue)
                layer.shadowPath = UIBezierPath(rect: rect).cgPath
            }
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

extension UIView {
    
    func roundCorners(_ corners: CACornerMask, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
           self.layer.maskedCorners = corners
           self.layer.cornerRadius = radius
           self.layer.borderWidth = borderWidth
           self.layer.borderColor = borderColor.cgColor

       }
    
    
    func addBorder(toEdges edges: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        func addBorder(toEdge edges: UIRectEdge, color: UIColor, thickness: CGFloat) {
            let border = CALayer()
            border.backgroundColor = color.cgColor
            
            switch edges {
            case .top:
                border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
            case .bottom:
                border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
            case .left:
                border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
            case .right:
                border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
            default:
                break
            }
            
            layer.addSublayer(border)
        }
        
        if edges.contains(.top) || edges.contains(.all) {
            addBorder(toEdge: .top, color: color, thickness: thickness)
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(toEdge: .bottom, color: color, thickness: thickness)
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            addBorder(toEdge: .left, color: color, thickness: thickness)
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            addBorder(toEdge: .right, color: color, thickness: thickness)
        }
    }
    
    func addBorder(color: UIColor = .black, margins: CGFloat = 1, borderLineSize: CGFloat = 1) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: .height,
                                                relatedBy: .equal,
                                                toItem: nil,
                                                attribute: .height,
                                                multiplier: 1, constant: borderLineSize))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .bottom,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: .leading,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .leading,
                                              multiplier: 1, constant: margins))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: .trailing,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .trailing,
                                              multiplier: 1, constant: margins))
    }
}
/**
 * Extends UIView with shortcut methods
 *
 * @author Alexander Volkov
 * @version 1.0
 */
extension UIView {
    
    /// Adds bottom border to the view with given side margins
    ///
    /// - Parameters:
    ///   - color: the border color
    ///   - margins: the left and right margin
    ///   - borderLineSize: the size of the border
   
    
    
    func addBottomBorder(color: UIColor = .black, margins: CGFloat = 1, borderLineSize: CGFloat = 1) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: .height,
                                                relatedBy: .equal,
                                                toItem: nil,
                                                attribute: .height,
                                                multiplier: 1, constant: borderLineSize))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .bottom,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: .leading,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .leading,
                                              multiplier: 1, constant: margins))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: .trailing,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .trailing,
                                              multiplier: 1, constant: margins))
    } }


extension UIButton {
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }

    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}

extension UITabBar {
    
    static func setTransparentTabbar() {
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().clipsToBounds = true
    }
    
}
extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }
    
}

extension UIView {
    func findFirstResponder() -> UIView? {
        if self.isFirstResponder {
            return self
        }
        for subview in subviews {
            if let responder = subview.findFirstResponder() {
                return responder
            }
        }
        return nil
    }
}

extension UIColor {
    /**
     * UInt32表記カラーをUIColorに変換する。
     * 例: UIColor.colorWithRGBA(0xFF0000FF) // red
     */
    class func colorWithRGBA(_ hex: UInt32) -> UIColor {
        let r = CGFloat((hex & 0xFF000000) >> 24) / 255.0
        let g = CGFloat((hex & 0x00FF0000) >> 16) / 255.0
        let b = CGFloat((hex & 0x0000FF00) >> 8) / 255.0
        let a = CGFloat(hex & 0x000000FF) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }

    /// rgba表記カラーをUIColorに変換する
    /// - parameter rgba rgba表記で色を指定する
    /// - returns rgbaで指定された色データを保持するUIColorインスタンスを返却する
    class func color(rgba: UInt32) -> UIColor {
        return Self.colorWithRGBA(rgba)
    }

    /// rgb表記カラーをUIColorに変換する
    /// - parameter rgb rgb表記で色を指定する
    /// - parameter alpha 不透明度を指定する
    /// - returns rgbaで指定された色データを保持するUIColorインスタンスを返却する
    class func color(rgb: UInt32, alpha: CGFloat) -> UIColor {
        var retValue: UIColor
        var rgba: UInt32
        rgba = rgb << 8

        retValue = Self.color(rgba: rgba)
        retValue = retValue.withAlphaComponent(alpha)
        return retValue
    }

    /// rgb表記カラーを不透明度100%のUIColorに変換する
    /// - parameter rgb rgb表記で色を指定する
    /// - returns rgbaで指定された色データを保持するUIColorインスタンスを返却する
    class func color(rgb: UInt32) -> UIColor {
        return Self.color(rgb: rgb, alpha: 1.0)
    }
}
