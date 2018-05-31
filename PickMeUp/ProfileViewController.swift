//
//  ProfileViewController.swift
//  PickMeUp
//
//  Created by Slava Plis on 5/28/18.
//  Copyright © 2018 Slava Plis. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import Foundation

class ProfileViewController: UIViewController {
    @IBOutlet weak var goToMapButton: UIButton!
    @IBOutlet weak var userAva: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    struct MyProfileRequest: GraphRequestProtocol {
        var graphPath = "/me"
        var parameters: [String : Any]? = ["fields": "id, name, picture"]
        var accessToken = AccessToken.current
        var httpMethod: GraphRequestHTTPMethod = .GET
        var apiVersion: GraphAPIVersion = .defaultVersion
        
        struct Response: GraphResponseProtocol {
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
            
            var pub: PublicProfile?
            
            init(rawResponse: Any?) {
                if let jsonData = try? JSONSerialization.data(withJSONObject: rawResponse, options: []) {
                    let decoder = JSONDecoder()
                    do {
                        let model = try decoder.decode(PublicProfile.self, from: jsonData)
                        pub = model
                        print("model: \(model)")
                    } catch let parsingError {
                        print("Error", parsingError)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFbButton()
        launchFacebookConnection()
    }
    
    // MARK: - FB connect
    
    private func launchFacebookConnection() {
        let connection = GraphRequestConnection()
        connection.add(MyProfileRequest()) { (response, result) in
            switch result {
            case .success(let response):
                print("response.pub:")
                self.userName.text = response.pub?.name
                if let url = response.pub?.picture.data.url {
                    if let data = try? Data(contentsOf: url) {
                        self.userAva.image = UIImage(data: data)
                    }
                }

            case .failed(let error):
                print("Custom Graph Request Failed: \(error)")
            }
        }
        connection.start()
    }
    
    // MARK: - UI
    
    private func setFbButton() {
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        view.addSubview(loginButton)
    }

    // MARK: - Sys - Memory Warning

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
