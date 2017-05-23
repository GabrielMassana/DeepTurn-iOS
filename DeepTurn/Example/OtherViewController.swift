//
//  OtherViewController.swift
//  DeepTurn
//
//  Created by GabrielMassana on 19/05/2017.
//  Copyright © 2017 Gabriel Massana. All rights reserved.
//

import UIKit

class OtherViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}
