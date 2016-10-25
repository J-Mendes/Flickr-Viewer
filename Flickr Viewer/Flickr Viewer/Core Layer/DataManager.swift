//
//  DataManager.swift
//  Flickr Viewer
//
//  Created by Jorge Mendes on 24/10/16.
//  Copyright © 2016 Jorge Mendes. All rights reserved.
//

import UIKit

class DataManager: NSObject {

    static let shared: DataManager = DataManager()
    static let Domain: String = "com.jm.data"
 
    internal let flickrUsername: String = "eyetwist"
    
    internal func getFlickerPhotos(page: UInt, result: @escaping ([Photo], Error?) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        NetworkManager.shared.findPeopleByUsername(username: self.flickrUsername) { (response: [String : AnyObject], error: Error?) in
            if error == nil {
                if response.keys.contains("stat") && (response["stat"] as! String) == "ok" {
                    self.getPublicPhotos(userId: response["user"]?["nsid"] as! String, page: page, result: result)
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    DispatchQueue.main.async {
                        result([], NSError(domain: DataManager.Domain, code: -2, userInfo: nil))
                    }
                }
            } else {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                DispatchQueue.main.async {
                    result([], error)
                }
            }
        }
    }
    
    
    // MARK: - Private methods
    
    private func getPublicPhotos(userId: String, page: UInt, result: @escaping ([Photo], Error?) -> Void) {
        NetworkManager.shared.getPublicPhotos(userId: userId, page: page) { (response: [String : AnyObject], error: Error?) in
            if error == nil {
                if response.keys.contains("stat") && (response["stat"] as! String) == "ok" {
                    let photosDictionary: [[String : AnyObject]] = response["photos"]!["photo"] as! [[String : AnyObject]]
                    var photos: [Photo] = []
                    
                    photosDictionary.forEach {
                        photos.append(Photo(dictionary: $0))
                    }
                    
                    if photos.count > 0 {
                        self.getPhotosDetails(photos: photos, result: result)
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        DispatchQueue.main.async {
                            result([], NSError(domain: DataManager.Domain, code: -2, userInfo: ["isEnd": true]))
                        }
                    }
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    DispatchQueue.main.async {
                        result([], NSError(domain: DataManager.Domain, code: -2, userInfo: nil))
                    }
                }
            } else {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                DispatchQueue.main.async {
                    result([], error)
                }
            }
        }
    }
    
    private func getPhotosDetails(photos: [Photo], result: @escaping ([Photo], Error?) -> Void) {
        var hasError: Bool = false
        var count: Int = photos.count
        for photo: Photo in photos {
            NetworkManager.shared.getPhotoInfo(photoId: photo.id, photoSecret: photo.secret, result: { (response: [String : AnyObject], error: Error?) in
                if error == nil {
                    if response.keys.contains("stat") && (response["stat"] as! String) == "ok" {
                        if let infoDictionary: [String: AnyObject] = response["photo"] as? [String: AnyObject] {
                            photo.updateData(infoDictionary: infoDictionary)
                            
                            NetworkManager.shared.getPhotoSizes(photoId: photo.id, result: { (response: [String : AnyObject], error: Error?) in
                                count -= 1
                                if error == nil {
                                    if response.keys.contains("stat") && (response["stat"] as! String) == "ok" {
                                        if let sizesArray: [[String: AnyObject]] = response["sizes"]?["size"] as? [[String: AnyObject]] {
                                            photo.updateSizes(sizesArray: sizesArray)
                                            
                                            if count == 0 {
                                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                                DispatchQueue.main.async {
                                                    result(photos, nil)
                                                }
                                            }
                                        } else {
                                            if !hasError {
                                                hasError = true
                                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                                NetworkManager.shared.cancelAllRequests()
                                                DispatchQueue.main.async {
                                                    result([], NSError(domain: DataManager.Domain, code: -2, userInfo: nil))
                                                }
                                            }
                                        }
                                    } else {
                                        if !hasError {
                                            hasError = true
                                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                            NetworkManager.shared.cancelAllRequests()
                                            DispatchQueue.main.async {
                                                result([], NSError(domain: DataManager.Domain, code: -2, userInfo: nil))
                                            }
                                        }
                                    }
                                } else {
                                    if !hasError {
                                        hasError = true
                                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                        NetworkManager.shared.cancelAllRequests()
                                        DispatchQueue.main.async {
                                            result([], error)
                                        }
                                    }
                                }
                            })
                            
                        } else {
                            if !hasError {
                                hasError = true
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                NetworkManager.shared.cancelAllRequests()
                                DispatchQueue.main.async {
                                    result([], NSError(domain: DataManager.Domain, code: -2, userInfo: nil))
                                }
                            }
                        }
                    } else {
                        if !hasError {
                            hasError = true
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            NetworkManager.shared.cancelAllRequests()
                            DispatchQueue.main.async {
                                result([], NSError(domain: DataManager.Domain, code: -2, userInfo: nil))
                            }
                        }
                    }
                } else {
                    if !hasError {
                        hasError = true
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        NetworkManager.shared.cancelAllRequests()
                        DispatchQueue.main.async {
                            result([], error)
                        }
                    }
                }
            })
        }
    }
    
}
