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
        arrowImageView.tintColor = .white
        view.addSubview(arrowImageView)
        
        textLabel.textColor = .white
        textLabel.font = UIFont.systemFont(ofSize: 14)
        textLabel.textAlignment = .left
        textLabel.text = item.text
        textLabel.numberOfLines = 0
        view.addSubview(textLabel)
        
        var textRect: CGRect!
        var arrowRect: CGRect!
        var transform: CGAffineTransform = .identity
        let imageSize = arrowImageView.image!.size
        let maxWidth = view.frame.size.width - gap * 2
        let size = item.text.size(font: textLabel.font, maxWidth: maxWidth)
        switch region {
            
        case .upperLeft:
            transform = CGAffineTransform(scaleX: -1, y: 1)
            arrowRect = CGRect(x: hollowFrame.midX - imageSize.width / 2,
                               y: hollowFrame.maxY + gap,
                               width: imageSize.width,
                               height: imageSize.height)
            var x: CGFloat = 0
            if size.width < hollowFrame.size.width {
                x = arrowRect.maxX - size.width / 2
            } else {
                x = gap
            }
            textRect = CGRect(x: x,
                              y: arrowRect.maxY + gap,
                              width: size.width,
                              height: size.height)
            
        case .upperRight:
            arrowRect = CGRect(x: hollowFrame.midX - imageSize.width / 2,
                               y: hollowFrame.maxY + gap,
                               width: imageSize.width,
                               height: imageSize.height)
            var x: CGFloat = 0
            if size.width < hollowFrame.size.width {
                x = arrowRect.minX - size.width / 2
            } else {
                x = gap + maxWidth - size.width
            }
            textRect = CGRect(x: x,
                              y: arrowRect.maxY + gap,
                              width: size.width,
                              height: size.height)
            
        case .lowerLeft:
            transform = CGAffineTransform(scaleX: -1, y: -1)
            arrowRect = CGRect(x: hollowFrame.midX - imageSize.width / 2,
                               y: hollowFrame.minY - gap - imageSize.height,
                               width: imageSize.width,
                               height: imageSize.height)
            var x: CGFloat = 0
            if size.width < hollowFrame.size.width {
                x = arrowRect.maxX - size.width / 2
            } else {
                x = gap
            }
            textRect = CGRect(x: x,
                              y: arrowRect.minY - gap - size.height,
                              width: size.width,
                              height: size.height)
            
        case .lowerRight:
            transform = CGAffineTransform(scaleX: 1, y: -1)
            arrowRect = CGRect(x: hollowFrame.midX - imageSize.width / 2,
                               y: hollowFrame.minY - gap - imageSize.height,
                               width: imageSize.width,
                               height: imageSize.height)
            var x: CGFloat = 0
            if size.width < hollowFrame.size.width {
                x = arrowRect.minX - size.width / 2
            } else {
                x = gap + maxWidth - size.width
            }
            textRect = CGRect(x: x,
                              y: arrowRect.minY - gap - size.height,
                              width: size.width,
                              height: size.height)
        }
        arrowImageView.transform = transform
        arrowImageView.frame = arrowRect
        textLabel.frame = textRect
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
