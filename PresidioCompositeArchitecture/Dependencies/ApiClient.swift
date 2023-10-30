//
//  ApiClient.swift
//  PresidioCompositeArchitecture
//
//  Created by immanuel nowpert on 30/10/23.
//

import Foundation
import ComposableArchitecture

struct ApiClient  {
    var getUser : (Int) async -> Result<User,ApiError>
    var getProduct : (Int) async -> Result<Product,ApiError>
    var getCategories : () async -> Result<[String],ApiError>
    var getProducts : (String) async -> Result<[Product],ApiError>
//    var postProduct : (Product) async -> Result<Product,ApiError>
    
}

enum ApiError : Error {
    case urlParseFailed
    case dataFetchFailed
    case dataParseFailed
}


extension ApiClient : DependencyKey{
    static var liveValue = ApiClient { id in
        guard let url = URL(string: "https://fakestoreapi.com/users/1") else {
            return .failure(.urlParseFailed)
        }
        
        guard let (data,_) = try? await URLSession.shared.data(from: url) else {
            return .failure(.dataFetchFailed)
        }
        
        guard let user = try? JSONDecoder().decode(User.self, from: data) else {
            return .failure(.dataParseFailed)
        }
        return .success(user)
        
    } getProduct: { id in
        
        guard let (data,_) = try? await URLSession.shared.data(from: URL(string:"https://fakestoreapi.com/products/\(id)")!) else {
            return .failure(.dataFetchFailed)
        }
        
        guard let product = try? JSONDecoder().decode(Product.self, from: data ) else {
            return .failure(.dataParseFailed)
        }
        
        return .success(product)
        
    } getCategories: {
        guard let url = URL(string:"https://fakestoreapi.com/products/categories") else {
            return .failure(.urlParseFailed)
        }
        
        guard let (data,_) = try? await URLSession.shared.data(from: url) else {
            return .failure(.dataFetchFailed)
        }
        
        guard let categories = try? JSONDecoder().decode([String].self, from: data) else {
            return .failure(.dataParseFailed)
        }
        
        return .success(categories)
        
    } getProducts: { category in
        
        guard let (data,_) = try? await URLSession.shared.data(from:URL(string:"https://fakestoreapi.com/products/category/\(category )")!) else {
            return .failure(.dataFetchFailed)
        }
        guard let products = try?  JSONDecoder().decode([Product].self, from: data) else  {
            return .failure(.dataParseFailed)
        }
        
        return .success(products)
    }
}

extension DependencyValues {
    var apiClient : ApiClient{
        get  {
            self[ApiClient.self]
        }
        
        set {
            self [ApiClient.self] = newValue
        }
    }
}
