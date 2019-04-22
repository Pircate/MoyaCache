// 
//  MoyaCacheError.swift
//  MoyaCache
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/4/22
//  Copyright © 2019年 Pircate. All rights reserved.
//

public enum MoyaCacheError: Error {
    case expired(CachingKey)
}
