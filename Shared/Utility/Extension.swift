//
//  Extension.swift
//  SwiftUI-MVVM-Sample
//
//  Created by Malav Soni on 16/08/20.
//
import SwiftUI

extension Color {
    static var appPrimary:Color {
        return Color("primary")
    }
    static var appSecondary:Color {
        return Color("secondary")
    }
    static var appSeperator:Color {
        return Color("seperator")
    }
    static var appPrimaryLight:Color {
        return Color("primary-light")
    }
}

extension String {
    var localized:String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "failed", comment: "Error")
    }
}

extension Double {
    func toKmPerHour() -> Double {
        return self * 3.6
    }
}

extension UINavigationBar {
    var shadow: Bool {
        get {
            return false
        }
        set {
            if newValue {
                self.layer.shadowOffset = CGSize(width: 0, height: 2)
                self.layer.shadowColor = UIColor.lightGray.cgColor
                self.layer.shadowRadius = 3
                self.layer.shadowOpacity = 0.5
            }
        }
    }
}
