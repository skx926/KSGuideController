KSGuideController
==============
[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/skx926/KSGuideController/master/LICENSE)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/v/KSGuideController.svg?style=flat)](http://cocoapods.org/?q=KSGuideController)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/p/KSGuideController.svg?style=flat)](http://cocoapods.org/?q=KSGuideController)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%208.0%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;

### A beautiful animated novice guide controller written in Swift.

![Demo~](https://raw.github.com/skx926/KSGuideController/master/Demo/Images/Demo.gif)

Features
==============
- Animated page transition.
- A batch of properties for customization.
- Cache support.

Usage
==============
### Swift
```swift
import KSGuideController

var items = [KSGuideItem]()
for button in buttons {
    let n = Int(arc4random()) % string.characters.count
    let index = string.index(string.startIndex, offsetBy: Int(n))
    let text = string.substring(to: index)
    let item = KSGuideItem(sourceView: button, text: text)
    items.append(item)
}
let vc = KSGuideController(items: items, key: "MainGuide")
vc.setIndexWillChangeBlock { (index, item) in
    print("Index will change to \(index)")
}
vc.setIndexDidChangeBlock { (index, item) in
    print("Index did change to \(index)")
}
vc.show(from: self) { 
    print("Guide controller has been dismissed")
}
```

Installation
==============
### Cocoapods
1. Update cocoapods to the latest version.
2. Add `pod 'KSGuideController'` to your Podfile.
3. Run `pod install` or `pod update`.
4. Import `KSGuideController` module.


Requirements
==============
This library requires `iOS 8.0+` and `Xcode 8.0+`.


License
==============
KSGuideController is provided under the MIT license. See LICENSE file for details.