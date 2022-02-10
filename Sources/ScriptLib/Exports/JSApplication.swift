import JavaScriptCore

@objc protocol JSApplicationExport: JSExport {
    var name: String { get }
    var version: String { get }
    var windows: [JSWindow] { get }
    var documents: [JSDocument] { get }
    func documentForURL(_ url: JSURL) -> JSDocument?
    func openURL(_ url: JSURL, _ callback: JSValue)
    func beep()
}

@objc public class JSApplication: NSObject, JSApplicationExport {
    
    public weak var context: ScriptContext?
    
    init(context: ScriptContext) {
        self.context = context
    }

    public var name: String {
        Application.name
    }

    public var version: String {
        Application.version
    }

    public var build: UInt {
        Application.build
    }

    public var windows: [JSWindow] {
        guard let context = context else {
            return []
        }

        return Application.shared.windows.compactMap { window in
            return context.wrapWindow(window)
        }
    }

    public var documents: [JSDocument] {
        guard let context = context else {
            return []
        }

        return Application.shared.documents.compactMap { document in
            context.wrapDocument(document)
        }
    }
    
    public func documentForURL(_ url: JSURL) -> JSDocument? {
        guard
            let context = context,
            let document = Application.shared.document(for: url.inner)
        else {
            return nil
        }
        return context.wrapDocument(document)
    }

    public func openURL(_ url: JSURL, _ callback: JSValue) {
        Application.shared.open(url.inner) { result in
            callback.call(withArguments: [result])
        }
    }

    public func beep() {
        Application.beep()
    }
}
