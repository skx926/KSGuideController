//
//  ViewController.swift
//  KSGuideControllerDemo
//
//  Created by Kyle Sun on 2017/5/8.
//  Copyright © 2017年 Kyle Sun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var guideButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func guideButtonPressed(_ sender: Any) {
        let item = KSGuideItem(sourceView: guideButton, text: "What the fuck?")
        item.insets = UIEdgeInsets(top: -10, left: -20, bottom: -30, right: -40)
        let vc = KSGuideViewController(item: item)
        present(vc, animated: true, completion: nil)
    }
    
}

