//
//  MoyaProviderType+Rx.swift
//  RxMoyaCache
//
//  Created by Pircate on 2018/4/18.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import Moya

public extension MoyaProvider where Target: Cacheable {
    
    var cache: CacheProvider<MoyaProvider> {
        return CacheProvider(self)
    }
}
