import ScriptLib

// Custom scripting is injected into ScriptLib by subclassing `JS` wrappers.

class AppScriptContext: ScriptContext {
    
    public static let shared = AppScriptContext()
    
    public init() {
        super.init(
            wrapDocument: { inner, context in
                (inner as? AppDocument).map { JSAppDocument(inner: $0, context: context) }
            }
        )
    }
}
