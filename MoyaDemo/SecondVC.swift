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
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue", size: CGFloat(17))
        label.textAlignment = .center
        label.numberOfLines = 1
        label.backgroundColor = UIColor.white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.delegate = self
        self.setupTextField()
        
        self.setupPlaceholder(withPlaceholder: "campus / school", usingFont: UIFont(name: "HelveticaNeue", size: CGFloat(17))!)

    }
    
    func setupTextField() {
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1).cgColor
        textView.clipsToBounds = true
        textView.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10, height: textView.frame.height))
        textView.leftViewMode = UITextField.ViewMode.always
    }
    
    func setupPlaceholder(withPlaceholder placeholder: String, usingFont font: UIFont) {
        let size = placeholder.sizeOfString(usingFont: font)
        self.setupPlaceholderLabel(placeholder: placeholder, size: size)
    }
    
    func setupPlaceholderLabel(placeholder: String, size: CGSize) {
        placeholderLabel.text = placeholder
        self.view.addSubview(placeholderLabel)
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: self.textView.leadingAnchor, constant: 10),
            placeholderLabel.centerYAnchor.constraint(equalTo: self.textView.centerYAnchor),
            placeholderLabel.widthAnchor.constraint(equalToConstant: size.width + 10),
            placeholderLabel.heightAnchor.constraint(equalToConstant: size.height)
            ])
    }
    
    func textFieldDidStartEditing(_ textField: UITextField) {
        placeholderLabel.textColor = UIColor(red: 0, green: 0.73, blue: 0.71, alpha: 1)
        let font = UIFont(name: "HelveticaNeue", size: CGFloat(12))
        placeholderLabel.font = font
        let size = placeholderLabel.text?.sizeOfString(usingFont: font!)
        
        NSLayoutConstraint.activate([
            placeholderLabel.centerYAnchor.constraint(equalTo: self.textView.topAnchor),
            placeholderLabel.widthAnchor.constraint(equalToConstant: size!.width + 12)
            ])
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        self.textView.becomeFirstResponder()
        self.textView.layer.borderColor = UIColor(red: 0, green: 0.73, blue:0.71, alpha: 1).cgColor
        
    }
    
    func textFieldDidfinishEditing(_ textField: UITextField) {
        if let text = textField.text?.trimmingCharacters(in: .whitespaces), text.count > 0 {
            textField.layer.borderColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1).cgColor
        } else {
            textField.layer.borderColor = UIColor(red:0.94, green:0.43, blue:0.28, alpha:1).cgColor
            placeholderLabel.textColor = UIColor(red:0.94, green:0.43, blue:0.28, alpha:1)
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        textFieldDidStartEditing(self.textView)
    }
    
    @IBAction func submitBtnPressed(_ sender: UIButton) {
        print("Elhamedllah")
        self.view.endEditing(true)
    }
}

extension SecondVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textFieldDidStartEditing(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.textFieldDidfinishEditing(textField)
    }
}
