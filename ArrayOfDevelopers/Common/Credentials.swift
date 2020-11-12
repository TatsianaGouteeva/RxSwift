//
//  Credentials.swift
//  ArrayOfDevelopers
//
//  Created by developer on 11/12/20.
//

import Foundation

struct Credentials {
    
    struct Server {
        private struct stage {
            static let url = URL(string: "https://server-api.net")!
        }
        private struct qa {
            static let url = URL(string: "https://server-api.net")!
        }
        private struct develop {
            static let url = URL(string: "https://server-api.net")!
        }
        private struct localTest {
            static let url = URL(string: "https://server-api.net")!
        }
        static let url = Server.localTest.url
    }
}
