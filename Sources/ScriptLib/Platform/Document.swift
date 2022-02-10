#if os(OSX)

import AppKit
public typealias Document = NSDocument

extension NSDocument {
    
    var windows: [Window] {
        windowControllers.compactMap { $0.window }
    }
    
}

#else

import UIKit
public typealias AppDocument = UIDocument

extension UIDocument {
    
}

#endif
