//
//  TextTableViewCell.swift
//  Flickr Viewer
//
//  Created by Jorge Mendes on 25/10/16.
//  Copyright © 2016 Jorge Mendes. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    init() {
        super.init(style: .value2, reuseIdentifier: String(describing: TextTableViewCell.self))
        self.initLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func initLayout() {
        self.clipsToBounds = true
        self.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
        self.detailTextLabel?.font = UIFont.systemFont(ofSize: 14.0)
        self.detailTextLabel?.numberOfLines = 0
        self.detailTextLabel?.lineBreakMode = .byWordWrapping
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.textLabel?.text = ""
        self.detailTextLabel?.text = ""
    }
    
    internal func configureWith(label: String, andValue value: String) {
        self.textLabel?.text = label
        self.detailTextLabel?.text = value
    }
    
    class func heightWith(value: String) -> CGFloat {
        if value != "" {
            let titleHeight: CGFloat = NSString(string: value).boundingRect(with: CGSize(width: UIScreen.main.bounds.width - 130.0, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin.union(.usesFontLeading), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14.0)], context: nil).size.height
            return titleHeight + 8.0
        }
        return 0.0
    }

}
