//
//  Color+Random.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/09/21.
//

import SwiftUI

extension Color {
    static func random() -> Color {
        Color(
            red: 1,
            green: .random(in: 0.4...0.6),
            blue: .random(in: 0.4...0.7),
            opacity: 0.6
        )
    }
}
