//
//  CacheProvider.swift
//  MoyaCache
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/4/22
//  Copyright © 2019年 Pircate. All rights reserved.
//

import Moya

public struct CacheProvider<Provider: MoyaProviderType> where Provider.Target: Cacheable, Provider.Target.CachedResponse == Moya.Response {
    
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
