import Foundation
#if canImport(AppKit)
import AppKit

import Cocoa

public extension NSFont {
    struct TextStyle: RawRepresentable, Hashable {
        public let rawValue: String
        
        public init?(rawValue: String) {
            self.rawValue = rawValue
        }
        
        public init(_ rawValue: String) {
            self.rawValue = rawValue
        }
        
        public static let body = TextStyle("body")
        public static let callout = TextStyle("callout")
        public static let caption1 = TextStyle("caption1")
        public static let caption2 = TextStyle("caption2")
        public static let footnote = TextStyle("footnote")
        public static let headline = TextStyle("headline")
        public static let subheadline = TextStyle("subheadline")
        public static let largeTitle = TextStyle("largeTitle")
        public static let title1 = TextStyle("title1")
        public static let title2 = TextStyle("title2")
        public static let title3 = TextStyle("title3")
    }
    
    class func preferredFont(forTextStyle textStyle: TextStyle) -> NSFont {
        switch textStyle {
        case .body:
            return NSFont.systemFont(ofSize: 12)
        case .callout:
            return NSFont.systemFont(ofSize: 11)
        case .caption1:
            return NSFont.systemFont(ofSize: 9)
        case .caption2:
            return NSFont.systemFont(ofSize: 8)
        case .footnote:
            return NSFont.systemFont(ofSize: 10)
        case .headline:
            return NSFont.boldSystemFont(ofSize: 12)
        case .subheadline:
            return NSFont.systemFont(ofSize: 11)
        case .largeTitle:
            return NSFont.systemFont(ofSize: 24)
        case .title1:
            return NSFont.systemFont(ofSize: 21)
        case .title2:
            return NSFont.systemFont(ofSize: 17)
        case .title3:
            return NSFont.systemFont(ofSize: 14)
        default:
            return NSFont.systemFont(ofSize: NSFont.systemFontSize)
        }
    }
}

#endif


