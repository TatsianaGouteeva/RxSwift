//
//  Developers.swift
//  ArrayOfDevelopers
//
//  Created by developer on 11/9/20.
//
import ObjectMapper

struct Developer {
    var name = ""
    var profession = ""
}

//MARK: Mapping
extension Developer: Mappable {
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        profession <- map["profession"]
    }
}
