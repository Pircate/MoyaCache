//
//  TargetType+Cache.swift
//  RxNetwork
//
//  Created by Pircate on 2018/7/7.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import Moya

public extension TargetType where Self: Cacheable {
    
    func cachedResponse() throws -> Moya.Response {
        guard let date = UserDefaults.standard.expiryDate(for: stringValue), date.isExpired else {
            return try cachedResponse(for: self)
        }
        
        throw MoyaCacheError.expired(self)
    }
    
    func storeCachedResponse(_ cachedResponse: Moya.Response) throws {
        try storeCachedResponse(cachedResponse, for: self)
        
        UserDefaults.standard.update(expiry: expiry.date, for: stringValue)
    }
    
    func removeCachedResponse() throws {
        try removeCachedResponse(for: self)
    }
}

private extension UserDefaults {
    
    static let expiryKey = "com.pircate.github.expiry.key"
    
    func expiryDate(for key: String) -> Date? {
        guard let object = object(forKey: UserDefaults.expiryKey) as? [String: Date] else { return nil }
        
        return object[key]
    }
    
    func update(expiry date: Date, for key: String) {
        guard var object = object(forKey: UserDefaults.expiryKey) as? [String: Date] else {
            set([key: date], forKey: UserDefaults.expiryKey)
            return
        }
        
        object.updateValue(date, forKey: key)
        set(object, forKey: UserDefaults.expiryKey)
    }
}

private extension Date {
    
    var isExpired: Bool {
        return timeIntervalSinceNow < 0
    }
}
