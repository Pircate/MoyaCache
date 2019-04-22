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
        let target = StoryAPI.latest
        
        do {
            let cachedResponse = try target.cachedResponse()
            debugPrint(try cachedResponse.map(StoryItemModel.self).title)
        } catch {
            debugPrint(error)
        }
        
        provider.cache.request(target) { result in
            switch result {
            case .success(let response):
                debugPrint(try! response.map(StoryItemModel.self).title)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

