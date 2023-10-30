//
//  FavouritesView.swift
//  PresidioCompositeArchitecture
//
//  Created by immanuel nowpert on 26/10/23.
//

import SwiftUI
import ComposableArchitecture

struct FavouritesView: View {
    let store : StoreOf<FavouriteFeature>
    
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            List {
                ForEach(viewStore.favouriteProducts,id:\.id){
                    product in
                    HStack(alignment:.center, spacing:10,content: {
                        AsyncImage(url: URL(string:product.image!)) { Image in
                            Image.resizable()
                                .scaledToFill()
                                .padding()
                                .clipShape(Circle())
                                .frame(width:80,height: 80)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        
                        VStack(alignment: .leading, spacing: 5, content: {
                            Text(product.title!.split(separator: " ").first ?? "")
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            Text(product.category!)
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundStyle(Color.black.opacity(0.7))
                        })
                        Spacer()
                        Button(action: {
                            viewStore.send(.removeFromFavourites(product), animation: .bouncy)
                            
                        
                        }
                               , label: {
                            Image(systemName: "trash")
                                .foregroundStyle(Color.red)
                        })

                    })
                }
            }
        }
    }
}

#Preview {
    FavouritesView(store: Store(initialState: FavouriteFeature.State(favouriteProducts: [Product(
        id: 20,
       title: "DANVOUY Womens T Shirt Casual Cotton Short",
       price: 12.99,
       category: "women\'s clothing",
       description: "95%Cotton,5%Spandex, Features: Casual, Short Sleeve, Letter Print,V-Neck,Fashion Tees, The fabric is soft and has some stretch., Occasion: Casual/Office/Beach/School/Home/Street. Season: Spring,Summer,Autumn,Winter.",
       image: "https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg"
     )]), reducer: {
        FavouriteFeature()
    }))
}
