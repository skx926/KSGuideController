//
//  KSGuideViewController.swift
//  KSGuideViewControllerDemo
//
//  Created by Kyle Sun on 2017/5/8.
//  Copyright © 2017年 Kyle Sun. All rights reserved.
//

import UIKit

class KSGuideViewController: UIViewController {
    
    enum Region {
        case upperLeft
        case upperRight
        case lowerLeft
        case lowerRight
    }
    
    var item: KSGuideItem!
    let arrowImageView = UIImageView()
    let textLabel = UILabel()
    let maskLayer = CAShapeLayer()
    let cornerRadius: CGFloat = 5
    let gap: CGFloat = 20
    
    var maskCenter: CGPoint {
        get {
            return CGPoint(x: hollowFrame.midX, y: hollowFrame.midY)
        }
    }
    
    var region: Region {
        get {
            let center = maskCenter
            let bounds = view.bounds
            if center.x <= bounds.midX && center.y <= bounds.midY {
                return .upperLeft
            } else if center.x > bounds.midX && center.y <= bounds.midY {
                return .upperRight
            } else if center.x <= bounds.midX && center.y > bounds.midY {
                return .lowerLeft
            } else {
                return .lowerRight
            }
        }
    }
    
    var hollowFrame: CGRect {
        get {
            var rect = item.sourceView.frame;
            rect.origin.x += item.insets.left
            rect.origin.y += item.insets.top
            rect.size.width -= item.insets.right + item.insets.left
            rect.size.height -= item.insets.bottom + item.insets.top
            return view.convert(rect, from: item.sourceView.superview)
        }
    }
    
    init(item: KSGuideItem) {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve
        self.item = item
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading  tthe view.
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        configViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configViews() {
        configMask()
        
        arrowImageView.image = #imageLiteral(resourceName: "guide_arrow")
        view.addSubview(arrowImageView)
        
        textLabel.textColor = .white
        textLabel.font = UIFont.systemFont(ofSize: 14)
        textLabel.textAlignment = .left
        textLabel.text = item.text
        textLabel.numberOfLines = 0
        view.addSubview(textLabel)
        
        let imageSize = arrowImageView.image!.size
        switch region {
        case .upperLeft:
            let arrowRect = CGRect(x: hollowFrame.origin.x, y: hollowFrame.maxY + gap, width: imageSize.width, height: imageSize.height)
            arrowImageView.frame = arrowRect
            let maxWidth = view.bounds.size.width - hollowFrame.minX - gap
            let size = item.text.size(font: textLabel.font, maxWidth: maxWidth)
            let textRect = CGRect(x: hollowFrame.origin.x, y: arrowRect.maxY + gap, width: size.width, height: size.height)
            textLabel.frame = textRect
        case .upperRight:
            let arrowRect = CGRect(x: hollowFrame.maxX - imageSize.width, y: hollowFrame.maxY + gap, width: imageSize.width, height: imageSize.height)
            arrowImageView.frame = arrowRect
            let maxWidth = hollowFrame.maxX - gap
            let size = item.text.size(font: textLabel.font, maxWidth: maxWidth)
            var x: CGFloat = 0
            if size.width < maxWidth {
                x = hollowFrame.maxX - size.width
            } else {
                x = hollowFrame.origin.x
            }
            let textRect = CGRect(x: x, y: arrowRect.maxY + gap, width: size.width, height: size.height)
            textLabel.frame = textRect
        case .lowerLeft:
            let arrowRect = CGRect(x: hollowFrame.origin.x, y: hollowFrame.minY - gap - imageSize.height, width: imageSize.width, height: imageSize.height)
            arrowImageView.frame = arrowRect
            let maxWidth = view.bounds.size.width - hollowFrame.minX - gap
            let size = item.text.size(font: textLabel.font, maxWidth: maxWidth)
            let textRect = CGRect(x: hollowFrame.origin.x, y: arrowRect.minY - gap - size.height, width: size.width, height: size.height)
            textLabel.frame = textRect
        case .lowerRight:
            let arrowRect = CGRect(x: hollowFrame.maxX - imageSize.width, y: hollowFrame.minY - gap - imageSize.height, width: imageSize.width, height: imageSize.height)
            arrowImageView.frame = arrowRect
            let maxWidth = hollowFrame.maxX - gap
            let size = item.text.size(font: textLabel.font, maxWidth: maxWidth)
            var x: CGFloat = 0
            if size.width < maxWidth {
                x = hollowFrame.maxX - size.width
            } else {
                x = hollowFrame.origin.x
            }
            let textRect = CGRect(x: x, y: arrowRect.minY - gap - size.height, width: size.width, height: size.height)
            textLabel.frame = textRect
        }
        configArrowDirection()
    }
    
    func configArrowDirection() {
        switch region {
        case .upperLeft:
            arrowImageView.transform = CGAffineTransform(scaleX: -1, y: 1)
        case .upperRight:
            break
        case .lowerLeft:
            arrowImageView.transform = CGAffineTransform(scaleX: -1, y: -1)
        case .lowerRight:
            arrowImageView.transform = CGAffineTransform(scaleX: 1, y: -1)
        }
    }
    
    func configMask() {
        maskLayer.frame = view.bounds
        maskLayer.fillColor = UIColor.black.cgColor
        let highlightedPath = UIBezierPath(roundedRect: hollowFrame, cornerRadius: cornerRadius)
        let path = UIBezierPath(rect: view.bounds)
        path.append(highlightedPath)
        maskLayer.path = path.cgPath
        maskLayer.fillRule = kCAFillRuleEvenOdd
        view.layer.mask = maskLayer
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }

}
