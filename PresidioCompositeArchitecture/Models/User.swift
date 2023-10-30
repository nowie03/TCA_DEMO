//
//  User.swift
//  PresidioCompositeArchitecture
//
//  Created by immanuel nowpert on 29/10/23.
//

import Foundation


//{"address":{"geolocation":{"lat":"-37.3159","long":"81.1496"},"city":"kilcoole","street":"new road","number":7682,"zipcode":"12926-3874"},"id":1,"email":"john@gmail.com","username":"johnd","password":"m38rmF$","name":{"firstname":"john","lastname":"doe"},"phone":"1-570-236-7033","__v":0}

extension User {
    var mock : User {User(id: 1, email: "email@email.com", name: .init(firstname: "John", lastname: "Vaz"), phone: "1-146-234-8743", address:.init(city: "Kilccoole", location: .init(lat: "-37.3159", long: "81.1496")) )}
}

struct User : Identifiable,Equatable ,Codable{
    
    
    var id : Int
    var email : String
    var name : Name
    var phone : String
    var address : Address
    
    init(id:Int,email:String,name:Name,phone:String,address:Address) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.address = address
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.email = try container.decode(String.self, forKey: .email)
        self.name = try container.decode(Name.self, forKey: .name)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.address = try container.decode(Address.self, forKey: .address)
    }
    
    
    
}


struct Address : Equatable ,Codable {
    var geolocation : Location
    var city : String
    
    init(city:String,location:Location){
        self.city = city
        self.geolocation = location
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.geolocation = try container.decode(Location.self, forKey: .geolocation)
        self.city = try container.decode(String.self, forKey: .city)
    }
}

struct Location : Equatable , Codable {
    var long : String
    var lat : String
    
    init(lat:String,long:String) {
        self.lat = lat
        self.long = long
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.long = try container.decode(String.self, forKey: .long)
        self.lat = try container.decode(String.self, forKey: .lat)
    }
}



struct Name : Equatable , Codable {
    var firstname : String
    var lastname : String
    init(firstname : String,lastname:String){
        self.firstname = firstname
        self.lastname = lastname
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.firstname = try container.decode(String.self, forKey: .firstname)
        self.lastname = try container.decode(String.self, forKey: .lastname)
    }
}
