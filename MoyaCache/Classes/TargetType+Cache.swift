//
//  TargetType+Cache.swift
//  MoyaCache
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/4/22
//  Copyright © 2019年 Pircate. All rights reserved.
//

import Moya
import Storable

public typealias CachingKey = StoringKey

public typealias Cacheable = Storable & Expirable & CachingKey

public extension TargetType where Self: Cacheable, Self.ResponseType == Moya.Response {
    
    func cachedResponse() throws -> Moya.Response {
        let expiry = try self.expiry(for: self)
        
        guard expiry.isExpired else {
            return try cachedResponse(for: self)
        }
        
        throw Expiry.Error.expired(expiry.date)
    }
    
    func storeCachedResponse(_ cachedResponse: Moya.Response) throws {
        try storeCachedResponse(cachedResponse, for: self)
        
        update(expiry: expiry, for: self)
    }
    
    func removeCachedResponse() throws {
        try removeCachedResponse(for: self)
        
        removeExpiry(for: self)
    }
}
