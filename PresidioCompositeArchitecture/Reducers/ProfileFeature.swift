//
//  ProfileFeature.swift
//  PresidioCompositeArchitecture
//
//  Created by immanuel nowpert on 29/10/23.
//

import Foundation
import ComposableArchitecture

struct ProfileFeature : Reducer{
    
    struct State : Equatable {
        var user : User?
        var loading : Bool = false
    }
    
    enum Action : Equatable {
        case onReady
        case parseResponse(User)
    }
    
    @Dependency(\.apiClient) var apiClient
    
    
    var body: some ReducerOf<Self>{
        Reduce {
            state , action in
            switch action {
            case .onReady:
                state.loading = true
                return .run{
                    send in
                    let apiResponse = await apiClient.getUser(1)
                    switch apiResponse {
                    case .success(let user):
                        await send(.parseResponse(user))
                    case .failure(_):
                        print("error when fetching user in profile view")
                        
                    }
                   
                }
            case .parseResponse(let user):
                state.user = user
                state.loading = false
                return .none
            }
        }
    }
}
