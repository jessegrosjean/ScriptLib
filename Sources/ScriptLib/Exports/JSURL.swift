import JavaScriptCore

@objc public protocol JSURLExport: JSExport {
    static func new(_: String) -> JSURL?
    
    var lastPathComponent: String? { get }
}

@objc public class JSURL: NSObject, JSURLExport {
    
    let inner: URL
    
    init(inner: URL) {
        self.inner = inner
    }

    public class func new(_ string: String) -> JSURL? {
        URL(string: string).map { JSURL(inner: $0) }
    }
    
    public var lastPathComponent: String? {
        inner.lastPathComponent
    }

}
