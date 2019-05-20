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
    
    let placeholderLabel: UILabel = {
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
    
    func setupTextView() {
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1).cgColor
        self.clipsToBounds = true
        self.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10, height: self.frame.height))
        //self.leftView?.backgroundColor = UIColor.red
        self.leftViewMode = UITextField.ViewMode.always
    }
    func setupPlaceholder(withPlaceholder placeholder: String, usingFont font: UIFont) {
        let size = placeholder.sizeOfString(usingFont: font)
        self.setupPlaceholderContainerView(size: size)
        self.setupPlaceholderLabel(placeholder: placeholder, size: size)
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
    func setupPlaceholderLabel(placeholder: String, size: CGSize) {
//        placeholderLabel.frame = CGRect.init(x: 0, y: 0, width: size.width + 5, height: size.height)
//        placeholderLabel.center = CGPoint(x: placeholderContainerView.bounds.midX, y: placeholderContainerView.bounds.midY)
//        placeholderLabel.text = placeholder
//        placeholderLabel.textColor = UIColor.white
//        placeholderLabel.textAlignment = .center
//        placeholderLabel.numberOfLines = 1
        
        placeholderLabel.text = placeholder
        self.placeholderContainerView.addSubview(placeholderLabel)
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: self.placeholderContainerView.leadingAnchor, constant: 2),
            placeholderLabel.trailingAnchor.constraint(equalTo: self.placeholderContainerView.trailingAnchor, constant: -2),
            placeholderLabel.centerYAnchor.constraint(equalTo: self.placeholderContainerView.centerYAnchor),
            //placeholderLabel.widthAnchor.constraint(equalToConstant: size.width + 15),
            placeholderLabel.heightAnchor.constraint(equalToConstant: size.height)
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
        placeholderLabel.textColor = UIColor(red: 0, green: 0.73, blue: 0.71, alpha: 1)
        placeholderLabel.font = UIFont(name: "HelveticaNeue", size: CGFloat(12))
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        textFieldDidStartEditing()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
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
