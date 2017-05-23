//
//  ViewController.swift
//  DeepTurn
//
//  Created by GabrielMassana on 18/05/2017.
//  Copyright © 2017 Gabriel Massana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()

        setupRoutes()
    }

    /// This method should be moved into a Deeplink Manager 
    public final func setupRoutes() {
        
        Deepturn.mapRoute(withFormat: "other/viewController/:red/:green/:blue", toDestination: {
            (request: RouteRequest?) in
            
            guard let routeParameters = request?.routeParameters,
                let queryParameters = request?.queryParameters,
                let red = routeParameters["red"],
                let green = routeParameters["green"],
                let blue = routeParameters["blue"],
                let floatRed = Float(red),
                let floatGreen = Float(green),
                let floatBlue = Float(blue) else {
                
                    return
            }
            
            let color = UIColor(red: CGFloat(floatRed) / 255.0,
                                green: CGFloat(floatGreen) / 255.0,
                                blue: CGFloat(floatBlue) / 255.0,
                                alpha: 1.0)

            
            let isAnimated = queryParameters["is_animated"]
            var animated = true
            
            if isAnimated == "false" {
                
                animated = false
            }
            
            let otherViewController = OtherViewController(nibName: nil,
                                                          bundle: nil)
            
            otherViewController.view.backgroundColor = color
            
            self.present(otherViewController,
                         animated: animated,
                         completion: nil)
        })
        
        Deepturn.mapDefault { (request: RouteRequest?) in
            
        }
    }
    
    /// Button example.
    /// This action can come from Safary or from anywhere inside the app.
    @IBAction func openVCWithDeepTurn(_ sender: Any) {
        
        let red = String(arc4random_uniform(256))
        let green = String(arc4random_uniform(255))
        let blue = String(arc4random_uniform(255))
        
        var animated = true
        
        if arc4random_uniform(2) == 0 {
            
            animated = false
        }
        
        if let url = URL(string: "other/viewController/\(red)/\(green)/\(blue)/?is_animated=\(animated)") {
            
            Deepturn.resolve(url: url)
        }
    }
}
