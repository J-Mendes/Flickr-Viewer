//
//  NetworkManager+People.swift
//  Flickr Viewer
//
//  Created by Jorge Mendes on 24/10/16.
//  Copyright © 2016 Jorge Mendes. All rights reserved.
//

import Foundation

extension NetworkManager {

    // MARK: - People Requests
    
    internal func findPeopleByUsername(username: String, result: @escaping ([String: AnyObject], Error?) -> Void) {
        self.session.dataTask(with: URLRequest(url: URL(string: "\(self.baseUrl)people.findByUsername&username=\(username)")!)) { (data: Data?, response: URLResponse?, error: Error?) in
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
    
    internal func getPublicPhotos(userId: String, page: UInt, result: @escaping ([String: AnyObject], Error?) -> Void) {
        self.session.dataTask(with: URLRequest(url: URL(string: "\(self.baseUrl)people.getPublicPhotos&user_id=\(userId)&safe_search=3&page=\(page)")!)) { (data: Data?, response: URLResponse?, error: Error?) in
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
