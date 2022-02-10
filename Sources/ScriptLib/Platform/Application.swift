#if os(OSX)

import AppKit
public typealias Application = NSApplication

extension NSApplication {
    
    public var documents: [Document] {
        orderedDocuments
    }
    
    public func document(for url: URL) -> Document? {
        NSDocumentController.shared.document(for: url)
    }
    
    public static func beep() {
        NSSound.beep()
    }

    public func open(_ url: URL, _ callback: @escaping (Bool) -> ()) {
        let configuration = NSWorkspace.OpenConfiguration()
        configuration.promptsUserIfNeeded = true
        NSWorkspace.shared.open(
            url,
            configuration: configuration) { app, error in
                if error != nil {
                    callback(false)
                } else {
                    callback(true)
                }
            }
    }
}

#else

import UIKit
public typealias Application = UIApplication

extension UIApplication {
    
    public var documents: [AppDocument] {
        fatalError()
    }
    
    public func document(for url: URL) -> AppDocument? {
        fatalError()
    }
    
}

#endif

extension Application {
    
    public static var name: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "Missing CFBundleName"
    }
    
    public static var version: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Missing CFBundleShortVersionString"
    }

    public static var build: UInt {
        UInt(Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "") ?? 0
    }
    
    public static var isPreview: Bool {
        let bundleInfo = Bundle.main.infoDictionary!
        let currentShortVersion = bundleInfo["CFBundleShortVersionString"] as! String
        return currentShortVersion.range(of: "Preview") != nil
    }
    
    public static var buildDate: Date? {
        guard
            let executablePath = Bundle.main.executablePath,
            let attributes = try? FileManager.default.attributesOfItem(atPath: executablePath),
            let date = attributes[.creationDate] as? Date
        else {
            return nil
        }
        return date
    }
    
}
