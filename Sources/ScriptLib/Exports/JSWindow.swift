import JavaScriptCore

@objc public protocol JSWindowExport: JSExport {
    var title: String? { get }
    var document: JSDocument? { get }
}

@objc open class JSWindow: NSObject, JSWindowExport {
    
    public weak var inner: Window?
    public weak var context: ScriptContext?
    
    public init(inner: Window, context: ScriptContext) {
        self.inner = inner
        self.context = context
    }
    
    public var title: String? {
        inner?.title
    }
    
    public var document: JSDocument? {
        guard
            let document = inner?.document,
            let context = context
        else {
            return nil
        }
        return context.wrapDocument(document)
    }

}
