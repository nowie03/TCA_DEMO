//
//  ProductView.swift
//  PresidioCompositeArchitecture
//
//  Created by immanuel nowpert on 25/10/23.
//

import SwiftUI
import ComposableArchitecture

struct ProductView: View {
    let store : StoreOf<ProductFeature>
    
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            ZStack(alignment:.top){
                if let product = viewStore.product {
                    AsyncImage(url: URL(string:product.image ?? "")!){
                        image in
                        image
                            .resizable()
                            .frame(height:350)
                            .aspectRatio(contentMode: .fit)
                        
                    }placeholder: {
                        ProgressView()
                    }
                    
                    VStack (alignment:.center,spacing:15){
                        Text(product.title?.components(separatedBy: " ").first ?? "")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        Text(product.category ?? "")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text(product.description ?? "")
                            .font(.caption)
                            .lineLimit(3)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                            .frame(height:170)
                        
                        
                        HStack{
                            Text("$ \(product.price ?? 1)")
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Text("Buy Now")
                                    .foregroundStyle(Color.white)
                                    .padding()
                                    .background {
                                        Capsule()
                                    }
                            }

                        }
                        .padding(20)
                        
                        Spacer()
                           
                        
                        
                       
                         
                    }
                    
                    .padding()
                    .foregroundColor(.black)
                    .background(UnevenRoundedRectangle(topLeadingRadius: 20,topTrailingRadius: 20)
                        .fill(.ultraThinMaterial)
                    )
                    .offset(y:300)
                }
            }
            .padding(10)
            .onAppear{
                print("product detail view appeared")
            }
            
            .onDisappear(perform: {
                print("product detail view disappeared")
            })
            .navigationTitle(viewStore.product?.title?.components(separatedBy: "-").first ?? "")
            .navigationBarTitleDisplayMode(.inline)
            
        }
       
    }
}

#Preview {
    ProductView(store: .init(initialState: ProductFeature.State(product: Product(
                id: 20,
               title: "DANVOUY Womens T Shirt Casual Cotton Short",
               price: 12.99,
               category: "women\'s clothing",
               description: "95%Cotton,5%Spandex, Features: Casual, Short Sleeve, Letter Print,V-Neck,Fashion Tees, The fabric is soft and has some stretch., Occasion: Casual/Office/Beach/School/Home/Street. Season: Spring,Summer,Autumn,Winter.",
               image: "https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg"
             )), reducer: {
        ProductFeature()
    }))
}
