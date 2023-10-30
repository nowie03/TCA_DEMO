//
//  PresidioCompositeArchitectureApp.swift
//  PresidioCompositeArchitecture
//
//  Created by immanuel nowpert on 25/10/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct PresidioCompositeArchitectureApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(store: Store(initialState: AppFeature.State(selectedTab: .home), reducer: {
                AppFeature()
            }))
        }
    }
}
