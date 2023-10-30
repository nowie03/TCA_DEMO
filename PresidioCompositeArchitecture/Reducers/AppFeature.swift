//
//  AppFeature.swift
//  PresidioCompositeArchitecture
//
//  Created by immanuel nowpert on 26/10/23.
//

import Foundation
import ComposableArchitecture

public enum Tab {
    case home
    case favourites
}


struct AppFeature : Reducer {
 
    struct State : Equatable {
        var selectedTab : Tab
        var home = HomeFeature.State()
        var favourites = FavouriteFeature.State()
       
        
    }
    
    enum Action : Equatable {
        case setTab(Tab)
        case home(HomeFeature.Action)
        case favourites(FavouriteFeature.Action)
       
    }
    
    
    var body : some ReducerOf<Self>{
     
        Scope(state: \.favourites, action: /Action.favourites) {
            FavouriteFeature()
        }
        Scope(state: \.home, action: /Action.home) {
            HomeFeature()
        }
      
        Reduce{
            state , action in
            
            switch action {
            case .setTab(let tab):
                state.selectedTab = tab
                return .none
        
            case .home(.products(.addtoFavourites(let product))):
                print("3")
                state.home.products.products?[id:product.id]?.isFavourite = true
                state.favourites.favouriteProducts.append(product)
                return .none
                
            case .favourites(.removeFromFavourites(let product)):
                let indexOfProduct = state.favourites.favouriteProducts.firstIndex(of: product) ?? 0
                state.favourites.favouriteProducts.remove(at: indexOfProduct)
                return .none
                
            case .favourites(_):
                return .none
            
           
           
            case .home(_):
                
                return .none
            }
        }
    }
}
