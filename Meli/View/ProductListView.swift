//
//  ProductListView.swift
//  Meli
//
//  Created by Pedro Carrillo on 24/02/24.
//

import SwiftUI

struct ProductListView: View {
    let productList: [Result]
    var body: some View {
        ScrollView {
            LazyVStack {
                if let products = productList {
                    ForEach(products) { product in
                        CustomNavLink {
                            ProductDetailView(id: product.id ?? "")
                        } label: {
                            HStack(alignment: .top, spacing:0){
                                let thumbnail = "https://http2.mlstatic.com/D_NQ_NP_\( product.thumbnailID!)-V.jpg"
                                ImageLoadingView(url: thumbnail, key: "\(product.id)")
                                    .padding(.horizontal)
                                    .frame(width: 150, height: 150)
                                VStack(alignment:.leading, spacing: 8){
                                    Text("\(product.title ?? "N/A")")
                                        .font(.subheadline)
                                        .multilineTextAlignment(.leading)
                                    Text("$ \(product.price ?? 0)").font(.title3).bold()
                                    if (product.installments != nil) {
                                        Text("en \(product.installments?.quantity ?? 0)x $ \(product.installments?.amount ?? 0)")
                                    }
                                    if product.shipping?.freeShipping  == true {
                                        Text("Envío gratis").font(.caption).foregroundColor(.green)
                                    }
                                }.padding(.vertical)
                                Spacer()
                            }
                            .foregroundColor(.black)
                        }
                    }
                } else {
                    Text("No category items available.")
                }
            }
        }
    }
}
