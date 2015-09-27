

import UIKit

let KSTextEmpty = "\u{200B}"

class KSUtils : NSObject {
   
   class func getRect(str: NSString, width: CGFloat, height: CGFloat, font: UIFont) -> CGRect {
      let rectangleStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
      rectangleStyle.alignment = NSTextAlignment.Center
      let rectangleFontAttributes = [NSFontAttributeName: font, NSParagraphStyleAttributeName: rectangleStyle]
      return str.boundingRectWithSize(CGSizeMake(width, height), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: rectangleFontAttributes, context: nil)
   }
   
   
   class func getRect(str: NSString, width: CGFloat, font: UIFont) -> CGRect {
      let rectangleStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
      rectangleStyle.alignment = NSTextAlignment.Center
      let rectangleFontAttributes = [NSFontAttributeName: font, NSParagraphStyleAttributeName: rectangleStyle]
      return str.boundingRectWithSize(CGSizeMake(width, CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: rectangleFontAttributes, context: nil)
   }
   
   class func widthOfString(str: String, font: UIFont) -> CGFloat {
      var attrs = [NSFontAttributeName: font]
      var attributedString = NSMutableAttributedString(string:str, attributes:attrs)
      return attributedString.size().width
   }
   
   class func isIpad() -> Bool {
      return UIDevice.currentDevice().userInterfaceIdiom == .Pad
   }
   
   class func constrainsEnabled(view: UIView) -> Bool {
      if (view.constraints().count > 0) {
         return true
      } else {
         return false
      }
   }
}

extension UIColor {
   func darkendColor(darkRatio: CGFloat) -> UIColor {
      var h: CGFloat = 0.0, s: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 1.0
      if (getHue(&h, saturation: &s, brightness: &b, alpha: &a)) {
         return UIColor(hue: h, saturation: s, brightness: b*darkRatio, alpha: a)
      } else {
         return self
      }
   }
}
