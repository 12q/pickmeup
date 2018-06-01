//
//  ProfileViewController.swift
//  PickMeUp
//
//  Created by Slava Plis on 5/28/18.
//  Copyright © 2018 Slava Plis. All rights reserved.
//

import UIKit
import Foundation

@IBDesignable
class ProfileViewController: UIViewController {
    @IBOutlet weak var goToMapButton: UIButton!
    
    
    @IBOutlet weak var userAva: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var selectionImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Button Events
    
    @IBAction func driverTap(_ sender: Any) {
        selectionImageView.image = #imageLiteral(resourceName: "DriverIcon")
    }
    
    @IBAction func passengerTap(_ sender: Any) {
        selectionImageView.image = #imageLiteral(resourceName: "PassengerIcon")
    }
    
    
    // MARK: - UI

    // MARK: - Sys - Memory Warning

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
