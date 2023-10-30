//
//  CategoryFeature.swift
//  PresidioCompositeArchitecture
//
//  Created by immanuel nowpert on 29/10/23.
//

import Foundation
import ComposableArchitecture

struct CategoryFeature : Reducer{
    struct State : Equatable {
        var categories = [String]()
        var activeCategory : String
    }
    
    enum Action : Equatable{
        case getCategories
        case parseResponse([String])
        case setActiveCategory(String)
    }
    
    var body: some ReducerOf<Self>{
        Reduce {
            state , action in
            switch action {
            
            case .getCategories:
                return .none
            case .parseResponse(let categories):
                state.categories = categories
                state.activeCategory = categories[0]
                return .none
            case .setActiveCategory(_):
                return .none
            }
        }
    }
}
