//
//  View+isHidden.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/10/18.
//

import SwiftUI

extension View {
    @ViewBuilder
    func isHidden(_ isHidden: Bool, remove: Bool) -> some View {
        if isHidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
