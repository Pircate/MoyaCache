//
//  TargetType+Cache.swift
//  MoyaCache
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/4/22
//  Copyright © 2019年 Pircate. All rights reserved.
//

import Moya

public extension TargetType where Self: Cacheable {
    
    func cachedResponse() throws -> Moya.Response {
        let expiry = try self.expiry(for: self)
        
        guard expiry.isExpired else {
            return try cachedResponse(for: self)
        }
        
        throw MoyaCacheError.expired(Expired(date: expiry.date))
    }
    
    func storeCachedResponse(_ cachedResponse: Moya.Response) throws {
        try storeCachedResponse(cachedResponse, for: self)
        
        update(expiry: expiry, for: self)
    }
    
    func removeCachedResponse() throws {
        try removeCachedResponse(for: self)
    }
}
