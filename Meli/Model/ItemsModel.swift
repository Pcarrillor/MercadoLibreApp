//
//  ItemsModel.swift
//  Meli
//
//  Created by Pedro Carrillo on 22/02/24.
//

import Foundation

// MARK: - Items
struct Items: Codable {
    let siteID: String?
    let countryDefaultTimeZone: String?
    let paging: Paging?
    let results: [Result]?
    let sort: Sort?
    let availableSorts: [Sort]?
    let filters: [Filter]?
    let availableFilters: [AvailableFilter]?
    let pdpTracking: PDPTracking?

    enum CodingKeys: String, CodingKey {
        case siteID = "site_id"
        case countryDefaultTimeZone = "country_default_time_zone"
        case paging, results, sort
        case availableSorts = "available_sorts"
        case filters
        case availableFilters = "available_filters"
        case pdpTracking = "pdp_tracking"
    }
}

// MARK: - AvailableFilter
struct AvailableFilter: Codable {
    let id, name, type: String?
    let values: [AvailableFilterValue]?
}

// MARK: - AvailableFilterValue
struct AvailableFilterValue: Codable {
    let id, name: String?
    let results: Int?
}

// MARK: - Sort
struct Sort: Codable {
    let id, name: String?
}

// MARK: - Filter
struct Filter: Codable {
    let id, name, type: String?
    let values: [FilterValue]?
}

// MARK: - FilterValue
struct FilterValue: Codable {
    let id, name: String?
    let pathFromRoot: [Sort]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case pathFromRoot = "path_from_root"
    }
}

// MARK: - Paging
struct Paging: Codable {
    let total, primaryResults, offset, limit: Int?

    enum CodingKeys: String, CodingKey {
        case total
        case primaryResults = "primary_results"
        case offset, limit
    }
}

// MARK: - PDPTracking
struct PDPTracking: Codable {
    let group: Bool?
    let productInfo: [ProductInfo]?

    enum CodingKeys: String, CodingKey {
        case group
        case productInfo = "product_info"
    }
}

// MARK: - ProductInfo
struct ProductInfo: Codable {
    let id: String?
    let score: Int?
    let status: String?
}


// MARK: - Result
struct Result: Codable, Identifiable, Hashable {
    static func == (lhs: Result, rhs: Result) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id, title: String?
    let condition: String?
    let thumbnailID: String?
    let catalogProductID: String?
    let listingTypeID: String?
    let permalink: String?
    let buyingMode: String?
    let siteID: String?
    let categoryID, domainID: String?
    let thumbnail: String?
    let currencyID: String?
    let orderBackend, price: Int?
    let originalPrice: Int?
    let salePrice: String?
    let availableQuantity: Int?
    let officialStoreID: Int?
    let useThumbnailID, acceptsMercadopago: Bool?
    let shipping: Shipping?
    let stopTime: String?
    let seller: Seller?
    let attributes: [Attribute]?
    let installments: Installments?
    let winnerItemID: String?
    let catalogListing: Bool?
    let discounts: String?
    let promotions: [String]?
    let differentialPricing: DifferentialPricing?
    let inventoryID: String?
    let officialStoreName: String?
    let variationFilters: [String]?
    let variationsData: [String: VariationsDatum]?

    enum CodingKeys: String, CodingKey {
        case id, title, condition
        case thumbnailID = "thumbnail_id"
        case catalogProductID = "catalog_product_id"
        case listingTypeID = "listing_type_id"
        case permalink
        case buyingMode = "buying_mode"
        case siteID = "site_id"
        case categoryID = "category_id"
        case domainID = "domain_id"
        case thumbnail
        case currencyID = "currency_id"
        case orderBackend = "order_backend"
        case price
        case originalPrice = "original_price"
        case salePrice = "sale_price"
        case availableQuantity = "available_quantity"
        case officialStoreID = "official_store_id"
        case useThumbnailID = "use_thumbnail_id"
        case acceptsMercadopago = "accepts_mercadopago"
        case shipping
        case stopTime = "stop_time"
        case seller, attributes, installments
        case winnerItemID = "winner_item_id"
        case catalogListing = "catalog_listing"
        case discounts, promotions
        case differentialPricing = "differential_pricing"
        case inventoryID = "inventory_id"
        case officialStoreName = "official_store_name"
        case variationFilters = "variation_filters"
        case variationsData = "variations_data"
    }
}

// MARK: - Attribute
struct Attribute: Codable {
    let id, name: String?
    let valueID, valueName: String?
    let attributeGroupID: String?
    let attributeGroupName: String?
    let valueStruct: Struct?
    let values: [AttributeValue]?
    let source: Double?
    let valueType: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case valueID = "value_id"
        case valueName = "value_name"
        case attributeGroupID = "attribute_group_id"
        case attributeGroupName = "attribute_group_name"
        case valueStruct = "value_struct"
        case values, source
        case valueType = "value_type"
    }
}

// MARK: - Struct
struct Struct: Codable {
    let number: Double?
    let unit: String?
}

// MARK: - AttributeValue
struct AttributeValue: Codable {
    let id, name: String?
    let valueStruct: Struct?
    let source: Double?

    enum CodingKeys: String, CodingKey {
        case id, name
        case valueStruct = "struct"
        case source
    }
}

// MARK: - DifferentialPricing
struct DifferentialPricing: Codable {
    let id: Int?
}

// MARK: - Installments
struct Installments: Codable {
    let quantity: Int?
    let amount: Double?
    let rate: Int?
    let currencyID: String?

    enum CodingKeys: String, CodingKey {
        case quantity, amount, rate
        case currencyID = "currency_id"
    }
}

// MARK: - Seller
struct Seller: Codable {
    let id: Int?
    let nickname: String?
}


// MARK: - VariationsDatum
struct VariationsDatum: Codable {
    let thumbnail: String?
    let ratio, name: String?
    let picturesQty: Int?
    let inventoryID: String?

    enum CodingKeys: String, CodingKey {
        case thumbnail, ratio, name
        case picturesQty = "pictures_qty"
        case inventoryID = "inventory_id"
    }
}
