//
//  LogHelpers.swift
//  FetchTakeHome
//
//  Created by Khurram Nawaz on 6/11/25.
//

import Foundation

extension Data {
    
    // Help to log JSON data in the terminal 
    func prettyPrintedJSONString() -> String? {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: self, options: [])
            let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
            return String(data: prettyData, encoding: .utf8)
        } catch {
            print("Failed to pretty print JSON: \(error)")
            return nil
        }
    }
    
}



