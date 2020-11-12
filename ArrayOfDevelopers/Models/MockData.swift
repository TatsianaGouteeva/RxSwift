//
//  MockData.swift
//  ArrayOfDevelopers
//
//  Created by developer on 11/12/20.
//

import ObjectMapper

struct MockData {
    var developer = Developer()
}

//MARK: Mapping
extension MockData: Mappable {
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        developer <- map["developer"]
    }
}
