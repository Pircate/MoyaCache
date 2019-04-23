// 
//  Cacheable.swift
//  MoyaCache
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/4/22
//  Copyright © 2019年 Pircate. All rights reserved.
//

import Moya

public typealias Cacheable = Storable & Expirable & CachingKey

public protocol Storable {
    
    var allowsStorage: (Moya.Response) -> Bool { get }
    
    func cachedResponse(for key: CachingKey) throws -> Moya.Response
    
    func storeCachedResponse(_ cachedResponse: Moya.Response, for key: CachingKey) throws
    
    func removeCachedResponse(for key: CachingKey) throws
    
    func removeAllCachedResponses() throws
}
