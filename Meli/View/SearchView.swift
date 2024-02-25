//
//  SearchView.swift
//  Meli
//
//  Created by Pedro Carrillo on 22/02/24.
//

import SwiftUI
import Combine

struct SearchView: View {
    @Binding var searchText: String
    @State var categoryItems: Items?
    @State var isLoading: Bool = true
    let countryCode = "CO"

    var body: some View {
        ScrollView{
            if isLoading {
                ProgressView()
            } else {
                if categoryItems != nil {
                    ProductListView(productList: categoryItems?.results ?? [])
                }  else {
                    Text("No existen datos para la búsqueda.")
                }
            }
        }
        .onAppear{
            loadItems(search: searchText.replacingOccurrences(of: " ", with: "%20"))
        }
        .customshowBack(true)
    }
    
    func loadItems(_ id: Category.ID = "", search: String = "") {
        var cancellables = Set<AnyCancellable>()
        let complement = search != "" ? "q=\(search)" : "category=\(id)"
        let url = URL(string: "https://api.mercadolibre.com/sites/M\(countryCode)/search?\(complement)")
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
            .decode(type: Items.self, decoder: JSONDecoder())
            .sink { (completion) in
                debugPrint("Completion: \(completion)")
                isLoading = false
            } receiveValue: { response in
                categoryItems = response
            }
            .store(in: &cancellables)
    }
}

//
//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
