// 
//  StoryAPI.swift
//  MoyaCache_Example
//
//  Created by Pircate(swifter.dev@gmail.com) on 2019/4/22
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Moya
import MoyaCache

enum StoryAPI {
    case latest
}

extension StoryAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://news-at.zhihu.com/api")!
    }
    
    var path: String {
        return "4/news/latest"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}

extension StoryAPI: Cacheable {
    
    var expiry: Expiry {
        return .never
    }
}
