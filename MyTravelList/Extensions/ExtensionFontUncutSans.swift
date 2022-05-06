import UIKit

enum FontWeight: String {
    case semibold = "Uncut-Sans-Semibold"
    case regular = "Uncut-Sans-Regular"
    case medium = "Uncut-Sans-Medium"
    case bold = "Uncut-Sans-Bold"
}

extension UIFont {
    static func uncutSans(ofSize size: CGFloat, weight: FontWeight) -> UIFont {
        return UIFont(name: weight.rawValue, size: size)!
    }
}

