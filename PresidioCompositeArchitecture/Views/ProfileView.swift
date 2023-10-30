//
//  ProfileView.swift
//  PresidioCompositeArchitecture
//
//  Created by immanuel nowpert on 29/10/23.
//

import SwiftUI
import ComposableArchitecture
import MapKit

struct ProfileView: View {
    let store : StoreOf<ProfileFeature>
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            VStack{
                if viewStore.loading {
                    ProgressView()
                }
                else {
                    if let user = viewStore.user{
                        Image(systemName: "person.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(30)
                            .clipShape(Circle())
                            .frame(width: 100,height: 100)
                        
                        Text(user.name.firstname + " " + user.name.lastname)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text(user.email)
                            .font(.caption)
                        
                        
                        Spacer()
                        
                      
                        Map{
                           
                            Marker(coordinate: CLLocationCoordinate2D(latitude: Double(user.address.geolocation.lat) ?? -11.3159, longitude: Double(user.address.geolocation.long) ?? 81.1496)) {
                                Text(user.address.city)
                                    .tint(Color.green)
                            }
                        }
                        .frame(minWidth: 0)
                        .frame(height: 300)
                        .mapStyle(.imagery(elevation: .realistic))
                        
                        
                        
                    }
                    
                    
                }
            }
            .padding(10)
            .task {
                viewStore.send(.onReady,animation: .easeIn)
            }
        }
    }
}

#Preview {
    ProfileView(store: .init(initialState: ProfileFeature.State(), reducer: {
        ProfileFeature()
            ._printChanges()
    }))
}
