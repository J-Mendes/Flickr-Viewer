//
//  PhotoCollectionViewCell.swift
//  Flickr Viewer
//
//  Created by Jorge Mendes on 24/10/16.
//  Copyright © 2016 Jorge Mendes. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {

    static let width: CGFloat = 150.0
    static let height: CGFloat = 150.0
    
    @IBOutlet fileprivate weak var photoImageView: UIImageView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleLabel.text = ""
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.photoImageView.sd_cancelCurrentImageLoad()
        self.photoImageView.image = nil
        self.photoImageView.backgroundColor = UIColor.lightGray
        self.titleLabel.text = ""
    }

    internal func configure(photo: Photo) {
        self.photoImageView.sd_setImage(with: URL(string: photo.squareUrl)!) { (image: UIImage?, error: Error?, imageCacheType: SDImageCacheType, url: URL?) in
            if image != nil {
                self.photoImageView.backgroundColor = UIColor.clear
            }
        }
        self.titleLabel.text = photo.title
    }
    
}
