//
//  UITextField+AnimatedPlaceholder.swift
//  MoyaDemo
//
//  Created by ahmedbahnasy on 5/22/19.
//  Copyright © 2019 ahmed.bahnasy. All rights reserved.
//

import Foundation
import UIKit


typealias PlaceholderAttr = (text: String, initialColor: UIColor, activeColor: UIColor, errorColor: UIColor, largeFont: UIFont, smallFont: UIFont)

fileprivate var associatedObjectHandle: UInt8 = 0
fileprivate var labelAssociatedObjectHandle: UInt8 = 99

extension UITextField {
    
    var placeholderAttr: PlaceholderAttr {
        get {
            return objc_getAssociatedObject(self, &associatedObjectHandle) as! PlaceholderAttr
        }
        set {
            objc_setAssociatedObject(self, &associatedObjectHandle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var placeholderLabel: UILabel {
        get {
            return objc_getAssociatedObject(self, &labelAssociatedObjectHandle) as! UILabel
        }
        set {
            objc_setAssociatedObject(self, &labelAssociatedObjectHandle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addAnimatedPlacholder(withPlaceholderAttributes attr: PlaceholderAttr) {
        self.placeholderAttr = attr
        self.setupViews()
    }
    
    func setupViews() {
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = self.placeholderAttr.initialColor.cgColor
        self.clipsToBounds = true
        self.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10, height: self.frame.height))
        self.leftViewMode = UITextField.ViewMode.always
        self.setupPlaceholderLabel()
    }
    
    func setupPlaceholderLabel() {
        self.placeholderLabel = UILabel()
        let size = self.placeholderAttr.text.sizeOfString(usingFont: self.placeholderAttr.largeFont)
        placeholderLabel.text = self.placeholderAttr.text
        placeholderLabel.textColor = self.placeholderAttr.initialColor
        placeholderLabel.font = self.placeholderAttr.largeFont
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.textAlignment = .center
        placeholderLabel.numberOfLines = 1
        placeholderLabel.backgroundColor = UIColor.white
        self.superview?.addSubview(placeholderLabel)
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            placeholderLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            placeholderLabel.widthAnchor.constraint(equalToConstant: size.width + 10),
            placeholderLabel.heightAnchor.constraint(equalToConstant: size.height)
            ])
    }
    
    func textFieldDidStartEditing() {
        self.becomeFirstResponder()
        self.layer.borderColor = self.placeholderAttr.activeColor.cgColor
        guard let placeholder = self.placeholderLabel.text?.trimmingCharacters(in: .whitespaces), placeholder.count > 0 else {return}
        placeholderLabel.textColor = self.placeholderAttr.activeColor
        let font = self.placeholderAttr.smallFont
        placeholderLabel.font = font
        guard let size = placeholderLabel.text?.sizeOfString(usingFont: font) else {return}
        
        NSLayoutConstraint.activate([
            placeholderLabel.centerYAnchor.constraint(equalTo: self.topAnchor),
            placeholderLabel.widthAnchor.constraint(equalToConstant: size.width + 12)
            ])
        UIView.animate(withDuration: 0.5) {
            self.superview?.layoutSubviews()
        }
    }
    
    func textFieldDidfinishEditing() {
        if let text = self.text?.trimmingCharacters(in: .whitespaces), text.count > 0 {
            self.layer.borderColor = self.placeholderAttr.initialColor.cgColor
        } else {
            self.layer.borderColor = self.placeholderAttr.errorColor.cgColor
            placeholderLabel.textColor = self.placeholderAttr.errorColor
        }
    }
    
    
    func validate(type: ValidationType, completion: @escaping (_ result: ValidationResult) -> ()) {
        let res = Validation.shared.validate(values: (type, self.text ?? ""))
        switch res {
        case .success:
            self.layer.borderColor = self.placeholderAttr.initialColor.cgColor
            completion(.success)
            break
        case .failure(let message):
            self.layer.borderColor = self.placeholderAttr.errorColor.cgColor
            placeholderLabel.textColor = self.placeholderAttr.errorColor
            completion(.failure(message))
        }
    }
}
