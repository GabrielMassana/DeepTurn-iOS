//
//  String+Sanitizer.swift
//  DeepTurn
//
//  Created by GabrielMassana on 19/05/2017.
//  Copyright © 2017 Gabriel Massana. All rights reserved.
//

import Foundation

extension String {

    internal func sanitize() -> String {
       
        if let url = URL(string: self) {
            
            var scheme = ""
            var host = ""
            let path = url.path
            var query = ""
            
            if let urlScheme = url.scheme {
                
                scheme = urlScheme + "://"
            }
            
            if let urlHost = url.host {
                
                host = urlHost
            }
            
            if let urlQuery = url.query {
                
                query = "?" + urlQuery
            }
            
            let sanitized = scheme + host + path + query
            
            return sanitized
        }

        return self
    }
    
    internal func sanitizeMappedPath() -> String {
        
        
        let string = NSMutableString(string: self)
        
        let multipleColons = try? NSRegularExpression(pattern: "::+",
                                                 options: .caseInsensitive)
        
        let multipleSlashes = try? NSRegularExpression(pattern: "//+",
                                                 options: .caseInsensitive)
        
        let leadingTrailingSlashes = try? NSRegularExpression(pattern: "(^/)|(/$)",
                                                         options: .caseInsensitive)
        
        multipleColons?.replaceMatches(in: string,
                                       options: .reportProgress,
                                       range: NSMakeRange(0, string.length),
                                       withTemplate: ":")
        
        multipleSlashes?.replaceMatches(in: string,
                                        options: .reportProgress,
                                        range: NSMakeRange(0, string.length),
                                        withTemplate: "/")
        
        leadingTrailingSlashes?.replaceMatches(in: string,
                                               options: .reportProgress,
                                               range: NSMakeRange(0, string.length),
                                               withTemplate: "")
        
        return string as String
    }
}
