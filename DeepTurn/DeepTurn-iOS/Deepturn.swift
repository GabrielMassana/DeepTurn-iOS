//
//  Deepturn.swift
//  DeepTurn
//
//  Created by GabrielMassana on 18/05/2017.
//  Copyright © 2017 Gabriel Massana. All rights reserved.
//

import UIKit

/// Deepturn interface with the public funcstions
open class Deepturn : NSObject {
    
    // MARK: - MapRoutes
    
    /**
     Store a route with a completion callback.
     
     - parameter format: a route with the proper format.
     - parameter destination: the callback to be used when the route in invoked.
     
     - Note: Allowed formats: (i.e. "users/:id" or "logout"). When calling the deeplink, :id can be anything.
     */
    open class func mapRoute(withFormat format: String, toDestination destination: @escaping RouteCompletionBlock) {
        
        Router.sharedInstance.mapRoute(withFormat: format, toDestination: destination)
    }
    
    /**
     Store a default completion callback.
     
     - parameter destination: the callback to be used as default.
     */
    open class func mapDefault(toDestination destination: @escaping RouteCompletionBlock) {
        
        Router.sharedInstance.mapDefault(toDestination: destination)
    }
    
    // MARK: - ResolveURL
    
    /**
     Starts the required actions to open a deeplink url.
     
     - parameter url: the url to be invoked.
     
     - Note: http://www.ietf.org/rfc/rfc1738.txt "RFC 1738") 
        e.g.: `com.mycompany.MyApp:logout`,
            `com.mycompany.MyApp:users/16?highlight=portfolio`,
            `com.mycompany.MyApp:about/team/contact?city=san%20francisco`
     */
    open class func resolve(url: URL) {
        
        Router.sharedInstance.resolve(url: url)
    }
}
