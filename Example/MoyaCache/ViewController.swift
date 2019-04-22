//
//  ViewController.swift
//  MoyaCache
//
//  Created by Pircate on 04/22/2019.
//  Copyright (c) 2019 Pircate. All rights reserved.
//

import UIKit
import Moya
import MoyaCache

extension Storable where Self: TargetType {
    
    var expiry: Expiry {
        return .never
    }
    
    public var allowsStorage: (Response) -> Bool {
        return { _ in
            return true
        }
    }
    
    public func cachedResponse(for key: CachingKey) throws -> Response {
        return Response(statusCode: 0, data: "".data(using: .utf8)!)
    }
    
    public func storeCachedResponse(_ cachedResponse: Response, for key: CachingKey) throws {
//        try Storage<Moya.Response>().setObject(cachedResponse, forKey: key.stringValue)
    }
    
    public func removeCachedResponse(for key: CachingKey) throws {
//        try Storage<Moya.Response>().removeObject(forKey: key.stringValue)
    }
    
    public func removeAllCachedResponses() throws {
//        try Storage<Moya.Response>().removeAll()
    }
}

enum StoryAPI: TargetType, Cacheable {
    
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
    
    case latest
}

struct StoryListModel: Codable {
    let topStories: [StoryItemModel]
    
    enum CodingKeys: String, CodingKey {
        case topStories = "top_stories"
    }
}

struct StoryItemModel: Codable {
    let id: String
    let title: String
    let image: String
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let provider = MoyaProvider<StoryAPI>()
        provider.cache.request(.latest) { result in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

