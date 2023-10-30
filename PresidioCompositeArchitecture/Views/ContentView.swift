//
//  ContentView.swift
//  PresidioCompositeArchitecture
//
//  Created by immanuel nowpert on 25/10/23.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    let store : StoreOf<CounterFeature>
    
    var body: some View {
        WithViewStore(store.self, observe: {$0}) { viewStore in
            VStack {
                   HStack {
                     Button("−") { viewStore.send(.decrementButtonTapped) }
                     Text("\(viewStore.count)")
                     Button("+") { viewStore.send(.incrementButtonTapped) }
                   }

                   Button("Number fact") { viewStore.send(.numberFactButtonTapped) }
                 }
                 .alert(
                   item: viewStore.binding(
                     get: { $0.numFactAlert.map(FactAlert.init(title:)) },
                     send: .factAlertDismissed
                   ),
                   content: { Alert(title: Text($0.title)) }
                 )
               }
    }
}

struct FactAlert: Identifiable {
  var title: String
  var id: String { self.title }
}

#Preview {
    ContentView(store:Store(initialState: CounterFeature.State(), reducer: {
        CounterFeature()
            ._printChanges()
    }))
}
