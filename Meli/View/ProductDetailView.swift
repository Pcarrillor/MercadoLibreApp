//
//  ProductsDetailView.swift
//  Meli
//
//  Created by Pedro Carrillo on 22/02/24.
//

import SwiftUI
import Combine

struct ProductDetailView: View {
    let id: String
    @State var selectedProduct: Product?
    @State var productDescription: ProductDescription?
    @State private var currentPage = 0
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(selectedProduct?.title ?? "N/A")
                    .multilineTextAlignment(.leading).padding()
                
                TabView(selection: $currentPage) {
                    ForEach(0..<(selectedProduct?.pictures?.count ?? 0), id: \.self) { index in
                        let picture = selectedProduct?.pictures?[index]
                        ImageLoadingView(url: picture?.secureURL ?? "", key: picture?.id ?? "")
                            .padding()
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .frame(height: 350)
                .padding(.horizontal)
                .overlay(
                    Text("\(currentPage+1) / \(selectedProduct?.pictures?.count ?? 1)")
                        .padding(8)
                        .padding(.horizontal, 8)
                        .foregroundColor(.black)
                        .background(Color.gray.opacity(0.2))
                        .background(Color.white)
                        .cornerRadius(25)
                        .padding(.horizontal),
                    alignment: .topLeading
                )
                
                // Descripción del ítem y otros detalles
                VStack(alignment: .leading, spacing: 8) {
                    Text("$ \(selectedProduct?.price ?? 0)")
                        .font(.title)
                    
                    if selectedProduct?.shipping?.freeShipping == true {
                        Text("Envío gratis").font(.caption).foregroundColor(.green).bold()
                    }

                    if (productDescription?.plainText != "") && (productDescription?.plainText != nil) {
                        Divider()
                        Text("Descripción").font(.title2).padding(.vertical)
                        Text(productDescription?.plainText ?? "").foregroundColor(.black)
                    }

                    Spacer()
                }
                .padding()
            }
        }
        .customshowBack(true)
        .onAppear{
            loadProductInfo(id)
            loadProductDescription(id)
        }
    }
    
    func loadProductInfo(_ id: Result.ID) {
        var cancellables = Set<AnyCancellable>()
        let url = URL(string: "https://api.mercadolibre.com/items/\(id ?? "")")
        // Create the url request
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        // the response expected to be in JSON format
        
        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    let dataResponse: String = String(data: data, encoding: .utf8) ?? "Error proceso"
                    debugPrint("Error: " + dataResponse)
                    debugPrint(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: Product.self, decoder: JSONDecoder())
            .sink { (completion) in
                debugPrint("Completion: \(completion)")
            } receiveValue: { response in
                selectedProduct = response
            }
            .store(in: &cancellables)
    }
    
    func loadProductDescription(_ id: Result.ID) {
        var cancellables = Set<AnyCancellable>()
        let url = URL(string: "https://api.mercadolibre.com/items/\(id ?? "")/description")
        // Create the url request
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        // the response expected to be in JSON format
        
        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    let dataResponse: String = String(data: data, encoding: .utf8) ?? "Error proceso"
                    debugPrint("Error: " + dataResponse)
                    debugPrint(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: ProductDescription.self, decoder: JSONDecoder())
            .sink { (completion) in
                debugPrint("Completion: \(completion)")
            } receiveValue: { response in
                productDescription = response
            }
            .store(in: &cancellables)
    }
}


struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(id: "MCO1365952431")
    }
}
