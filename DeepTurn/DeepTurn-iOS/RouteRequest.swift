//
//  RouteRequest.swift
//  DeepTurn
//
//  Created by GabrielMassana on 19/05/2017.
//  Copyright © 2017 Gabriel Massana. All rights reserved.
//

import UIKit

open class RouteRequest: NSObject {

    
    //MARK: - Properties

    /// The URL schema of the incoming URL. If invoked internally, this will be `nil`.
    var urlSchema: String?

    /// The query parameters parsed from the query string.
    var queryParameters: [String : String]?
    
    /// Matched defined route. If no match was found, the default route will be invoked and this will be `nil`.
    var matchedRoute: String?
    
    /// Route parameters found in the matched route. If no route parameters are found this will be an empty Dictionary, and if no matched route was found, this will be `nil`.
    var routeParameters: [String : String]?
    
    public init(urlSchema: String? = nil,
                queryParameters: [String : String]? = nil,
                matchedRoute: String? = nil,
                routeParameters: [String : String]? = nil) {
        
        super.init()
        
        self.urlSchema = urlSchema
        self.queryParameters = queryParameters
        self.matchedRoute = matchedRoute
        self.routeParameters = routeParameters
    }
}
