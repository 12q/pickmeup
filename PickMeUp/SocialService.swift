//
//  SocialService.swift
//  PickMeUp
//
//  Created by Slava Plis on 6/1/18.
//  Copyright © 2018 Slava Plis. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin

// MARK: - Types
enum SocialServiceType {
    case none
    case facebook
    case twitter
}

class SocialProfile {
    public var id: String?
    public var name: String?
    public var avaUrl: URL?
    
//    init(id: String, name: String, avaUrl: URL) {
//        self.id = id
//        self.name = name
//        self.avaUrl = avaUrl
//    }
}

class SocialService {
    // Singletone for the Social Service
    public static let shared = SocialService()
    private init() {}
    
    // Social type for Auth
    public var socialtAuthType: SocialServiceType = .none {
        didSet{
            refreshUserInfo()
        }
    }
    
    public func getSocialProfile() -> SocialProfile {
        return SocialProfile()
    }
    
    public func isUserLoggedIn() -> Bool {
        return true
    }
    
    private func refreshUserInfo() {
        switch socialtAuthType {
        case .none:
            print("SocialService: no AuthType.")
        case .facebook:
            fetchDataFromFacebook()
        case .twitter:
            print("SocialService: got nothing to do with Twitter yet.")
        }
    }
    
    // MARK: - FB Graph Request
    
    private func fetchDataFromFacebook() {
        let connection = GraphRequestConnection()
        connection.add(FacebookPublicProfileRequest()) { (response, result) in
            switch result {
            case .success(let response):
                guard let facebookProfile = response.publicProfile else { return }
                guard let url = response.publicProfile?.picture.data.url else { return }
                let socialProfile = SocialProfile()
                socialProfile.id = facebookProfile.id
                socialProfile.name = facebookProfile.name
                socialProfile.avaUrl = url
            case .failed(let error):
                print("SocialService fetchDataFromFacebook:\(error.localizedDescription)")
            }
        }
        connection.start()
    }
}
