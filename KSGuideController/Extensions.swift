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
