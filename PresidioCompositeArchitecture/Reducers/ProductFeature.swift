//
//  ProductFeature.swift
//  PresidioCompositeArchitecture
//
//  Created by immanuel nowpert on 25/10/23.
//

import Foundation
import ComposableArchitecture

struct ProductFeature : Reducer {
    
    struct State : Equatable {
        var product : Product?
       
        
        init(product: Product? = nil) {
            self.product = product
        }
    }
    
    enum Action : Equatable {
        case onAppear
        case onDisappear
        case sendResponse(Product)
        
        
    }
    
    enum Cancellable {
        case timer
    }
    
    @Dependency (\.apiClient) var apiClient
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onAppear:
            return .run {[product = state.product] send in
                if let id = product?.id {
                    let apiResponse = await apiClient.getProduct(id)
                    switch apiResponse {
                    case .success(let product):
                        return await send(.sendResponse(product))
                    case .failure(_):
                        print("Error occured when fetching product in Product Feature")
                    }
                }
                
                
            }
            .cancellable(id: Cancellable.timer)
        case .sendResponse(let product ):
            state.product = product
            return .none
        case .onDisappear:
            return .cancel(id: Cancellable.timer)
            
        }
    }
}

