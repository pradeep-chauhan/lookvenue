//
//  OpenSansSwift.swift
//  OpenSansSwift
//
//  Created by Hemanta Sapkota on 17/02/2015.
//  Copyright (c) 2015 Open Learning Pty Ltd. All rights reserved.
//

import UIKit
import CoreText

protocol UIFontOpenSans {
    
    static func openSansFontOfSize(size: Float) -> UIFont!
    
    static func openSansBoldFontOfSize(size: Float) -> UIFont!
    
    static func openSansBoldItalicFontOfSize(size: Float) -> UIFont!
    
    static func openSansExtraBoldFontOfSize(size: Float) -> UIFont!
    
    static func openSansExtraBoldItalicFontOfSize(size: Float) -> UIFont!
    
    static func openSansItalicFontOfSize(size: Float) -> UIFont!
    
    static func openSansLightFontOfSize(size: Float) -> UIFont!
    
    static func openSansLightItalicFontOfSize(size: Float) -> UIFont!
    
    static func openSansSemiboldFontOfSize(size: Float) -> UIFont!
    
    static func openSansSemiboldItalicFontOfSize(size: Float) -> UIFont!
    
}

extension UIFont : UIFontOpenSans {
    
    public class func openSansFontOfSize(size: Float) -> UIFont! {
        return UIFont(name: "OpenSans", size: CGFloat(size))
    }
    
    public class func openSansBoldFontOfSize(size: Float) -> UIFont! {
        return UIFont(name: "OpenSans-Bold", size: CGFloat(size))
    }
    
    public class func openSansBoldItalicFontOfSize(size: Float) -> UIFont! {
        return UIFont(name: "OpenSans-BoldItalic", size: CGFloat(size))
    }
    
    public class func openSansExtraBoldFontOfSize(size: Float) -> UIFont! {
        return UIFont(name: "OpenSans-Extrabold", size: CGFloat(size))
    }
    
    public class func openSansExtraBoldItalicFontOfSize(size: Float) -> UIFont! {
        return UIFont(name: "OpenSans-ExtraboldItalic", size: CGFloat(size))
    }
    
    public class func openSansItalicFontOfSize(size: Float) -> UIFont! {
        return UIFont(name: "OpenSans-Italic", size: CGFloat(size))
    }
    
    public class func openSansLightFontOfSize(size: Float) -> UIFont! {
        return UIFont(name: "OpenSans-Light", size: CGFloat(size))
    }
    
    public class func openSansLightItalicFontOfSize(size: Float) -> UIFont! {
        return UIFont(name: "OpenSansLight-Italic", size: CGFloat(size))
    }
    
    public class func openSansSemiboldFontOfSize(size: Float) -> UIFont! {
        return UIFont(name: "OpenSans-Semibold", size: CGFloat(size))
    }
    
    public class func openSansSemiboldItalicFontOfSize(size: Float) -> UIFont! {
        return UIFont(name: "OpenSans-SemiboldItalic", size: CGFloat(size))
    }
    
}

public class OpenSans {
    public class func registerFonts() -> Bool {
        let fontNames = [
            "OpenSans-Regular",
            "OpenSans-Bold",
            "OpenSans-BoldItalic",
            "OpenSans-ExtraBold",
            "OpenSans-ExtraBoldItalic",
            "OpenSans-Italic",
            "OpenSans-Light",
            "OpenSans-LightItalic",
            "OpenSans-Semibold",
            "OpenSans-SemiboldItalic"
        ]
            
        var error: Unmanaged<CFError>? = nil
        
        for font in fontNames {
            let url = NSBundle(forClass: OpenSans.self).URLForResource(font, withExtension: "ttf")
            if (url != nil) {
                CTFontManagerRegisterFontsForURL(url, CTFontManagerScope.None, &error)
            }
        }
        
        return error == nil
    }
}