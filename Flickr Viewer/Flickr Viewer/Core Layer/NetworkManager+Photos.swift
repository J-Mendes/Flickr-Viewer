//
//  NetworkManager+Photos.swift
//  Flickr Viewer
//
//  Created by Jorge Mendes on 24/10/16.
//  Copyright © 2016 Jorge Mendes. All rights reserved.
//

import UIKit

extension NetworkManager {

    // MARK: - Photos Requests
    
    internal func getPhotoInfo(photoId: String, photoSecret: String, result: @escaping ([String: AnyObject], Error?) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.session.dataTask(with: URLRequest(url: URL(string: "\(self.baseUrl)photos.getInfo&photo_id=\(photoId)&secret=\(photoSecret)")!)) { (data: Data?, response: URLResponse?, error: Error?) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if error == nil {
                do {
                    let jsonResult: [String: AnyObject] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: AnyObject]
                    result(jsonResult, error)
                } catch let error {
                    print(error)
                    result([:], NSError(domain: NetworkManager.Domain, code: -1, userInfo: nil))
                }
            } else {
                result([:], error)
            }
        }.resume()
    }
    
    internal func getPhotoSizes(photoId: String, result: @escaping ([String: AnyObject], Error?) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.session.dataTask(with: URLRequest(url: URL(string: "\(self.baseUrl)photos.getSizes&photo_id=\(photoId)")!)) { (data: Data?, response: URLResponse?, error: Error?) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if error == nil {
                do {
                    let jsonResult: [String: AnyObject] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: AnyObject]
                    result(jsonResult, error)
                } catch let error {
                    print(error)
                    result([:], NSError(domain: NetworkManager.Domain, code: -1, userInfo: nil))
                }
            } else {
                result([:], error)
            }
        }.resume()
    }
    
}
