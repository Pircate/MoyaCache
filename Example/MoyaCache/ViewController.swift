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
import CleanJSON

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
            let object = try cachedResponse.mapObject(StoryListModel.self)
            
            debugPrint("******************************************")
            debugPrint("缓存读取成功:", object.topStories.first!.title)
            debugPrint("******************************************")
        } catch let MoyaCacheError.expired(expired) {
            debugPrint("******************************************")
            debugPrint("缓存已过期:", expired.date)
            debugPrint("******************************************")
        } catch {
            debugPrint("******************************************")
            debugPrint(error)
            debugPrint("******************************************")
        }
        
        provider.cache.request(target) { result in
            switch result {
            case .success(let response):
                let object = try! response.mapObject(StoryListModel.self)
                
                debugPrint("云端拉取成功:", object.topStories.first!.title)
                debugPrint("******************************************")
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}

private extension Response {
    
    func mapObject<T: Decodable>(
        _ type: T.Type,
        atKeyPath keyPath: String? = nil,
        using decoder: JSONDecoder = CleanJSONDecoder()
        ) throws -> T
    {
        return try map(type, atKeyPath: keyPath, using: decoder, failsOnEmptyData: true)
    }
}
