//
//  ITKFloatingTextField.swift
//  MoyaDemo
//
//  Created by ahmed.bahnasy on 5/19/19.
//  Copyright © 2019 ahmed.bahnasy. All rights reserved.
//

import UIKit

class ITKFloatingTextField: UITextField {

    var placeholderLabel = UILabel()
    var placeholderView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    
    func initialize() {
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1).cgColor
        self.clipsToBounds = true
        self.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10, height: self.frame.height))
        self.leftViewMode = UITextField.ViewMode.always
        
        
        placeholderView.frame = CGRect.init(x: 0, y: 10, width: 40, height: 16)
        placeholderView.backgroundColor = UIColor.black
        placeholderView.center = self.center
        self.addSubview(placeholderView)
        
        
        placeholderLabel.frame = CGRect.init(x: 0, y: 0, width: placeholderView.frame.width, height: placeholderView.frame.height)
        placeholderLabel.center = self.center
        self.placeholderView.addSubview(placeholderLabel)

    }
}
