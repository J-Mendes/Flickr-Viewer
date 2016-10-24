//
//  NetworkManager.swift
//  Flickr Viewer
//
//  Created by Jorge Mendes on 24/10/16.
//  Copyright © 2016 Jorge Mendes. All rights reserved.
//

import Foundation

class NetworkManager: NSObject {

    static let shared: NetworkManager = NetworkManager()
    static let Domain: String = "com.jm.network"
    
    internal let baseUrl: String = "https://api.flickr.com/services/rest/?api_key=f766c98e0da1a74ed2127bbd33110072&format=json&nojsoncallback=1&method=flickr."
    internal var session: URLSession!
    
    fileprivate override init() {
        super.init()
        self.session = URLSession.shared
    }
    
}
