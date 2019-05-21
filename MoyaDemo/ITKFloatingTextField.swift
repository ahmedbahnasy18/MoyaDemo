//
//  ITKFloatingTextField.swift
//  MoyaDemo
//
//  Created by ahmed.bahnasy on 5/19/19.
//  Copyright © 2019 ahmed.bahnasy. All rights reserved.
//

import UIKit

class ITKFloatingTextField: UITextField {

    //var placeholderLabel = UILabel()
    //var placeholderContainerView = UIView()
    
    let placeholderLabell: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue", size: CGFloat(17))
        label.textAlignment = .center
        label.numberOfLines = 1
        label.backgroundColor = UIColor.cyan
        return label
    }()
    
    let placeholderContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor.black
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    
    func initialize() {
        
        self.setupTextView()
        self.setupPlaceholder(withPlaceholder: "passowrd / and email ad", usingFont: UIFont(name: "HelveticaNeue", size: CGFloat(17))!)
    }
    @discardableResult
    func addBorders(edges: UIRectEdge,
                    color: UIColor,
                    inset: CGFloat = 0.0,
                    thickness: CGFloat = 1.0) -> [UIView] {
        
        var borders = [UIView]()
        
        @discardableResult
        func addBorder(formats: String...) -> UIView {
            let border = UIView(frame: .zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            addSubview(border)
            addConstraints(formats.flatMap {
                NSLayoutConstraint.constraints(withVisualFormat: $0,
                                               options: [],
                                               metrics: ["inset": inset, "thickness": thickness],
                                               views: ["border": border]) })
            borders.append(border)
            return border
        }
        
        
        if edges.contains(.top) || edges.contains(.all) {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }
        
        return borders
    }
    
    // Usage:
    
    func setupTextView() {
        //self.layer.cornerRadius = 8
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1).cgColor
//        self.clipsToBounds = true
//        self.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10, height: self.frame.height))
//        //self.leftView?.backgroundColor = UIColor.red
//        self.leftViewMode = UITextField.ViewMode.always
        
        
//        self.addBorders(edges: [.all], color: <#UIColor#>) // All with default arguments
//        self.addBorders(edges: [.top], color: .green) // Just Top, green, default thickness
        self.addBorders(edges: [.left, .right, .bottom], color: .red, thickness: 1) // All except Top, red, thickness 3
        
    }
    func setupPlaceholder(withPlaceholder placeholder: String, usingFont font: UIFont) {
        let size = placeholder.sizeOfString(usingFont: font)
        self.setupPlaceholderContainerView(size: size)
        self.setupPlaceholderLabell(placeholder: placeholder, size: size)
    }
    func setupPlaceholderContainerView(size: CGSize) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        placeholderContainerView.addGestureRecognizer(tap)
        self.addSubview(placeholderContainerView)
        NSLayoutConstraint.activate([
            placeholderContainerView.leftAnchor.constraint(equalTo: self.leftAnchor),
            placeholderContainerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            placeholderContainerView.widthAnchor.constraint(equalToConstant: size.width + 15),
            placeholderContainerView.heightAnchor.constraint(equalToConstant: size.height)
            ])
    }
    func setupPlaceholderLabell(placeholder: String, size: CGSize) {
//        placeholderLabel.frame = CGRect.init(x: 0, y: 0, width: size.width + 5, height: size.height)
//        placeholderLabel.center = CGPoint(x: placeholderContainerView.bounds.midX, y: placeholderContainerView.bounds.midY)
//        placeholderLabel.text = placeholder
//        placeholderLabel.textColor = UIColor.white
//        placeholderLabel.textAlignment = .center
//        placeholderLabel.numberOfLines = 1
        
        placeholderLabell.text = placeholder
        self.placeholderContainerView.addSubview(placeholderLabell)
        NSLayoutConstraint.activate([
            placeholderLabell.leadingAnchor.constraint(equalTo: self.placeholderContainerView.leadingAnchor, constant: 2),
            placeholderLabell.trailingAnchor.constraint(equalTo: self.placeholderContainerView.trailingAnchor, constant: -2),
            placeholderLabell.centerYAnchor.constraint(equalTo: self.placeholderContainerView.centerYAnchor),
            //placeholderLabel.widthAnchor.constraint(equalToConstant: size.width + 15),
            placeholderLabell.heightAnchor.constraint(equalToConstant: size.height)
            ])
    }
    
//    func setupPlaceholderLabel(placeholder: String, size: CGSize) {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
//        placeholderLabel.addGestureRecognizer(tap)
//        placeholderLabel.text = placeholder
//        self.addSubview(placeholderLabel)
//        NSLayoutConstraint.activate([
//            placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
//            placeholderLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            placeholderLabel.widthAnchor.constraint(equalToConstant: size.width + 15),
//            placeholderLabel.heightAnchor.constraint(equalToConstant: size.height)
//            ])
//    }
    
    func textFieldDidStartEditing() {
        NSLayoutConstraint.activate([
            placeholderContainerView.centerYAnchor.constraint(equalTo: self.topAnchor)
            ])
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
        self.becomeFirstResponder()
        self.layer.borderColor = UIColor(red: 0, green: 0.73, blue:0.71, alpha: 1).cgColor
        placeholderLabell.textColor = UIColor(red: 0, green: 0.73, blue: 0.71, alpha: 1)
        placeholderLabell.font = UIFont(name: "HelveticaNeue", size: CGFloat(12))
        self.clipsToBounds = false
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        textFieldDidStartEditing()
    }
    
}

extension String {
    var stringWidth: CGFloat {
        let constraintRect = CGSize(width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude)
        let boundingBox = self.trimmingCharacters(in: .whitespacesAndNewlines).boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
        return boundingBox.width
    }
    
    var stringHeight: CGFloat {
        let constraintRect = CGSize(width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude)
        let boundingBox = self.trimmingCharacters(in: .whitespacesAndNewlines).boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
        return boundingBox.height
    }
}


extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
}


extension UITextField {
    
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

extension UITextField {
    func addTopBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.black.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
        
    }
    
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect.init(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.white.cgColor
        
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "-", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
        
    }
}


extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer();
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x:0, y:self.frame.height - thickness, width:self.frame.width, height:thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x:0, y:0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x:self.frame.width - thickness, y: 0, width: thickness, height:self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
    
}
