import JavaScriptCore

open class ScriptContext {
    
    let context: JSContext
    let wrapWindowInner: ((Window, ScriptContext) -> JSWindow?)
    let wrapDocumentInner: ((Document, ScriptContext) -> JSDocument?)
    var lastException: JSValue?

    public init(
        wrapWindow: ((Window, ScriptContext) -> JSWindow?)? = nil,
        wrapDocument: ((Document, ScriptContext) -> JSDocument?)? = nil
    ) {
        context = JSContext()!
        context.name = "\(Application.name) ScriptContext"
        wrapWindowInner = wrapWindow ?? { JSWindow(inner: $0, context: $1) }
        wrapDocumentInner = wrapDocument ?? { JSDocument(inner: $0, context: $1) }

        context.exceptionHandler = { [weak self] context, exception in
            self?.lastException = exception
        }

        context.setObject(JSURL.self, forKeyedSubscript: "JSURL" as NSString)
        context["app"] = JSApplication(context: self)
    }
    
    func wrapWindow(_ window: Window) -> JSWindow? {
        wrapWindowInner(window, self)
    }

    func wrapDocument(_ document: Document) -> JSDocument? {
        wrapDocumentInner(document, self)
    }

    public func evaluateScript(script: String, withSourceURL: URL? = nil) throws -> JSValue {
        lastException = nil
        
        let script = "(function() { return eval(`\(script)`) })()"
        
        let result: JSValue = {
            if let url = withSourceURL {
                return context.evaluateScript(script, withSourceURL: url)
            } else {
                return context.evaluateScript(script)
            }
        }()
        
        if let lastException = lastException {
            self.lastException = nil
            throw Error.scriptException(lastException)
        }
        
        return result
    }
    
}
