//
//  NetworkUtils.swift
//  ArrayOfDevelopers
//
//  Created by developer on 11/12/20.
//

import Moya
import ObjectMapper

protocol ResponseHandler {
    init(response: Response)
}

struct NetworkError: AppError, ResponseHandler {
    var message: String
    
    init(message: String) {
        self.message = message
    }
    
    init(response: Response) {
        self.init(message: "Failed to map data to JSON. JSON: \((try? response.mapString()) ?? "No JSON")")
    }
}

extension Response {
    
    var json: [String: Any]? {
        return (try? mapJSON()) as? [String: Any]
    }
}

extension Array where Element: Mappable {
    
    init?(response: Response) {
        guard let json = ((try? response.mapJSON() as? [[String: Any]]) as [[String : Any]]??), let unwrappedData = json else { return nil }
        self.init(JSONArray: unwrappedData)
    }
}

extension Mappable {
    
    init?(response: Response) {
        guard let json = response.json else { return nil }
        self.init(JSON: json)
    }
}

