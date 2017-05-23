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
        
        if let url = URL(string: "com.poqstudio.hollandandbarrett-uat:///products/detail//4536967/ddd213123?external_id=094497&is_animated=true&is_modal=false&source=") {
        
            Deepturn.resolve(url: url)
        }
    }

    public final func setupRoutes() {
        
        Deepturn.mapRoute(withFormat: "products/detail/:productID/:ddd", toDestination: {
            (request: RouteRequest?) in
            
            print("wooooohooooooo")
//            print(request?.urlSchema)
//            print(request?.queryParameters)
//            print(request?.matchedRoute)
//            print(request?.routeParameters)
//            print(request?.routeParameters?["productID"])
//            print(request?.routeParameters?["ddd"])
        })
        
        Deepturn.mapDefault { (request: RouteRequest?) in
            
        }
    }
}
