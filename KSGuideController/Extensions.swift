//
//  Extensions.swift
//  KSGuideController
//
//  Created by Kyle Sun on 2017/5/8.
//  Copyright © 2017年 Kyle Sun. All rights reserved.
//

import UIKit


extension String {
    func ks_size(of font: UIFont, maxWidth: CGFloat) -> CGSize {
        let s = self as NSString
        let size = s.boundingRect(with: CGSize(width: maxWidth, height: .infinity), options: [.usesLineFragmentOrigin, .truncatesLastVisibleLine, .usesFontLeading], attributes: [NSFontAttributeName: font], context: nil).size
        return size;
    }
}

extension UIImage {
    func ks_image(with tintColor: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        tintColor.setFill()
        let bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIRectFill(bounds)
        draw(in: bounds, blendMode: .overlay, alpha: 1)
        draw(in: bounds, blendMode: .destinationIn, alpha: 1)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
