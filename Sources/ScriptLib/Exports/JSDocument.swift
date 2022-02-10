import JavaScriptCore

@objc protocol JSDocumentExport: JSExport {
    var fileURL: JSURL? { get }
    var windows: [JSWindow]? { get }
}

@objc open class JSDocument: NSObject, JSDocumentExport {
    
    public weak var inner: Document?
    public weak var context: ScriptContext?

    public init(inner: Document, context: ScriptContext) {
        self.inner = inner
        self.context = context
    }

    public var fileURL: JSURL? {
        inner?.fileURL.map { JSURL(inner: $0 ) }
    }
    
    public var windows: [JSWindow]? {
        guard
            let windows = inner?.windows,
            let context = context
        else {
            return nil
        }
        
        return windows.compactMap { context.wrapWindow($0) }
    }
    
}
