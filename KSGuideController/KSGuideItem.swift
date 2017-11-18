//
//  KSGuideItem.swift
//  KSGuideViewControllerDemo
//
//  Created by Kyle Sun on 2017/5/8.
//  Copyright © 2017年 Kyle Sun. All rights reserved.
//

import UIKit

@objc public class KSGuideItem: NSObject {
    @objc public var sourceView: UIView?
    @objc public var rect: CGRect = .zero
    // arrow image for this item
    @objc public var arrowImage: UIImage?
    @objc public var text: String!
    
    @objc public init(sourceView: UIView, arrowImage: UIImage? = nil, text: String) {
        self.sourceView = sourceView
        self.arrowImage = arrowImage
        self.text = text
    }
    
    @objc public init(rect: CGRect, arrowImage: UIImage? = nil, text: String) {
        self.rect = rect
        self.arrowImage = arrowImage
        self.text = text
    }
}
