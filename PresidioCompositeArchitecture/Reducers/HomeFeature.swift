//
//  HomeFeature.swift
//  PresidioCompositeArchitecture
//
//  Created by immanuel nowpert on 29/10/23.
//

import Foundation
import ComposableArchitecture

struct HomeFeature : Reducer {
    struct State : Equatable{
        var products = ProductsFeature.State()
        var categories = CategoryFeature.State(activeCategory: "electronics")
        var path = StackState<Path.State>()
        
       
    }
    
    enum Action : Equatable{
        case products (ProductsFeature.Action)
        case categories (CategoryFeature.Action)
        case path (StackAction<Path.State,Path.Action>)
        case profileButtonTapped
    }
    
    @Dependency (\.apiClient) var apiClient
    
    struct Path : Reducer{
        enum State :Equatable{
            case product(ProductFeature.State)
            case profile(ProfileFeature.State)
        }
        
        enum Action :Equatable{
            case product(ProductFeature.Action)
            case profile(ProfileFeature.Action)
        }
        
        var body: some ReducerOf<Self>{
            Scope(state: /State.product, action: /Action.product) {
                ProductFeature()
            }
            Scope(state: /State.profile, action: /Action.profile) {
                ProfileFeature()
            }
        }
       
    }

    
    var body : some ReducerOf<Self>{
        Scope(state: \.products, action: /Action.products) {
            ProductsFeature()
        }
        Scope(state: \.categories, action: /Action.categories) {
            CategoryFeature()
        }
        Reduce{
            state , action in
            switch action {
            case .products(.viewOnReady):
                return .run {
                    [category = state.categories.activeCategory]
                    send in
                    let apiResponse = await apiClient.getProducts(category)
                    
                    switch apiResponse {
                    case .success(let products):
                        await send(.products(.sendResponse(products)))
                    case  .failure(_):
                        print("Error occured when fetching products in Home Feature")
                    }
                  
                        
                }
            case .products(.sendResponse(let products)):
                state.products = ProductsFeature.State(products: IdentifiedArray(uniqueElements: products))
                return .none
            
            
            case .products(.buyNowButtonTapped(let product)):
                state.path.append(.product(ProductFeature.State(product: product)))
                return .none
           
                
            case .products(_):
                print("2")
                return .none
                
                
            case .categories(.getCategories):
                return .run { send in
                    let apiReponse = await apiClient.getCategories()
                    
                    switch apiReponse {
                    case .success(let categories):
                        await send(.categories(.parseResponse(categories)))
                    case .failure(_):
                        print("Error occured whern fetching categories in home feature")
                    }
                    
                }
            case .categories(.setActiveCategory(let category)):
                state.categories.activeCategory = category
                return .send(.products(.viewOnReady))
            case .categories(_):
                return .none
           
            
            case .path(_):
                return .none
                
            case .profileButtonTapped :
                state.path.append(.profile(.init()))
                return .none
            }
        }.forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}
