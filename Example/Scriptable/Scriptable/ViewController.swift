import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var scriptConsole: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func runScript() {
        let textStorage = scriptConsole.textStorage!
        var selectionRange = scriptConsole.selectedRange()
        
        if selectionRange.length == 0 {
            selectionRange = scriptConsole.selectionRange(
                forProposedRange: selectionRange,
                granularity: .selectByParagraph
            )
        }
        
        let script = textStorage.attributedSubstring(from: selectionRange).string
        
        do {
            let result = try AppScriptContext.shared.evaluateScript(script: script)
            textStorage.append(NSAttributedString(string: "\n\(result)\n"))
        } catch {
            textStorage.append(NSAttributedString(string: "\n\(error)\n"))
        }
        
        scriptConsole.scrollToEndOfDocument(nil)
    }

}

extension ViewController: NSTextViewDelegate {
    
    func textView(_ textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if commandSelector == #selector(insertNewline(_:)) {
            runScript()
            return true
        }
        return false
    }
    
}
