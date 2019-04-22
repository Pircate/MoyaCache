//
//  CacheProvider.swift
//  RxMoyaCache
//
//  Created by Pircate on 2018/6/14.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import Moya

public struct CacheProvider<Provider: MoyaProviderType> where Provider.Target: Cacheable {
    
    private let provider: Provider
    
    init(_ provider: Provider) {
        self.provider = provider
    }
}

public extension CacheProvider {
    
    @discardableResult
    func request(
        _ target: Provider.Target,
        callbackQueue: DispatchQueue? = nil,
        progress: Moya.ProgressBlock? = nil,
        completion: @escaping Moya.Completion
        ) -> Cancellable
    {
        return provider.request(
        target,
        callbackQueue: callbackQueue,
        progress: progress) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
                
                if target.allowsStorage(response) {
                    try? target.storeCachedResponse(response)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
