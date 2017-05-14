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
        let item = KSGuideItem(sourceView: sender, text: "后来我转行干了段时间销售，赚的比之前多了点，好的时候一个月能拿两三万。我看我妈的手机又旧又破，接电话的时候还要扯着嗓子喊。于是给她买了当时最新款的水果手机，我把手机盒递给她的时候她又炸毛了，又嚷嚷着说太贵了要去退。这次我学聪明了，说发票已经掉了退不了，我妈彻底毛了，好几天不给我做饭。")
        item.insets = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
        let vc = KSGuideViewController(item: item)
        present(vc, animated: true, completion: nil)
    }
    
}

