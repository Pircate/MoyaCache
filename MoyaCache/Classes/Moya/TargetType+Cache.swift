//
//  TargetType+Cache.swift
//  MoyaCache
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/4/22
//  Copyright © 2019年 Pircate. All rights reserved.
//

import Moya

public extension TargetType where Self: Cacheable {
    
    func cachedResponse() throws -> CachedResponse {
        let expiry = try self.expiry(for: self)
        
        guard expiry.isExpired else {
            return try cachedResponse(for: self)
        }
        
        throw Expiry.Error.expired(Expiry.Expired(date: expiry.date))
    }
    
    func storeCachedResponse(_ cachedResponse: CachedResponse) throws {
        try storeCachedResponse(cachedResponse, for: self)
        
        update(expiry: expiry, for: self)
    }
    
    func removeCachedResponse() throws {
        try removeCachedResponse(for: self)
        
        removeExpiry(for: self)
    }
}
