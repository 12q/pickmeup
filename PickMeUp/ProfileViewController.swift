//
//  ProfileViewController.swift
//  PickMeUp
//
//  Created by Slava Plis on 5/28/18.
//  Copyright © 2018 Slava Plis. All rights reserved.
//

import UIKit
import Foundation
import FacebookCore
import FacebookLogin

class ProfileViewController: UIViewController {
    @IBOutlet weak var goToMapButton: UIButton!
    @IBOutlet weak var userAva: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - UI

    // MARK: - Sys - Memory Warning

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
