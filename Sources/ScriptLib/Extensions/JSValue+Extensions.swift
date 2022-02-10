import JavaScriptCore

extension JSValue {
    
    public subscript(_ key: NSString) -> JSValue? {
        get { return objectForKeyedSubscript(key) }
    }
    
    public subscript(_ key: NSString) -> Any? {
        get { return objectForKeyedSubscript(key) }
        set { setObject(newValue, forKeyedSubscript: key) }
    }
    
}
