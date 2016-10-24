//
//  Photo.swift
//  Flickr Viewer
//
//  Created by Jorge Mendes on 24/10/16.
//  Copyright © 2016 Jorge Mendes. All rights reserved.
//

import Foundation

class Photo: NSObject {

    internal var id: String!
    internal var secret: String!
    internal var title: String!
    internal var descriptionText: String!
    internal var dateTaken: String!
    internal var views: String!
    internal var latitude: Double!
    internal var longitude: Double!
    internal var place: String!
    internal var local: String!
    internal var county: String!
    internal var region: String!
    internal var country: String!
    internal var squareUrl: String!
    internal var imageUrl: String!
    
    override init() {
        super.init()
        
        self.id = ""
        self.secret = ""
        self.title = ""
        self.descriptionText = ""
        self.dateTaken = ""
        self.views = ""
        self.latitude = 0.0
        self.longitude = 0.0
        self.place = ""
        self.local = ""
        self.county = ""
        self.region = ""
        self.country = ""
        self.squareUrl = ""
        self.imageUrl = ""
    }
    
    convenience init(dictionary: [String: AnyObject]) {
        self.init()
        
        if let id: String = dictionary["id"] as? String {
            self.id = id
        }
        
        if let secret: String = dictionary["secret"] as? String {
            self.secret = secret
        }
        
        if let title: String = dictionary["title"] as? String {
            self.title = title
        }
    }
    
    internal func updateData(infoDictionary: [String: AnyObject]) {
        if let description: String = infoDictionary["description"]?["_content"] as? String {
            self.descriptionText = description
        }
        
        if let dateTaken: String = infoDictionary["dates"]?["taken"] as? String {
            self.dateTaken = dateTaken
        }
        
        if let views: String = infoDictionary["views"] as? String {
            self.views = views
        }
        
        if let location: [String: AnyObject] = infoDictionary["location"] as? [String: AnyObject] {
            if let latitude: Double = Double((location["latitude"] as? String)!) {
                self.latitude = latitude
            }
            
            if let longitude: Double = Double((location["longitude"] as? String)!) {
                self.longitude = longitude
            }
            
            if let place: String = location["neighbourhood"]?["_content"] as? String {
                self.place = place
            }
            
            if let local: String = location["locality"]?["_content"] as? String {
                self.local = local
            }
            
            if let county: String = location["county"]?["_content"] as? String {
                self.county = county
            }
            
            if let region: String = location["region"]?["_content"] as? String {
                self.region = region
            }
            
            if let country: String = location["country"]?["_content"] as? String {
                self.country = country
            }
        }
    }
    
    internal func updateSizes(sizesArray: [[String: AnyObject]]) {
        sizesArray.forEach {
            if let squareLabel: String = $0["label"] as? String, squareLabel == "Large Square" {
                self.squareUrl = $0["source"] as! String
            }
            
            if let imageLabel: String = $0["label"] as? String, imageLabel == "Large 2048" {
                self.imageUrl = $0["source"] as! String
            }
        }
        
        
    }
    
}
