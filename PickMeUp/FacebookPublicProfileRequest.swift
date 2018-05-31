//
//  FacebookPublicProfileRequest.swift
//  PickMeUp
//
//  Created by Slava Plis on 5/31/18.
//  Copyright © 2018 Slava Plis. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin

struct FacebookPublicProfileRequest: GraphRequestProtocol {
    var graphPath = "/me"
    var parameters: [String : Any]? = ["fields": "id, name, picture"]
    var accessToken = AccessToken.current
    var httpMethod: GraphRequestHTTPMethod = .GET
    var apiVersion: GraphAPIVersion = .defaultVersion
    
    struct Response: GraphResponseProtocol {
        var publicProfile: PublicProfile?
        public struct PublicProfile: Decodable {
            public var id: String
            public var name: String
            public var picture: PublicImageData
            
            enum CodingKeys: String, CodingKey {
                case id
                case name
                case picture
            }
            
            public struct PublicImageData: Decodable {
                public var data: PublicImage
                
                enum CodingKeys: String, CodingKey {
                    case data
                }
            }
            
            public struct PublicImage: Decodable {
                public var width: Int
                public var height: Int
                public var url: URL
                
                enum CodingKeys: String, CodingKey {
                    case width
                    case height
                    case url
                }
            }
        }
        
        init(rawResponse: Any?) {
            if let jsonData = try? JSONSerialization.data(withJSONObject: rawResponse, options: []) {
                let decoder = JSONDecoder()
                do {
                    publicProfile = try decoder.decode(PublicProfile.self, from: jsonData)
                } catch let parsingError {
                    print("Error", parsingError)
                }
            }
        }
    }
}
