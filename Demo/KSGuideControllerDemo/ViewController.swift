//
//  ViewController.swift
//  KSGuideControllerDemo
//
//  Created by Kyle Sun on 2017/5/8.
//  Copyright © 2017年 Kyle Sun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func guideButtonPressed(_ sender: UIButton) {
        let item = KSGuideItem(sourceView: sender, text: "Update cocoapods to the latest version. \nAdd pod 'KSPhotoBrowser' to your Podfile. \nRun pod install or pod update. \nImport KSPhotoBrowser.h.")
        item.insets = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
        let vc = KSGuideViewController(item: item)
        present(vc, animated: true, completion: nil)
    }
    
}

