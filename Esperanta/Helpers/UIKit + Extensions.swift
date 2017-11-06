//
//  Extensions.swift
//  Esperanta
//
//  Created by Mesrop Kareyan on 11/5/17.
//  Copyright © 2017 mesrop. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func color(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }
    
    static var appBlue: UIColor {
        return color(red: 102, green: 154, blue: 174)
    }
    
    static var appLightBlue: UIColor {
        return color(red: 102, green: 154, blue: 240)
    }
    
    static var appDardBlue: UIColor {
        return color(red: 74, green: 135, blue: 237)
    }
    
    static var appEsperantoGreen: UIColor {
        return color(red: 0, green: 153, blue: 1)
    }
    
    static var esperantaLightGreen: UIColor {
        return color(red: 220, green: 248, blue: 198)
    }
    
    static var esperantaGreen: UIColor {
        return color(red: 37, green: 211, blue: 102)
    }
    
    static var esperantaBrown: UIColor {
        return color(red: 236, green: 229, blue: 221)
    }
    
    static var esperantaGray: UIColor {
        return color(red: 238, green: 238, blue: 238)
    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}

extension UIApplication {
    
    class func appVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    class func appBuild() -> String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }
    
    class func versionBuild() -> String {
        let version = appVersion(), build = appBuild()
        
        return version == build ? "v\(version)" : "v\(version)(\(build))"
    }
    
}

extension Notification.Name {
    static let ulapp_userImageChanged = Notification.Name("ulapp_userImageChanged")
}
