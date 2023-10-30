//
//  CounterFeature.swift
//  PresidioCompositeArchitecture
//
//  Created by immanuel nowpert on 25/10/23.
//

import Foundation
import ComposableArchitecture

struct CounterFeature : Reducer {
    struct State : Equatable {
        var count = 0
        var numFactAlert : String?
        var productResponse : ProductResponse?
    }
    
    enum Action : Equatable {
        case factAlertDismissed
        case decrementButtonTapped
        case incrementButtonTapped
        case numberFactButtonTapped
        case numberFactResponse(ProductResponse)
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .factAlertDismissed :
            state.numFactAlert = nil
            return .none
            
        case .decrementButtonTapped:
            state.count -= 1
            return .none
        case .incrementButtonTapped :
            state.count += 1
            return .none
        case .numberFactButtonTapped :
            return .run {
                [count = state.count] send in
                let (data,_) = try await URLSession.shared.data(from: URL(string:"https://fakestoreapi.com/products/1")!)
                guard let parsedData = try? JSONDecoder().decode(ProductResponse.self, from: data) else {
                    return
                }
                await send(.numberFactResponse(parsedData))
            }
        case let .numberFactResponse( data):
            state.productResponse = data
            return .none
                           
        }
    }
    
    
    
    
}

extension Reducer {
  func logActions() -> some Reducer<State, Action> {
    Reduce { state, action in
      print("Received action: \(action)")
      return self.reduce(into: &state, action: action)
    }
  }
}


struct ProductResponse :Codable,Equatable{
    var title : String?
    var image : String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
    }
    
    
    
}
