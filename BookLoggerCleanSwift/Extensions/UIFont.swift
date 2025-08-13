//
//  UIFont.swift
//  BookLoggerCleanSwift
//
//  Created by Panachai Sulsaksakul on 8/13/25.
//

import UIKit

extension UIFont {
    func withWeight(_ weight: UIFont.Weight) -> UIFont {
        let descriptor = fontDescriptor.addingAttributes([.traits: [UIFontDescriptor.TraitKey.weight: weight]])
        return UIFont(descriptor: descriptor, size: pointSize)
    }
}
