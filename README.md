# MoyaCache

[![CI Status](https://img.shields.io/travis/Pircate/MoyaCache.svg?style=flat)](https://travis-ci.org/Pircate/MoyaCache)
[![Version](https://img.shields.io/cocoapods/v/MoyaCache.svg?style=flat)](https://cocoapods.org/pods/MoyaCache)
[![License](https://img.shields.io/cocoapods/l/MoyaCache.svg?style=flat)](https://cocoapods.org/pods/MoyaCache)
[![Platform](https://img.shields.io/cocoapods/p/MoyaCache.svg?style=flat)](https://cocoapods.org/pods/MoyaCache)
[![codebeat badge](https://codebeat.co/badges/2a844bc6-5a32-4f9c-9585-f34aae5ab6c3)](https://codebeat.co/projects/github-com-pircate-moyacache-master)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS 9.0
* Swift 4.2

## Installation

MoyaCache is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MoyaCache'
```

## Usage

* 实现缓存协议

```swift
extension Storable {
    
    typealias CachedResponse = Moya.Response
    
    public var allowsStorage: (Moya.Response) -> Bool {
        return { $0.statusCode == 200 }
    }
    
    public func cachedResponse(for key: CachingKey) throws -> Moya.Response {
        return try Storage<Moya.Response>().object(forKey: key.stringValue)
    }
    
    public func storeCachedResponse(_ cachedResponse: Moya.Response, for key: CachingKey) throws {
        try Storage<Moya.Response>().setObject(cachedResponse, forKey: key.stringValue)
    }
    
    public func removeCachedResponse(for key: CachingKey) throws {
        try Storage<Moya.Response>().removeObject(forKey: key.stringValue)
    }
    
    public func removeAllCachedResponses() throws {
        try Storage<Moya.Response>().removeAll()
    }
}
```

* `target` 选择过期时间

```swift
extension StoryAPI: Cacheable {
    
    var expiry: Expiry {
        return .never
    }
}
```

* 读取缓存

```swift
let cachedResponse = try target.cachedResponse()
```

* 需要缓存的请求调用 `.cache`，普通请求不会缓存

```swift
provider.cache.request(target) { result in

}
```

## Author

Pircate, swifter.dev@gmail.com

## License

MoyaCache is available under the MIT license. See the LICENSE file for more info.
