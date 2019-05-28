//
//  SecondVC.swift
//  MoyaDemo
//
//  Created by ahmedbahnasy on 5/20/19.
//  Copyright © 2019 ahmed.bahnasy. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {

    @IBOutlet weak var textView: UITextField!
    @IBOutlet weak var pass_TF: UITextField!
    @IBOutlet weak var email_TF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        let activeColor = UIColor(red: 0, green: 0.73, blue:0.71, alpha: 1)
        let errorColor = UIColor(red:0.94, green:0.43, blue:0.28, alpha:1)
        let largeFont = UIFont(name: "HelveticaNeue", size: CGFloat(17))
        let smallFont = UIFont(name: "HelveticaNeue", size: CGFloat(12))
        
        let attr1 = PlaceholderAttr(text: "email", initialColor: initialColor, activeColor: activeColor, errorColor: errorColor, largeFont: largeFont!, smallFont: smallFont!)
        let attr2 = PlaceholderAttr(text: "password", initialColor: initialColor, activeColor: activeColor, errorColor: errorColor, largeFont: largeFont!, smallFont: smallFont!)
        let attr3 = PlaceholderAttr(text: "campus / school", initialColor: initialColor, activeColor: activeColor, errorColor: errorColor, largeFont: largeFont!, smallFont: smallFont!)
        
        textView.delegate = self
        self.textView.addAnimatedPlacholder(withPlaceholderAttributes: attr1)
        
        pass_TF.delegate = self
        self.pass_TF.addAnimatedPlacholder(withPlaceholderAttributes: attr2)
        
        email_TF.delegate = self
        self.email_TF.addAnimatedPlacholder(withPlaceholderAttributes: attr3)

        
        
//        let response = Validation.shared.validate(values: (ValidationType.email, "hello@gmail.com"))
//        switch response {
//        case .success:
//            break
//        case .failure(_, let message):
//            print(message.localized())
//        }
    }
    
    func setupTextField() {
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1).cgColor
        textView.clipsToBounds = true
        textView.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10, height: textView.frame.height))
        textView.leftViewMode = UITextField.ViewMode.always
    }
    
    func setupPassTextField() {
        pass_TF.layer.cornerRadius = 8
        pass_TF.layer.borderWidth = 1
        pass_TF.layer.borderColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1).cgColor
        pass_TF.clipsToBounds = true
        pass_TF.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10, height: pass_TF.frame.height))
        pass_TF.leftViewMode = UITextField.ViewMode.always
    }
    
    func setupEmailTextField() {
        email_TF.layer.cornerRadius = 8
        email_TF.layer.borderWidth = 1
        email_TF.layer.borderColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1).cgColor
        email_TF.clipsToBounds = true
        email_TF.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10, height: email_TF.frame.height))
        email_TF.leftViewMode = UITextField.ViewMode.always
    }
    
//    func setupPlaceholder(_ placeholder: String, withAttributes attr: PlaceholderAttr) {
//        self.textView.placeholderAttr = attr
//        let size = placeholder.sizeOfString(usingFont: attr.largeFont)
//        self.setupPlaceholderLabel(placeholder: placeholder, size: size)
//    }
//
//    func setupPlaceholderLabel(placeholder: String, size: CGSize) {
//        placeholderLabel.text = placeholder
//        placeholderLabel.textColor = self.textView.placeholderAttr.initialColor
//        placeholderLabel.font = self.textView.placeholderAttr.largeFont
//        self.view.addSubview(placeholderLabel)
//        NSLayoutConstraint.activate([
//            placeholderLabel.leadingAnchor.constraint(equalTo: self.textView.leadingAnchor, constant: 10),
//            placeholderLabel.centerYAnchor.constraint(equalTo: self.textView.centerYAnchor),
//            placeholderLabel.widthAnchor.constraint(equalToConstant: size.width + 10),
//            placeholderLabel.heightAnchor.constraint(equalToConstant: size.height)
//            ])
//    }
//
//    func textFieldDidStartEditing(_ textField: UITextField) {
//        placeholderLabel.textColor = self.textView.placeholderAttr.activeColor
//        let font = self.textView.placeholderAttr.smallFont
//        placeholderLabel.font = font
//        let size = placeholderLabel.text?.sizeOfString(usingFont: font)
//
//        NSLayoutConstraint.activate([
//            placeholderLabel.centerYAnchor.constraint(equalTo: self.textView.topAnchor),
//            placeholderLabel.widthAnchor.constraint(equalToConstant: size!.width + 12)
//            ])
//        UIView.animate(withDuration: 0.5) {
//            self.view.layoutIfNeeded()
//        }
//        self.textView.becomeFirstResponder()
//        self.textView.layer.borderColor = self.textView.placeholderAttr.activeColor.cgColor
//    }
//
//    func textFieldDidfinishEditing(_ textField: UITextField) {
//        if let text = textField.text?.trimmingCharacters(in: .whitespaces), text.count > 0 {
//            textField.layer.borderColor = self.textView.placeholderAttr.initialColor.cgColor
//        } else {
//            textField.layer.borderColor = self.textView.placeholderAttr.errorColor.cgColor
//            placeholderLabel.textColor = self.textView.placeholderAttr.errorColor
//        }
//    }
    
