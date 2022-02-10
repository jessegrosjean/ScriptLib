import JavaScriptCore
import ScriptLib

// This is how AppDocument exposes it's `text` field to scripting.

@objc protocol JSAppDocumentExport: JSExport {
    var text: String { get set }
}

@objc class JSAppDocument: JSDocument, JSAppDocumentExport {
    
    init(inner: AppDocument, context: ScriptContext) {
        super.init(inner: inner, context: context)
    }
    
    var text: String {
        get {
            (inner as? AppDocument)?.text ?? ""
        }
        set {
            (inner as? AppDocument)?.text = newValue
        }
    }
    
}
