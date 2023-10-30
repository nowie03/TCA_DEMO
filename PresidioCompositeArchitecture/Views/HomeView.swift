//
//  HomeView.swift
//  PresidioCompositeArchitecture
//
//  Created by immanuel nowpert on 29/10/23.
//

import SwiftUI
import ComposableArchitecture
struct HomeView: View {
    let store : StoreOf<HomeFeature>
    var body: some View {
       
        NavigationStackStore(store.scope(state: \.path, action: {.path($0)}), root: {
            WithViewStore(store, observe: {$0}) { viewStore in
                VStack {
                    CategoriesView(store: store.scope(state: \.categories, action: {.categories($0)}))
                    ProductsView(store: store.scope(state: \.products, action: {.products($0)}))
                }
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            viewStore.send(.profileButtonTapped)
                        }, label: {
                            Image(systemName: "person.fill")
                        })
                    }
                }
                .padding(10)
            }
        }, destination: { state in
            //path reducer
            switch state {
            case .product :
                CaseLet(/HomeFeature.Path.State.product, action: HomeFeature.Path.Action.product) { store in
                    ProductView(store: store)
                }
            case .profile:
                CaseLet(/HomeFeature.Path.State.profile, action: HomeFeature.Path.Action.profile) { store in
                        ProfileView(store:store)
                    
                }
               
            }
            
            
        })
            
        
    }
}

#Preview {
    HomeView(store: Store(initialState: HomeFeature.State(), reducer: {
        HomeFeature()._printChanges()
    }))
}
