//
//  CustomNavBarView.swift
//  Meli
//
//  Created by Pedro Carrillo on 24/02/24.
//

import SwiftUI

struct CustomNavBarView: View {
    @Environment(\.presentationMode) var presentationMode
    let showBackButton: Bool
    @State var buscar: String = ""
    var body: some View {
        HStack{
            if showBackButton{
                backButton
                Spacer()
            }
            HStack{
                Image(systemName: "magnifyingglass").foregroundColor(.gray)
                TextField("Buscar en Mercadolibre", text: $buscar)
            }
            .padding(.horizontal)
            .padding(.vertical, 6)
            .background(RoundedRectangle(cornerRadius: 25).fill(Color.white))
            
            CustomNavLink {
                SearchView(searchText: $buscar)
            } label: {
                Text("Buscar")
                    .foregroundColor(buscar == "" ? .gray : .white)
            }
        }
        .padding()
        .background(Color.yellow.ignoresSafeArea())
    }
}

extension CustomNavBarView {
    public var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
        }
        .foregroundColor(.gray)

    }
}

struct CustomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarView(showBackButton: false)
    }
}
