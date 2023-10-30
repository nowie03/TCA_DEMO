//
//  HomeView.swift
//  PresidioCompositeArchitecture
//
//  Created by immanuel nowpert on 29/10/23.
//

import SwiftUI
import ComposableArchitecture

struct CategoriesView: View {
    let store : StoreOf<CategoryFeature>
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            ScrollView(.horizontal, content: {
                HStack(content: {
                    ForEach(viewStore.categories,id:\.hashValue){category in
                        Button(action: {
                            viewStore.send(.setActiveCategory(category))
                        }, label: {
                            Text(category)
                                .padding(10)
                                .foregroundStyle(viewStore.activeCategory == category ? Color.white : Color.black)
                                .background(RoundedRectangle(cornerRadius: 16)
                                    .fill(viewStore.activeCategory == category ? Color.cyan : Color.gray.opacity(0.2)))
                        })
                        
                            
                    }
                })
            })
            .task {
                viewStore.send(.getCategories)
            }
        }
    }
}

#Preview {
    CategoriesView(store: Store(initialState: CategoryFeature.State(activeCategory:"none"), reducer: {
        CategoryFeature()
    }))
}
