// 
//  Cacheable.swift
//  MoyaCache
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/4/22
//  Copyright © 2019年 Pircate. All rights reserved.
//

public typealias Cacheable = Storable & Expirable & CachingKey

public protocol Storable {
    
    associatedtype CachedResponse
    
    var allowsStorage: (CachedResponse) -> Bool { get }
    
    func cachedResponse(for key: CachingKey) throws -> CachedResponse
    
    func storeCachedResponse(_ cachedResponse: CachedResponse, for key: CachingKey) throws
    
    func removeCachedResponse(for key: CachingKey) throws
    
    func removeAllCachedResponses() throws
}
