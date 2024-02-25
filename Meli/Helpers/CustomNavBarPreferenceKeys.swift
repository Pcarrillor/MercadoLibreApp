//
//  CustomNavBarPreferenceKeys.swift
//  Meli
//
//  Created by Pedro Carrillo on 24/02/24.
//

import Foundation
import SwiftUI

struct CustomShowBackPreferenceKey: PreferenceKey {
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

extension View {
    
    func customshowBack(_ show: Bool) -> some View {
        preference(key: CustomShowBackPreferenceKey.self, value: show)
    }
    
}
