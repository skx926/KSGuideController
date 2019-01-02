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
    @objc public var isCircle = false
    // arrow image for this item
    @objc public var arrowImage: UIImage?
    @objc public var text: String!
    @objc public var font = UIFont.systemFont(ofSize: 14)

    @objc public init(sourceView: UIView, arrowImage: UIImage? = nil, text: String, font: UIFont = UIFont.systemFont(ofSize: 14), isCircle: Bool = false) {
        self.isCircle = isCircle
        self.sourceView = sourceView
        self.arrowImage = arrowImage
        self.font = font
        self.text = text
    }

    @objc public init(rect: CGRect, arrowImage: UIImage? = nil, text: String, font: UIFont = UIFont.systemFont(ofSize: 14), isCircle: Bool = false) {
        self.rect = rect
        self.isCircle = isCircle
        self.arrowImage = arrowImage
        self.font = font
        self.text = text
    }
}

