//
//  ViewController.swift
//  KSGuideController
//
//  Created by Kyle Sun on 2017/5/8.
//  Copyright © 2017年 Kyle Sun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var buttons: [UIButton]!
    let string = "GitHub is a web-based Git or version control repository and Internet hosting service. It is mostly used for code. It offers all of the distributed version control and source code management (SCM) functionality of Git as well as adding its own features. It provides access control and several collaboration features such as bug tracking, feature requests, task management, and wikis for every project."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showGuides()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for button in buttons {
            if abs(button.frame.size.width - button.frame.size.height) < 10 {
                button.layer.cornerRadius = button.frame.size.height / 2
                button.tag = 1
            } else {
                button.tag = 0
            }
        }
    }

    @IBAction func guideButtonPressed(_ sender: UIButton) {
        showGuides()
    }

    func showGuides() {
        // Reset to show everytime.
        KSGuideDataManager.reset(for: "MainGuide")
        
        var items = [KSGuideItem]()
        for button in buttons {
            let n = Int(arc4random()) % string.count
            let index = string.index(string.startIndex, offsetBy: Int(n))
            let text = string[..<index]
            if n % 2 == 0 {
                // Use custom arrow image for every item, you can also set global arrow image for all items by setting the arrowImage property for a KSGuideController instance.
                let item = KSGuideItem(sourceView: button, arrowImage: #imageLiteral(resourceName: "arrow"), text: String(text), isCircle: (button.tag == 1))
                items.append(item)
            } else {
                // Use default arrow image
                let item = KSGuideItem(sourceView: button, text: String(text), font: UIFont.boldSystemFont(ofSize: 20), isCircle: (button.tag == 1))
                items.append(item)
            }
        }
        let vc = KSGuideController(items: items, key: "MainGuide")
        vc.setIndexWillChangeBlock { (index, item) in
            print("Index will change to \(index)")
        }
        vc.setIndexDidChangeBlock { (index, item) in
            print("Index did change to \(index)")
        }
        vc.show(from: self) { 
            print("Guide controller has been dismissed")
        }
    }
    
}

