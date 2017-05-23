//
//  URL+Sanitizer.swift
//  DeepTurn
//
//  Created by GabrielMassana on 19/05/2017.
//  Copyright © 2017 Gabriel Massana. All rights reserved.
//

import Foundation

extension URL {
    
    internal func sanitize() -> URL {
        
        guard let sanitized = URL(string: self.absoluteString.sanitize()) else {
            
            return self
        }
        
        return sanitized
    }
    
    internal func safeScheme() -> String? {
        
        guard let scheme = self.scheme,
            scheme.characters.count > 0 else {
                
                return nil
        }
        
        return scheme
    }
}
