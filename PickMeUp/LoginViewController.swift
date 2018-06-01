//
//  LoginViewController.swift
//  PickMeUp
//
//  Created by Slava Plis on 5/29/18.
//  Copyright © 2018 Slava Plis. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

@IBDesignable
class LoginViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginIcon: UIImageView!
    @IBOutlet weak var promiseLabel: UILabel!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var userAva: UIImageView!
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        placeFacebookButton()
        fetchProfileInfo()
        
//        let loginManager = LoginManager()
//        LoginManager.
    }
    
    // MARK: - FB Graph Request
    
    private func fetchProfileInfo() {
        let connection = GraphRequestConnection()
        connection.add(FacebookPublicProfileRequest()) { (response, result) in
            switch result {
            case .success(let response):
                self.firstNameLabel.text = response.publicProfile?.name
                self.lastNameLabel.text = response.publicProfile?.name
                if let url = response.publicProfile?.picture.data.url {
                    if let data = try? Data(contentsOf: url) {
                        self.userAva.image = UIImage(data: data)
                    }
                }
            case .failed(let error):
                print(error.localizedDescription)
            }
        }
        connection.start()
    }
    
    
    // MARK: - UI customization
    
    private func placeFacebookButton() {
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: promiseLabel.bottomAnchor, constant: 12).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: userAva.leadingAnchor).isActive = true
    }
    
    // MARK: - Sys
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

