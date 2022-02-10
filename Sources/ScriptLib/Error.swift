import JavaScriptCore

public enum Error: Swift.Error {
    case scriptException(JSValue)
}
