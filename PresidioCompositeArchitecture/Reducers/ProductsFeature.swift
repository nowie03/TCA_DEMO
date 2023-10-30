//
//  ProductsFeature.swift
//  PresidioCompositeArchitecture
//
//  Created by immanuel nowpert on 25/10/23.
//

import Foundation
import ComposableArchitecture


struct ProductsFeature : Reducer {
    struct State : Equatable {
        var products : IdentifiedArrayOf<Product>?
        var product = ProductFeature.State()
        
        var category : String?
        
    }
    
    enum Action : Equatable {
       
        case viewOnReady
        case viewOnDispose
        case addtoFavourites(Product)
        case sendResponse([Product])
       
        case product(ProductFeature.Action)
        case buyNowButtonTapped(Product)
       
    }
    

    
    var body : some ReducerOf<Self>{
        Reduce { state, action in
            switch action {
                
            case .addtoFavourites(_):
                print("1")
                return .none
            
            case .viewOnReady:
                return .none
                //.cancellable(id: Cancellable.timer)
                
            case .viewOnDispose :
                return .none
                //return .cancel(id: Cancellable.timer)
                
            case .sendResponse(_):
               
                return .none
            case .product(_):
                return .none
                
            case .buyNowButtonTapped(_):
//                state.path.append(.init(product: product))
                
                return .none

            }
        }
        
       
    }
        
    
}
   

enum Cancellable {
    case timer
}

