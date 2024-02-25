//
//  CustonNavLink.swift
//  Meli
//
//  Created by Pedro Carrillo on 24/02/24.
//

import SwiftUI

struct CustomNavLink<Label, Destination> : View where Label: View, Destination: View {
    
    let destination: Destination
    let label: Label
    
    init(@ViewBuilder destination: () -> Destination, @ViewBuilder label: () -> Label){
        self.destination = destination()
        self.label = label()
    }
    
    var body: some View {
        NavigationLink {
            CustomNavBarContainerView {
                destination
            }
            .navigationBarHidden(true)
        } label: {
            label
        }
    }
}

struct CustomNavLink_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView {
            CustomNavLink {
                Text("Destination")
            } label: {
                Text("Navigate")
            }
        }
    }
}
