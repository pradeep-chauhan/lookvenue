

import UIKit


//MARK: - KSToken
//__________________________________________________________________________________
//
class KSToken : UIControl {
   
   //MARK: - Public Properties
   //__________________________________________________________________________________
   //
   
   /// retuns title as description
   override var description : String {
      get {
         return title
      }
   }
   
   /// default is ""
   var title = ""
   
   /// default is nil. Any Custom object.
   var object: AnyObject?
   
   /// default is false. If set to true, token can not be deleted
   var sticky = false
   
   /// Token Title color
   var tokenTextColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
   
   /// Token background color
   var tokenBackgroundColor = UIColor(red: 210/255, green: 63/255, blue: 49/255, alpha: 1)
   
   /// Token title color in selected state
   var tokenTextHighlightedColor: UIColor?
   
   /// Token backgrould color in selected state
   var tokenBackgroundHighlightedColor: UIColor?
   
   /// Token background color in selected state. It doesn't have effect if 'tokenBackgroundHighlightedColor' is set
   var darkRatio: CGFloat = 0.75
   
   /// Token border width
   var borderWidth: CGFloat = 0.0
   
   ///Token border color
   var borderColor: UIColor = UIColor.blackColor()

   /// default is 200. Maximum width of token. After maximum limit is reached title is truncated at end with '...'
   private var _maxWidth: CGFloat? = 200
   var maxWidth: CGFloat {
      get{
         return _maxWidth!
      }
      set (newWidth) {
         if (_maxWidth != newWidth) {
            _maxWidth = newWidth
            sizeToFit()
            setNeedsDisplay()
         }
      }
   }
   
   /// returns true if token is selected
   override var selected: Bool {
      didSet (newValue) {
         setNeedsDisplay()
      }
   }
   
   //MARK: - Constructors
   //__________________________________________________________________________________
   //
   convenience required init(coder aDecoder: NSCoder) {
      self.init(title: "")
   }
   
   convenience init(title: String) {
      self.init(title: title, object: title);
   }
   
   init(title: String, object: AnyObject?) {
      self.title = title
      self.object = object
      super.init(frame: CGRect.zeroRect)
//      backgroundColor = UIColor.clearColor()
   }
   
   //MARK: - Drawing code
   //__________________________________________________________________________________
   //
   override func drawRect(rect: CGRect) {
      //// General Declarations
      let context = UIGraphicsGetCurrentContext()
      
      //// Rectangle Drawing
      
      // fill background
      let rectanglePath = UIBezierPath(roundedRect: rect, cornerRadius: 15)
      
      var textColor: UIColor
      var backgroundColor: UIColor
      
      if (selected) {
         if (tokenBackgroundHighlightedColor != nil) {
            backgroundColor = tokenBackgroundHighlightedColor!
         } else {
            backgroundColor = tokenBackgroundColor.darkendColor(darkRatio)
         }
         
         if (tokenTextHighlightedColor != nil) {
            textColor = tokenTextHighlightedColor!
         } else {
            textColor = tokenTextColor
         }
         
      } else {
         backgroundColor = tokenBackgroundColor
         textColor = tokenTextColor
      }
      
      backgroundColor.setFill()
      rectanglePath.fill()
      
      var paddingX: CGFloat = 0.0
      var font = UIFont.systemFontOfSize(12)
      var tokenField: KSTokenField? {
         return superview! as? KSTokenField
      }
      if ((tokenField) != nil) {
         paddingX = tokenField!.paddingX()!
         font = tokenField!.tokenFont()!
      }
      
      // Text
      var rectangleTextContent = title
      let rectangleStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
      rectangleStyle.lineBreakMode = NSLineBreakMode.ByTruncatingTail
      rectangleStyle.alignment = NSTextAlignment.Center
      let rectangleFontAttributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: textColor, NSParagraphStyleAttributeName: rectangleStyle]
      
      var maxDrawableHeight = max(rect.height , font.lineHeight)
      let textHeight: CGFloat = KSUtils.getRect(rectangleTextContent, width: rect.width, height: maxDrawableHeight , font: font).size.height
      CGContextSaveGState(context)
      CGContextClipToRect(context, rect);
      
      let textRect = CGRect(x: rect.minX + paddingX, y: rect.minY + (maxDrawableHeight - textHeight) / 2, width: min(maxWidth, rect.width) - (paddingX*2), height: maxDrawableHeight)
      
      rectangleTextContent.drawInRect(textRect, withAttributes: rectangleFontAttributes)
      CGContextRestoreGState(context)
      
      // Border
      if (self.borderWidth > 0.0 && self.borderColor != UIColor.clearColor()) {
         self.borderColor.setStroke()
         rectanglePath.lineWidth = self.borderWidth
         rectanglePath.stroke()
      }
   }
}