//
//  CategoryColors.swift
//  Tracker
//
//  Created by Антон Шишкин on 26.04.24.
//

import UIKit

enum CategoryColor: CaseIterable {
    case color1
    case color2
    case color3
    case color4
    case color5
    case color6
    case color7
    case color8
    case color9
    case color10
    case color11
    case color12
    case color13
    case color14
    case color15
    case color16
    case color17
    case color18
    
    var uiColor: UIColor {
        switch self {
        case .color1: return UIColor(hex: "FD4C49")
        case .color2: return UIColor(hex: "FF881E")
        case .color3: return UIColor(hex: "007BFA")
        case .color4: return UIColor(hex: "6E44FE")
        case .color5: return UIColor(hex: "33CF69")
        case .color6: return UIColor(hex: "E66DD4")
        case .color7: return UIColor(hex: "F9D4D4")
        case .color8: return UIColor(hex: "34A7FE")
        case .color9: return UIColor(hex: "46E69D")
        case .color10: return UIColor(hex: "35347C")
        case .color11: return UIColor(hex: "FF674D")
        case .color12: return UIColor(hex: "FF99CC")
        case .color13: return UIColor(hex: "F6C48B")
        case .color14: return UIColor(hex: "7994F5")
        case .color15: return UIColor(hex: "832CF1")
        case .color16: return UIColor(hex: "AD56DA")
        case .color17: return UIColor(hex: "8D72E6")
        case .color18: return UIColor(hex: "2FD058")
        }
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
