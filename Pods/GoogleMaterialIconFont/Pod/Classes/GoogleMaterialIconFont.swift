//
//  GoogleMaterialIconFont.swift
//  Pods
//
//  Created by Yusuke Kita on 9/23/15.
//
//

import UIKit

public extension String {
    public static func materialIcon(font: MaterialIconFont) -> String {
        return IconFont.codes[font.rawValue]
    }
}

public extension NSString {
    public static func materialIcon(font: MaterialIconFont) -> NSString {
        return NSString(string: String.materialIcon(font: font))
    }
}

public extension UIFont {
    public static func materialIconOfSize(size: CGFloat) -> UIFont {
        var onceToken: Int = 0
        let filename = "MaterialIcons-Regular"
        let fontname = "Material Icons"
        
        if UIFont.fontNames(forFamilyName: fontname).isEmpty {
            FontLoader.loadFont(name: filename)
            
        }
        
        guard let font = UIFont(name: fontname, size: size) else {
            fatalError("\(fontname) not found")
        }
        return font
    }
}

private class FontLoader {
    class func loadFont(name: String) {
        let bundle = Bundle(for: FontLoader.self)
        let identifier = bundle.bundleIdentifier
        let fileExtension = "ttf"
        
        let url: NSURL?
        if identifier?.hasPrefix("org.cocoapods") == true {
            url = bundle.url(forResource: name, withExtension: fileExtension, subdirectory: "GoogleMaterialIconFont.bundle") as NSURL?
        } else {
            url = bundle.url(forResource: name, withExtension: fileExtension) as NSURL?
        }
        
        guard let fontURL = url else { fatalError("\(name) not found in bundle") }
        
        guard let data = NSData(contentsOf: fontURL as URL),
            let provider = CGDataProvider(data: data) else { return }
        let font = CGFont(provider)
        
        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            let errorDescription: CFString = CFErrorCopyDescription(error!.takeUnretainedValue())
            let nsError = error!.takeUnretainedValue() as AnyObject as! NSError
            NSException(name: NSExceptionName.internalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
        }
    }
}
