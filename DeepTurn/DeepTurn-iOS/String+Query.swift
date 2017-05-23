//
//  String+Query.swift
//  DeepTurn
//
//  Created by GabrielMassana on 19/05/2017.
//  Copyright © 2017 Gabriel Massana. All rights reserved.
//

extension String {
    
    internal func queryStringToMap() -> [String : String] {
        
        var queryMapped = [String : String]()
        let queries = self.components(separatedBy: "&")
        
        for query in queries {
            
            let keyValue = query.components(separatedBy: "=")

            let key = keyValue[0]
            let value = keyValue[1]
            
            queryMapped[key] = value
        }
        
        return queryMapped
    }
}
