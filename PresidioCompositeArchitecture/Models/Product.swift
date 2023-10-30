//
//  Product.swift
//  PresidioCompositeArchitecture
//
//  Created by immanuel nowpert on 25/10/23.
//

import Foundation

struct Product : Codable , Equatable ,Identifiable{
    var id : Int?
    var title : String?
    var price : Double?
    var category : String?
    var description : String?
    var image : String?
    var isFavourite : Bool = false
    
    
    init (id:Int,title:String,price:Double,category:String,description:String,image:String){
        self.id  = id
        self.title = title
        self.price = price
        self.category = category
        self.description = description
        self.image = image
    }
   
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.price = try container.decodeIfPresent(Double.self, forKey: .price)
        self.category = try container.decodeIfPresent(String.self, forKey: .category)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
    }
    
}
