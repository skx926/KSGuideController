//
//  KSGuideItem.swift
//  KSGuideViewControllerDemo
//
//  Created by Kyle Sun on 2017/5/8.
//  Copyright © 2017年 Kyle Sun. All rights reserved.
//

import UIKit

public class KSGuideItem: NSObject {
    var sourceView: UIView!
    var text: String!
    
    public init(sourceView: UIView, text: String) {
        self.sourceView = sourceView
        self.text = text
    }
}
