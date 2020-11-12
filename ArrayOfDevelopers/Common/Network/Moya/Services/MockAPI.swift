//
//  MockAPI.swift
//  ArrayOfDevelopers
//
//  Created by developer on 11/12/20.
//

import Moya
import ObjectMapper

enum MockAPI {
    case getDevelopers
}

extension MockAPI: TargetType {
    
    var baseURL: URL {
        return Credentials.Server.url
    }
    
    var path: String {
        switch self {
        case .getDevelopers:
            return "/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDevelopers:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getDevelopers:
            return [MockData(developer: Developer(name: "Jimmy", profession: "ios"))].toJSONString()!.data(using: .utf8)!
        default: return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .getDevelopers:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