//    @objc func handleTap(_ sender: UITapGestureRecognizer) {
//        textFieldDidStartEditing(self.textView)
//    }
    
    @IBAction func submitBtnPressed(_ sender: UIButton) {
        print("Elhamedllah")
        self.view.endEditing(true)
    }
}

extension SecondVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textFieldDidStartEditing()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //textField.textFieldDidfinishEditing()
        textField.validate(type: .email) { (response) in
            switch response {
            case .success:
                break
            case .failure(let message):
                guard message != ErrorMessage.emptyEmail else {return}
                print(message)
            }
        }
    }
}
//
//fileprivate var associatedObjectHandle: UInt8 = 0
//fileprivate var labelAssociatedObjectHandle: UInt8 = 99
//
//typealias PlaceholderAttr = (initialColor: UIColor, activeColor: UIColor, errorColor: UIColor, largeFont: UIFont, smallFont: UIFont)
//
//extension UITextField {
//    
//        var placeholderAttr: PlaceholderAttr {
//            get {
//                return objc_getAssociatedObject(self, &associatedObjectHandle) as! PlaceholderAttr
//            }
//            set {
//                objc_setAssociatedObject(self, &associatedObjectHandle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            }
//        }
//    
//    var placeholderLabel: UILabel {
//        get {
//            return objc_getAssociatedObject(self, &labelAssociatedObjectHandle) as! UILabel
//        }
//        set {
//            objc_setAssociatedObject(self, &labelAssociatedObjectHandle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
//    
//    func setupPlaceholder(_ placeholder: String, withAttributes attr: PlaceholderAttr) {
//        self.placeholderLabel = UILabel()
//        self.placeholderAttr = attr
//        let size = placeholder.sizeOfString(usingFont: attr.largeFont)
//        self.setupPlaceholderLabel(placeholder: placeholder, size: size)
//    }
//    
//    func setupPlaceholderLabel(placeholder: String, size: CGSize) {
//        placeholderLabel.text = placeholder
//        placeholderLabel.textColor = self.placeholderAttr.initialColor
//        placeholderLabel.font = self.placeholderAttr.largeFont
//        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
//        placeholderLabel.textAlignment = .center
//        placeholderLabel.numberOfLines = 1
//        placeholderLabel.backgroundColor = UIColor.white
//        self.superview?.addSubview(placeholderLabel)
//        NSLayoutConstraint.activate([
//            placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
//            placeholderLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            placeholderLabel.widthAnchor.constraint(equalToConstant: size.width + 10),
//            placeholderLabel.heightAnchor.constraint(equalToConstant: size.height)
//            ])
//    }
//    
//    func textFieldDidStartEditing(_ textField: UITextField) {
//        placeholderLabel.textColor = self.placeholderAttr.activeColor
//        let font = self.placeholderAttr.smallFont
//        placeholderLabel.font = font
//        let size = placeholderLabel.text?.sizeOfString(usingFont: font)
//        
//        NSLayoutConstraint.activate([
//            placeholderLabel.centerYAnchor.constraint(equalTo: self.topAnchor),
//            placeholderLabel.widthAnchor.constraint(equalToConstant: size!.width + 12)
//            ])
//        UIView.animate(withDuration: 0.5) {
//            self.superview?.layoutIfNeeded()
//        }
//        self.becomeFirstResponder()
//        self.layer.borderColor = self.placeholderAttr.activeColor.cgColor
//    }
//    
//    func textFieldDidfinishEditing(_ textField: UITextField) {
//        if let text = textField.text?.trimmingCharacters(in: .whitespaces), text.count > 0 {
//            textField.layer.borderColor = self.placeholderAttr.initialColor.cgColor
//        } else {
//            textField.layer.borderColor = self.placeholderAttr.errorColor.cgColor
//            placeholderLabel.textColor = self.placeholderAttr.errorColor
//        }
//    }
//}
