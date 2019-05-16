//
//  UIView+CustomImageWithText..swift
//  MoyaDemo
//
//  Created by ahmed.bahnasy on 2/24/19.
//  Copyright © 2019 ahmed.bahnasy. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIView {
        
        let DynamicView=UIView(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: image.size.width, height: image.size.height)))
        DynamicView.backgroundColor = UIColor.clear
        
        var imageView : UIImageView
        imageView  = UIImageView(frame:CGRect(origin: CGPoint(x: 0,y :12), size: CGSize(width: image.size.width, height: image.size.height)))
        imageView.image = image
        
        let textLBl = UILabel(frame:CGRect(origin: CGPoint(x: image.size.width - 5 ,y :image.size.height - 15), size: CGSize(width: 10, height: 10)))
        textLBl.text = text
        textLBl.font = UIFont(name: "Tahoma", size: 8)
        textLBl.textAlignment = NSTextAlignment.center
        textLBl.textColor = UIColor.black
        textLBl.backgroundColor = UIColor.white
        textLBl.frame.size.width =  textLBl.intrinsicContentSize.width + 5
        textLBl.frame.size.height =  textLBl.intrinsicContentSize.width + 5
        textLBl.clipsToBounds = true
        textLBl.layer.cornerRadius = textLBl.frame.size.height / 5
        
        
        DynamicView.frame.size.width = image.size.width + textLBl.frame.size.width
        DynamicView.addSubview(textLBl)
        DynamicView.addSubview(imageView)
        
        UIGraphicsBeginImageContextWithOptions(DynamicView.frame.size, false, UIScreen.main.scale)
        DynamicView.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        
        return DynamicView
    }
}
