//
//  MoyaProviderType+Rx.swift
//  MoyaCache
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/4/22
//  Copyright © 2019年 Pircate. All rights reserved.
//

import Moya

public extension MoyaProvider where Target: Cacheable, Target.CachedResponse == Moya.Response {
    
    var cache: CacheProvider<MoyaProvider> {
        return CacheProvider(self)
    }
}
