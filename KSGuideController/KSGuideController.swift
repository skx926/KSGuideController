//
//  KSGuideViewController.swift
//  KSGuideViewControllerDemo
//
//  Created by Kyle Sun on 2017/5/8.
//  Copyright © 2017年 Kyle Sun. All rights reserved.
//

import UIKit

class KSGuideViewController: UIViewController {
    
    var item: KSGuideItem!
    let arrowImageView = UIImageView()
    let textLabel = UILabel()
    let maskLayer = CAShapeLayer()
    var cornerRadius: CGFloat = 5
    
    init(item: KSGuideItem) {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
        self.item = item
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading  tthe view.
        view.backgroundColor = UIColor(white: 0, alpha: 0.6)
        configViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configViews() {
        configText()
        configArrow()
        configMask()
    }
    
    func configText() {
        textLabel.textColor = .white
        textLabel.font = UIFont.systemFont(ofSize: 14)
        textLabel.textAlignment = .left
        view.addSubview(textLabel)
    }
    
    func configArrow() {
        arrowImageView.image = #imageLiteral(resourceName: "guide_arrow")
        view.addSubview(arrowImageView)
    }
    
    func configMask() {
        var rect = item.sourceView.frame;
        rect.origin.x += item.insets.left
        rect.origin.y += item.insets.top
        rect.size.width -= item.insets.right + item.insets.left
        rect.size.height -= item.insets.bottom + item.insets.top
        
        let roundedRect = view.convert(rect, from: item.sourceView.superview)
        maskLayer.frame = view.bounds
        maskLayer.fillColor = UIColor.black.cgColor
        let highlightedPath = UIBezierPath(roundedRect: roundedRect, cornerRadius: cornerRadius)
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
