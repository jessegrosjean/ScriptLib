import Cocoa
import ScriptLib

class AppDocument: NSDocument {
    
    var text: String = "Hello world"
    
    override init() {
        super.init()
    }
    
    override class var autosavesInPlace: Bool {
        return true
    }
    
    override func makeWindowControllers() {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        self.addWindowController(storyboard.instantiateController(
            withIdentifier: NSStoryboard.SceneIdentifier("Document Window Controller")
        ) as! NSWindowController)
    }
    
    override func data(ofType typeName: String) throws -> Data {
        text.data(using: .utf8)!
    }
    
    override func read(from data: Data, ofType typeName: String) throws {
        text = String(data: data, encoding: .utf8)!
    }
    
}
