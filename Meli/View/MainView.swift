//
//  MainView.swift
//  Meli
//
//  Created by Pedro Carrillo on 22/02/24.
//

import SwiftUI
import Combine

struct MainView: View {

    var cancellables = Set<AnyCancellable>()
    @State var categories: [Category] = []
    @State var categoryItems: Items?
    let countryCode = "CO"
    @State var buscar: String = ""
    @State var showDetail: Bool = false
    @State var selectedProduct: String = ""
    @State var currentCategory: String = ""
    @State var isLoading: Bool = true
    
    var body: some View {
        CustomNavView {
            ScrollView {
                ScrollView(.horizontal){
                    HStack{
                        ForEach(categories) { category in
                            Text(category.name)
                                .padding()
                                .onTapGesture {
                                    currentCategory = category.id
                                    loadItems(category.id)
                                    showDetail = false
                                    selectedProduct = ""
                                }
                        }
                    }
                }
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
        }.onAppear{
            loadCategories()
        }
    }
    
    func loadCategories() {
        var cancellables = Set<AnyCancellable>()
        
        let url = URL(string: "https://api.mercadolibre.com/sites/M\(countryCode)/categories")
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
            .decode(type: [Category].self, decoder: JSONDecoder())
            .sink { (completion) in
                debugPrint("Completion: \(completion)")
                if categories.isEmpty {
                    isLoading = false
                }
            } receiveValue: { response in
                categories = response
                if categoryItems == nil && !(categories.isEmpty) {
                    loadItems(categories[0].id)
                }
            }
            .store(in: &cancellables)
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
