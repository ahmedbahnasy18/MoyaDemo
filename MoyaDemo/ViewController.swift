//
//  ViewController.swift
//  MoyaDemo
//
//  Created by ahmed.bahnasy on 1/27/19.
//  Copyright © 2019 ahmed.bahnasy. All rights reserved.
//

import UIKit
import Crashlytics

class ViewController: UIViewController {

    
    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var placeholder_lbl: UILabel!
    @IBOutlet weak var second_TF: UITextField!
    @IBOutlet weak var my_TF: UITextField!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var message_TF: UITextField!
    @IBOutlet weak var myFloating_TF: ITKFloatingTextField!
    var sharedIdentifier = "group.com.rubikal.demo"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.view.backgroundColor = ColorName.worgen.color
        //logoImg.image = Asset.icon.image
        self.fetchData()
        
        let imgWithTxtView = UIView().textToImage(drawText: "\(5)", inImage: UIImage(named: "notificationNotActive")!, atPoint: CGPoint(x: 0.0, y: 0.0))
        logoImg.addSubview(imgWithTxtView)
        
        my_TF.delegate = self
        second_TF.delegate = self
        
        
        self.setupMyTextField()
        self.setupPlaceholderView()
        
        setupSecondTextField()
        
    }
    
     func fetchData() {
        if let prefs = UserDefaults(suiteName: sharedIdentifier) {
            if let imageData = prefs.object(forKey: "Image") as? NSData {
                DispatchQueue.main.async {
                    self.logoImg.image = UIImage(data: imageData as Data)
                }
            }
            if let nameText = prefs.object(forKey: "Name") {
                self.message_TF.text = nameText as? String
            }
        }
    }
    
    func setupPlaceholderView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        placeholderView.addGestureRecognizer(tap)
        placeholderView.isUserInteractionEnabled = true
        placeholder_lbl.text = "email"
        placeholder_lbl.textColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1)
        placeholder_lbl.font = UIFont(name: "HelveticaNeue", size: CGFloat(17))
    }
    
    // function which is triggered when handleTap is called
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        textFieldDidStartEditing(my_TF)
    }
    
    func setupMyTextField() {
        my_TF.layer.cornerRadius = 8
        my_TF.layer.borderWidth = 1
        my_TF.layer.borderColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1).cgColor
        my_TF.clipsToBounds = true
        my_TF.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10, height: my_TF.frame.height))
        my_TF.leftViewMode = UITextField.ViewMode.always
    }
    
    func textFieldDidStartEditing(_ textField: UITextField) {
        NSLayoutConstraint.activate([
            placeholderView.centerYAnchor.constraint(equalTo: textField.topAnchor)
            ])
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        textField.becomeFirstResponder()
        textField.layer.borderColor = UIColor(red:0, green:0.73, blue:0.71, alpha:1).cgColor
        placeholder_lbl.textColor = UIColor(red:0, green:0.73, blue:0.71, alpha:1)
        placeholder_lbl.font = UIFont(name: "HelveticaNeue", size: CGFloat(12))
    }
    
    func textFieldDidfinishEditing(_ textField: UITextField) {
        if let text = textField.text?.trimmingCharacters(in: .whitespaces), text.count > 0 {
            textField.layer.borderColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1).cgColor
        } else {
            textField.layer.borderColor = UIColor(red:0.94, green:0.43, blue:0.28, alpha:1).cgColor
            placeholder_lbl.textColor = UIColor(red:0.94, green:0.43, blue:0.28, alpha:1)
        }
    }
    
    func setupSecondTextField() {
        second_TF.layer.borderColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1).cgColor
        second_TF.layer.cornerRadius = 18
        second_TF.layer.borderWidth = 1
        second_TF.tintColor = ColorName.druid.color
        second_TF.autocorrectionType = .no
        second_TF.autocapitalizationType = .none
        second_TF.keyboardType = .default
        second_TF.keyboardAppearance = .light
        second_TF.textColor = ColorName.powder.color
        second_TF.clipsToBounds = true
    }
    
    @IBAction func testCrash(_ sender: UIButton) {
        Crashlytics.sharedInstance().crash()
    }

}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textFieldDidStartEditing(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.textFieldDidfinishEditing(textField)
    }
}
