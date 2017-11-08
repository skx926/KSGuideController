//
//  KSGuideItem.swift
//  KSGuideViewControllerDemo
//
//  Created by Kyle Sun on 2017/5/8.
//  Copyright © 2017年 Kyle Sun. All rights reserved.
//

import UIKit

public class KSGuideItem: NSObject {
    public var sourceView: UIView?
    public var rect: CGRect = .zero
    // arrow image for this item
    public var arrowImage: UIImage?
    public var text: String!
    
    public init(sourceView: UIView, arrowImage: UIImage? = nil, text: String) {
        self.sourceView = sourceView
        self.arrowImage = arrowImage
        self.text = text
    }
    
    public init(rect: CGRect, arrowImage: UIImage? = nil, text: String) {
        self.rect = rect
        self.arrowImage = arrowImage
        self.text = text
    }
}
