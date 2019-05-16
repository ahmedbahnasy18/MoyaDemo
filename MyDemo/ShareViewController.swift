//
//  ShareViewController.swift
//  MyDemo
//
//  Created by ahmed.bahnasy on 2/10/19.
//  Copyright © 2019 ahmed.bahnasy. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices


class ShareViewController: SLComposeServiceViewController {
    var sharedIdentifier = "group.com.rubikal.demo"
    var selectedImage: UIImage!

    override func viewDidLoad() {
        placeholder = "Write Content Here"
    }
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.dataAttachment()
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return [UserConfigurationItem]
    }
    lazy var UserConfigurationItem: SLComposeSheetConfigurationItem = {
        let item = SLComposeSheetConfigurationItem()
        item?.title = "what's on you mind??"
        return item!
    }()
    
    func dataAttachment() {
        let content = extensionContext!.inputItems[0] as! NSExtensionItem
        let contentType = kUTTypeImage as String
        
        for attachment in content.attachments as! [NSItemProvider] {
            if attachment.hasItemConformingToTypeIdentifier(contentType) {
                
                attachment.loadItem(forTypeIdentifier: contentType, options: nil) { (data, error) in
                    if error == nil {
                        let url = data as! NSURL
                        if let imageData = NSData(contentsOf: url as URL) {
                            self.saveDataToUserDefaults(suiteName: self.sharedIdentifier, dataKey: "Image", dataValue: imageData)
                        } else {
                            print("NOOOO!!!!")
                        }
                    }
                }
                self.saveDataToUserDefaults(suiteName: self.sharedIdentifier, dataKey: "Name", dataValue: contentText as AnyObject)
            }
        }
    }
    func saveDataToUserDefaults(suiteName: String, dataKey: String, dataValue: AnyObject) {
        if let prefs = UserDefaults(suiteName: suiteName) {
            prefs.removeObject(forKey: dataKey)
            prefs.set(dataValue, forKey: dataKey)
        }
    }
    
}
