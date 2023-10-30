//
//  FavourtitesReducer.swift
//  PresidioCompositeArchitecture
//
//  Created by immanuel nowpert on 26/10/23.
//

import Foundation
import ComposableArchitecture

struct FavouriteFeature : Reducer {

    struct State : Equatable {
        var favouriteProducts = [Product]()
    }
    
    enum Action : Equatable {
        case removeFromFavourites(Product)
    }
    
    var body : some ReducerOf<Self>{
        Reduce {
            state , action in
            switch action {
            case .removeFromFavourites(_):
                return .none
                
            }
        }
    }
}
