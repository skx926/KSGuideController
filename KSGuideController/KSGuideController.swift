//
//  KSGuideViewController.swift
//  KSGuideViewControllerDemo
//
//  Created by Kyle Sun on 2017/5/8.
//  Copyright © 2017年 Kyle Sun. All rights reserved.
//

import UIKit

class KSGuideController: UIViewController {
    
    enum Region {
        case upperLeft
        case upperRight
        case lowerLeft
        case lowerRight
    }
    
    typealias CompletionBlock = (() -> Void)
    
    private var items = [KSGuideItem]()
    private var currentIndex: Int = 0 {
        didSet {
            configViews()
        }
    }
    private var currentItem: KSGuideItem {
        get {
            return items[currentIndex]
        }
    }
    private let arrowImageView = UIImageView()
    private let textLabel = UILabel()
    private let maskLayer = CAShapeLayer()
    private var completion: CompletionBlock?
    
    public var maskCornerRadius: CGFloat = 5
    public var backgroundAlpha: CGFloat = 0.7
    public var spacing: CGFloat = 20
    public var padding: CGFloat = 50
    public var maskInsets = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
    public var font = UIFont.systemFont(ofSize: 14)
    public var textColor = UIColor.white
    public var arrowColor = UIColor.white
    public var arrowImageName = "guide_arrow"
    public var animationDuration = 0.3
    public var animatedMask = true
    public var animatedText = false
    public var animatedArrow = true
    
    private var maskCenter: CGPoint {
        get {
            return CGPoint(x: hollowFrame.midX, y: hollowFrame.midY)
        }
    }
    
    private var region: Region {
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
    
    private var hollowFrame: CGRect {
        get {
            var rect = currentItem.sourceView.frame;
            rect.origin.x += maskInsets.left
            rect.origin.y += maskInsets.top
            rect.size.width -= maskInsets.right + maskInsets.left
            rect.size.height -= maskInsets.bottom + maskInsets.top
            return view.convert(rect, from: currentItem.sourceView.superview)
        }
    }
    
    convenience init(item: KSGuideItem, completion:(() -> ())?) {
        self.init(items: [item], completion: completion)
    }
    
    init(items: [KSGuideItem], completion:(() -> ())?) {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve
        self.items.append(contentsOf: items)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading  tthe view.
        configViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configViews() {
        view.backgroundColor = UIColor(white: 0, alpha: backgroundAlpha)
        
        configMask()
        
        arrowImageView.image = UIImage(named: arrowImageName)
        arrowImageView.tintColor = arrowColor
        view.addSubview(arrowImageView)
        
        textLabel.textColor = textColor
        textLabel.font = font
        textLabel.textAlignment = .left
        textLabel.text = currentItem.text
        textLabel.numberOfLines = 0
        view.addSubview(textLabel)
        
        var textRect: CGRect!
        var arrowRect: CGRect!
        var transform: CGAffineTransform = .identity
        let imageSize = arrowImageView.image!.size
        let maxWidth = view.frame.size.width - padding * 2
        let size = currentItem.text.size(font: textLabel.font, maxWidth: maxWidth)
        switch region {
            
        case .upperLeft:
            transform = CGAffineTransform(scaleX: -1, y: 1)
            arrowRect = CGRect(x: hollowFrame.midX - imageSize.width / 2,
                               y: hollowFrame.maxY + spacing,
                               width: imageSize.width,
                               height: imageSize.height)
            var x: CGFloat = 0
            if size.width < hollowFrame.size.width {
                x = arrowRect.maxX - size.width / 2
            } else {
                x = padding
            }
            textRect = CGRect(x: x,
                              y: arrowRect.maxY + spacing,
                              width: size.width,
                              height: size.height)
            
        case .upperRight:
            arrowRect = CGRect(x: hollowFrame.midX - imageSize.width / 2,
                               y: hollowFrame.maxY + spacing,
                               width: imageSize.width,
                               height: imageSize.height)
            var x: CGFloat = 0
            if size.width < hollowFrame.size.width {
                x = arrowRect.minX - size.width / 2
            } else {
                x = padding + maxWidth - size.width
            }
            textRect = CGRect(x: x,
                              y: arrowRect.maxY + spacing,
                              width: size.width,
                              height: size.height)
            
        case .lowerLeft:
            transform = CGAffineTransform(scaleX: -1, y: -1)
            arrowRect = CGRect(x: hollowFrame.midX - imageSize.width / 2,
                               y: hollowFrame.minY - spacing - imageSize.height,
                               width: imageSize.width,
                               height: imageSize.height)
            var x: CGFloat = 0
            if size.width < hollowFrame.size.width {
                x = arrowRect.maxX - size.width / 2
            } else {
                x = padding
            }
            textRect = CGRect(x: x,
                              y: arrowRect.minY - spacing - size.height,
                              width: size.width,
                              height: size.height)
            
        case .lowerRight:
            transform = CGAffineTransform(scaleX: 1, y: -1)
            arrowRect = CGRect(x: hollowFrame.midX - imageSize.width / 2,
                               y: hollowFrame.minY - spacing - imageSize.height,
                               width: imageSize.width,
                               height: imageSize.height)
            var x: CGFloat = 0
            if size.width < hollowFrame.size.width {
                x = arrowRect.minX - size.width / 2
            } else {
                x = padding + maxWidth - size.width
            }
            textRect = CGRect(x: x,
                              y: arrowRect.minY - spacing - size.height,
                              width: size.width,
                              height: size.height)
        }
        if animatedArrow && animatedText {
            UIView.animate(withDuration: animationDuration, animations: {
                self.arrowImageView.transform = transform
                self.arrowImageView.frame = arrowRect
                self.textLabel.frame = textRect
            }, completion: nil)
            return
        }
        if animatedArrow {
            UIView.animate(withDuration: animationDuration, animations: {
                self.arrowImageView.transform = transform
                self.arrowImageView.frame = arrowRect
            }, completion: nil)
            self.textLabel.frame = textRect
            return
        }
        if animatedText {
            UIView.animate(withDuration: animationDuration, animations: {
                self.textLabel.frame = textRect
            }, completion: nil)
            self.arrowImageView.transform = transform
            self.arrowImageView.frame = arrowRect
            return
        }
        arrowImageView.transform = transform
        arrowImageView.frame = arrowRect
        textLabel.frame = textRect
    }
    
    private func configMask() {
        let fromPath = maskLayer.path
        
        maskLayer.frame = view.bounds
        maskLayer.fillColor = UIColor.black.cgColor
        let highlightedPath = UIBezierPath(roundedRect: hollowFrame, cornerRadius: maskCornerRadius)
        let toPath = UIBezierPath(rect: view.bounds)
        toPath.append(highlightedPath)
        maskLayer.path = toPath.cgPath
        maskLayer.fillRule = kCAFillRuleEvenOdd
        view.layer.mask = maskLayer
        
        if animatedMask {
            let animation = CABasicAnimation(keyPath: "path")
            animation.duration = animationDuration
            animation.fromValue = fromPath
            animation.toValue = toPath
            maskLayer.add(animation, forKey: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if currentIndex < items.count - 1 {
            currentIndex += 1
        } else {
            dismiss(animated: true, completion: completion)
        }
    }
}
