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
        struct PublicProfile: Decodable {
            var id: String
            var name: String
            var picture: PublicImageData
            
            enum CodingKeys: String, CodingKey {
                case id
                case name
                case picture
            }
            
            struct PublicImageData: Decodable {
                var data: PublicImage
                
                enum CodingKeys: String, CodingKey {
                    case data
                }
            }
            
            struct PublicImage: Decodable {
                var width: Int
                var height: Int
                var url: URL
                
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
