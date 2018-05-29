//
//  BaseViewController.swift
//  PickMeUp
//
//  Created by Slava Plis on 5/28/18.
//  Copyright © 2018 Slava Plis. All rights reserved.
//

import UIKit
import MapKit

class BaseViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwindBaseSB(_ sender: Any) {
        self.dismiss(animated: true) {}
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
