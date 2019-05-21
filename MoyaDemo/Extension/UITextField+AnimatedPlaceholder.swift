//
//  UITextField+AnimatedPlaceholder.swift
//  MoyaDemo
//
//  Created by ahmedbahnasy on 5/22/19.
//  Copyright © 2019 ahmed.bahnasy. All rights reserved.
//

import Foundation
import UIKit


typealias PlaceholderAttr = (initialColor: UIColor, activeColor: UIColor, errorColor: UIColor, largeFont: UIFont, smallFont: UIFont)

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
    
    func setupPlaceholder(_ placeholder: String, withAttributes attr: PlaceholderAttr) {
        self.placeholderLabel = UILabel()
        self.placeholderAttr = attr
        let size = placeholder.sizeOfString(usingFont: attr.largeFont)
        self.setupPlaceholderLabel(placeholder: placeholder, size: size)
    }
    
    func setupPlaceholderLabel(placeholder: String, size: CGSize) {
        placeholderLabel.text = placeholder
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
    
    func textFieldDidStartEditing(_ textField: UITextField) {
        placeholderLabel.textColor = self.placeholderAttr.activeColor
        let font = self.placeholderAttr.smallFont
        placeholderLabel.font = font
        let size = placeholderLabel.text?.sizeOfString(usingFont: font)
        
        NSLayoutConstraint.activate([
            placeholderLabel.centerYAnchor.constraint(equalTo: self.topAnchor),
            placeholderLabel.widthAnchor.constraint(equalToConstant: size!.width + 12)
            ])
        UIView.animate(withDuration: 0.5) {
            self.superview?.layoutIfNeeded()
        }
        self.becomeFirstResponder()
        self.layer.borderColor = self.placeholderAttr.activeColor.cgColor
    }
    
    func textFieldDidfinishEditing(_ textField: UITextField) {
        if let text = textField.text?.trimmingCharacters(in: .whitespaces), text.count > 0 {
            textField.layer.borderColor = self.placeholderAttr.initialColor.cgColor
        } else {
            textField.layer.borderColor = self.placeholderAttr.errorColor.cgColor
            placeholderLabel.textColor = self.placeholderAttr.errorColor
        }
    }
}
