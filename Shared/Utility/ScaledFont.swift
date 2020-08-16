//
//  ScaledFont.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 16/08/20.
//

import SwiftUI

enum FontType:String {
    case regular = "SFProDisplay-Regular"
    case medium = "SFProDisplay-Medium"
    case semiBold = "SFProDisplay-Semibold"
    case bold = "SFProDisplay-Bold"
}

@available(iOS 13, *)
extension View {
    func scaledFont(type: FontType, size: CGFloat) -> some View {
        return self.modifier(ScaledFont(name: type.rawValue, size: size))
    }
}

@available(iOS 13, *)
struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: CGFloat

    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
       return content.font(.custom(name, size: scaledSize))
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    func scaledFont(name: String, size: CGFloat) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
}
