//
//  SwiftUIView.swift
//  Meli
//
//  Created by Pedro Carrillo on 24/02/24.
//

import SwiftUI

struct CustomNavBarContainerView<Content:View>: View {
    
    let content: Content
    @State var showBackButton: Bool = false
    @State var buscar: String = ""
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        VStack(spacing:0){
            CustomNavBarView(showBackButton: showBackButton)
            content
        }
        .onPreferenceChange(CustomShowBackPreferenceKey.self) { value in
            self.showBackButton = value
        }
    }
}

struct CustomNavBarContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarContainerView {
            Color.orange
        }
    }
}
