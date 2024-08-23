//
//  UserStructExtension.swift
//  Soul25
//
//  Created by Zablon Charles on 7/23/24.
//
import SwiftUI


extension UserStruct {
    func toJSONString() -> String? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        if let data = try? encoder.encode(self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    static func fromJSONString(_ jsonString: String) -> UserStruct? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        if let data = jsonString.data(using: .utf8) {
            return try? decoder.decode(UserStruct.self, from: data)
        }
        return nil
    }
}
