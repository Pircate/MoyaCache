// 
//  Expirable.swift
//  MoyaCache
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/4/22
//  Copyright © 2019年 Pircate. All rights reserved.
//

import Moya

public protocol Expirable {
    
    var expiry: Expiry { get }
    
    func update(expiry: Expiry, for key: CachingKey)
    
    func expiry(for key: CachingKey) throws -> Expiry
}

public extension Expirable where Self: TargetType {
    
    func update(expiry: Expiry, for key: CachingKey) {
        UserDefaults.standard.update(expiry: expiry.date, for: key.stringValue)
    }
    
    func expiry(for key: CachingKey) throws -> Expiry {
        guard let date = UserDefaults.standard.expiryDate(for: key.stringValue) else {
            throw MoyaCacheError.noCache
        }
        
        return .date(date)
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
