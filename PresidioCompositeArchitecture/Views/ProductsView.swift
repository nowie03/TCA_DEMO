//
//  ProductsView.swift
//  PresidioCompositeArchitecture
//
//  Created by immanuel nowpert on 25/10/23.
//

import SwiftUI
import ComposableArchitecture

struct ProductsView: View {
    let store : StoreOf<ProductsFeature>
    var body: some View {
            WithViewStore(store, observe: {$0}) { viewStore in
                VStack {
                    if let products =  viewStore.products {
                        ScrollView(.vertical){
                            ForEach(products,id:\.id){
                                product in
                                NavigationLink(state:ProductFeature.State(product:product)){
                                    VStack(spacing:15){
                                        if let imageUrlString = product.image {
                                            AsyncImage(url: URL(string:imageUrlString)!){
                                                image in
                                                image
                                                    .resizable()
                                                    .frame(height:350)
                                                    .scaledToFit()
                                                
                                            }placeholder: {
                                                ProgressView()
                                            }
                                            VStack(alignment:.leading,spacing:10){
                                                Text(product.title?.components(separatedBy: " ").first ??  "" )
                                                    .font(.title3)
                                                    .fontWeight(.semibold)
                                                Text(product.description ?? "")
                                                    .multilineTextAlignment(.leading)
                                                    .lineLimit(2)
                                                    .font(.caption)
                                                HStack{
                                                    
                                                    Text("$ \(product.price ?? 1)")
                                                    Spacer()
                                                    Button {
                                                        viewStore.send(.buyNowButtonTapped(product))
                                                    } label: {
                                                        Text("Buy Now")
                                                            .foregroundStyle(Color.white)
                                                            .padding()
                                                            .background(RoundedRectangle(cornerRadius: 8).fill(Color.green))
                                                        
                                                    }
                                                    
                                                    
                                                }
                                            }
                                            Spacer()
                                            
                                        }
                                    }
                                }
                                .foregroundStyle(Color.black)
                                .scrollTargetLayout()
                                .overlay(alignment: .topTrailing, content: {
                                    if product.isFavourite {
                                        Button {
                                            
                                            
                                        } label: {
                                            Image(systemName: "heart.fill")
                                                .foregroundStyle(Color.red)
                                                .padding()
                                        }
                                    }
                                    else {
                                        Button {
                                            viewStore.send(.addtoFavourites(product))
                                        } label: {
                                            Image(systemName: "heart")
                                                .foregroundStyle(Color.red)
                                                .padding()
                                        }
                                    }
                                    
                                })
                                
                                .frame(minWidth: 0)
                                .padding(20)
                            }
                        }
                        .scrollTargetBehavior(.viewAligned)
                    }
                }
               .onAppear{
//                   print("products view appeard")
                   print("PRODUCT VIEW APPEARED")
        viewStore.send(.viewOnReady)
               }
               .onDisappear{
//                   print("products view disappeard")
//                   viewStore.send(.viewOnDispose)
               }
                
            }
        
    }
        
}

#Preview {
    ProductsView(store: .init(initialState: ProductsFeature.State(category: "jewelery"), reducer: {
        ProductsFeature()
            ._printChanges()
    }))
}
