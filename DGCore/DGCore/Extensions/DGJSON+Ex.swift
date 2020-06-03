//
//  DGJSON+Ex.swift
//  DGCore
//
//  Created by 吴迪玮 on 2020/6/3.
//  Copyright © 2020 davidandty. All rights reserved.
//

import Foundation

extension Array {
    public func toJSONString() -> String? {
        return String.toJSONString(jsonObject: self)
    }
}

extension Dictionary {
    public func toJSONString() -> String? {
        return String.toJSONString(jsonObject: self)
    }
}

extension String {
    public func toDictionary() -> [String: Any]? {
        return toJSONObject() as? [String: Any]
    }
    
    public func toArray() -> [Any]? {
        return toJSONObject() as? [Any]
    }
    
    public func toJSONObject() -> Any? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: [])
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    static func toJSONString(jsonObject: Any) -> String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            return String(data: data, encoding: .utf8)
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
}
