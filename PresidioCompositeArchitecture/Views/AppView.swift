//
//  TabView.swift
//  PresidioCompositeArchitecture
//
//  Created by immanuel nowpert on 25/10/23.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    let store:StoreOf<AppFeature>
    
    var body: some View {
    
            TabView {
                HomeView(store: store.scope(state: \.home, action: {.home($0)}))
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                    .tag(Tab.home)
                
                FavouritesView(store: store.scope(state: \.favourites, action: {.favourites($0)}))
                    .tabItem {
                        Image(systemName: "heart.fill")
                    }
                    .tag(Tab.favourites)
            }
            
    }
}

#Preview {
    
    AppView(store: Store(initialState: AppFeature.State(selectedTab: .home), reducer: {
        AppFeature()
            ._printChanges()
    }))
   
}
