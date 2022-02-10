#if os(OSX)

import AppKit
public typealias Window = NSWindow

extension Window {

    var document: Document? {
        windowController?.document as? NSDocument
    }

}

#else

import UIKit
public typealias Window = UIWindow

extension UIWindow {
    
    public var title: String {
        ""
    }
    
}

#endif
