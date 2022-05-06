import UIKit
enum FontWeight: String {
    
    case chalkboard = "Chalkboard"
//    case extraBold = "Manrope-ExtraBold"
//    case extraLight = "Manrope-ExtraLight"
//    case light = "Manrope-Light"
//    case medium = "Manrope-Medium"
//    case regular = "Manrope-Regular"
//    case semiBold = "Manrope-SemiBold"
}
//
extension UIFont {
    static func manrope(ofSize size: CGFloat, weight: FontWeight) -> UIFont {
        return UIFont(name: weight.rawValue, size: size)!
    }
}
