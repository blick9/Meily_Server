//
//  HandleFunction.swift
//  Kitura-Maily
//
//  Created by Febrix on 2017. 4. 6..
//
//

import Foundation

class HandleFunction {
    
    func emailAndPwJsonToDic(data : Data) -> [String:String] {
        var jsonArray = [String:String]()
        let serializationJSON = try? JSONSerialization.jsonObject(with: data, options: [])
        
        if let jsonData = serializationJSON as? [String:String] {
            jsonArray = jsonData
        }
        return jsonArray
    }
}
