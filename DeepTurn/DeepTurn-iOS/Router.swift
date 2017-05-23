//
//  Router.swift
//  DeepTurn
//
//  Created by GabrielMassana on 19/05/2017.
//  Copyright © 2017 Gabriel Massana. All rights reserved.
//

import UIKit

/// Completion block to be used when a route is found.
typealias RouteCompletionBlock = (RouteRequest?) -> Void

class Router: NSObject {

    // The routing callback to invoke when no route is matched upon invocation.
    private var defaultRouteCallback: RouteCompletionBlock = { (request: RouteRequest?) in }

    // Routes that the user has defined.
    private var definedRoutes: [String : RouteCompletionBlock] = [String : RouteCompletionBlock]()
    
    //MARK: - Singleton
    
    /**
     Singleton.
     
     - returns: Router instance.
     */
    static let sharedInstance = Router()
    
    //MARK: - Init
    
    private override init() {
        
        super.init()
    }
    
    // MARK: - MapRoutes

    func mapRoute(withFormat format: String, toDestination destination: @escaping RouteCompletionBlock) {
        
        definedRoutes[format] = destination        
    }
    
    func mapDefault(toDestination destination: @escaping RouteCompletionBlock) {
        
        defaultRouteCallback = destination
    }
    
    //MARK: - ResolveURL

    func resolve(url: URL) {
        
        let sanitizedURL = url.sanitize()
        let scheme = url.safeScheme()
        
        var host = ""
        let path = sanitizedURL.path
        
        if let urlHost = sanitizedURL.host {
            
            host = urlHost
        }
        
        let rawRoute = host + path
        
        let route = rawRoute.sanitizeMappedPath()
        var queryParameters = [String : String]()
        
        if let parameters = sanitizedURL.query?.queryStringToMap() {
            
            queryParameters = parameters
        }
        
        invoke(route: route,
               withSchema: scheme,
               queryParameters: queryParameters)
    }
    
    //MARK: - InvokeRoute

    /**
     Invoke a URL after being sanitized. If the URL route is stored in as a defined route, the related callback will be executed.
     If no route is found, the default callback will be executed.
     
     - parameter route: url route to be used to search a match.
     - parameter schema: url schema.
     - parameter queryParameters: url query parameters as a dictionary.
     */
    private func invoke(route: String, withSchema schema: String?, queryParameters: [String : String]) {
        
        var request: RouteRequest?
        var callback: RouteCompletionBlock?
        
        let routeSegments = route.components(separatedBy: "/")
    
        for definedRoute in definedRoutes.keys {
            
            let definedRouteSegments = definedRoute.components(separatedBy: "/")

            if (routeSegments.count != definedRouteSegments.count) {
                
                continue
            }

            let routeParameters = match(incomingRouteSegments: routeSegments,
                                        withDefinedRouteSegments: definedRouteSegments)
            
            if routeParameters == nil {
                
                continue
            }
            
            request = RouteRequest(urlSchema: schema,
                                   queryParameters: queryParameters,
                                   matchedRoute: definedRoute,
                                   routeParameters: routeParameters)

            if let definedCallback = definedRoutes[definedRoute] {
               
                callback = definedCallback
                break
            }
        }
        
        if request == nil &&
            callback == nil {
            
            request = RouteRequest(urlSchema: schema,
                                   queryParameters: queryParameters,
                                   matchedRoute: nil,
                                   routeParameters: nil)
            
            callback = defaultRouteCallback
        }
        
        if let callback = callback {
            
            callback(request)
        }
    }
    
    //MARK: - MatchRoute
    
    /**
     Main function to search a match between the stored routes and the one provided in the URL.
    
     - parameter incomingRouteSegments: segments provided in the url.
     - parameter definedRouteSegments: segments stored as in a defined route.

     - returns: all the route parameters as a Dictionary of Strings.
     */

    private func match(incomingRouteSegments: [String], withDefinedRouteSegments definedRouteSegments: [String]) -> [String : String]? {
        
        var routeParameters = [String : String]()
        
        for index in 0..<definedRouteSegments.count {
            
            var definedRouteSegment = definedRouteSegments[index]
            let incomingRouteSegment = incomingRouteSegments[index]
            
            let colonIndex = definedRouteSegment.index(definedRouteSegment.startIndex, offsetBy: 0)
            
            if definedRouteSegment[colonIndex] == ":" {
                
                definedRouteSegment.remove(at: definedRouteSegment.startIndex)

                routeParameters[definedRouteSegment] = incomingRouteSegment
                
                continue
            }
            else if definedRouteSegment == incomingRouteSegment {
                
                continue
            }
            else {
                
                return nil
            }
        }
        
        return routeParameters
    }
}
