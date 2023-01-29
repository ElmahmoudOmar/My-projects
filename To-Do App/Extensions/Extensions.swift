//
//  Extensions.swift
//  To-do
//
//  Created by macbook pro on 28/1/2023.
//

import UIKit


//MARK: - UIColor Extension

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}


extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
    
    var isDarkColor: Bool {
            var r, g, b, a: CGFloat
            (r, g, b, a) = (0, 0, 0, 0)
            self.getRed(&r, green: &g, blue: &b, alpha: &a)
            let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b
            return  lum < 0.50
        }
    
     func toHexString() -> String {
           var r:CGFloat = 0
           var g:CGFloat = 0
           var b:CGFloat = 0
           var a:CGFloat = 0

           getRed(&r, green: &g, blue: &b, alpha: &a)

           let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

           return NSString(format:"#%06x", rgb) as String
       }

       convenience init(red: Int, green: Int, blue: Int) {
           assert(red >= 0 && red <= 255, "Invalid red component")
           assert(green >= 0 && green <= 255, "Invalid green component")
           assert(blue >= 0 && blue <= 255, "Invalid blue component")

           self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
       }

    
}
