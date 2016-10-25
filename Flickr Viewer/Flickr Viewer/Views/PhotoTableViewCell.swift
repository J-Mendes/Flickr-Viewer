//
//  PhotoTableViewCell.swift
//  Flickr Viewer
//
//  Created by Jorge Mendes on 25/10/16.
//  Copyright © 2016 Jorge Mendes. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoTableViewCell: UITableViewCell {

    static let height: CGFloat = UIScreen.main.bounds.width
    
    @IBOutlet fileprivate weak var photoImageView: UIImageView!
    @IBOutlet fileprivate weak var viewsLabel: UILabel!
    @IBOutlet fileprivate weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.viewsLabel.text = ""
        self.dateLabel.text = ""
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.photoImageView.sd_cancelCurrentImageLoad()
        self.photoImageView.image = nil
        self.viewsLabel.text = ""
        self.dateLabel.text = ""
    }
    
    internal func configure(photo: Photo) {
        self.photoImageView.sd_setImage(with: URL(string: photo.imageUrl)!)        
        if photo.views != "" {
            self.viewsLabel.text = "Views: " + photo.views
        }
        
        self.dateLabel.text = photo.dateTaken
    }
    
}
