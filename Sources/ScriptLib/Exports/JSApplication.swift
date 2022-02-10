import JavaScriptCore

@objc protocol JSApplicationExport: JSExport {
    var name: String { get }
    var version: String { get }
    var windows: [JSWindow] { get }
    var documents: [JSDocument] { get }
    func open(_ url: JSURL, _ callback: JSValue)
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

    public func open(_ url: JSURL, _ callback: JSValue) {
        callback.call(withArguments: [])
        /*
        let configuration = NSWorkspace.OpenConfiguration()
        configuration.promptsUserIfNeeded = true
        NSWorkspace.shared.open(
            [url.inner],
            withApplicationAt: Bundle.main.bundleURL,
            configuration: configuration) { app, error in
                if let context = self.context, let document = Application.shared.document(for: url.inner) {
                    callback.call(withArguments: [context.wrapDocument(document)])
                } else {
                    callback.call(withArguments: [])
                }
            }*/
    }

    public func beep() {
        Application.beep()
    }
}
