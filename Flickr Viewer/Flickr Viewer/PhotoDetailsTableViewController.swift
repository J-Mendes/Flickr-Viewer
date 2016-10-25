//
//  PhotoDetailsTableViewController.swift
//  Flickr Viewer
//
//  Created by Jorge Mendes on 25/10/16.
//  Copyright © 2016 Jorge Mendes. All rights reserved.
//

import UIKit

class PhotoDetailsTableViewController: UITableViewController {

    internal var photo: Photo!
    
    fileprivate enum Rows: Int {
        case photo = 0,
        title,
        place,
        description,
        count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initLayout()
    }
    
    fileprivate func initLayout() {
        self.title = "Photo Detail"
        
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: String(describing: PhotoTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PhotoTableViewCell.self))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Rows.count.rawValue
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = nil

        switch indexPath.row {
        case Rows.photo.rawValue:
            let photoCell: PhotoTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotoTableViewCell.self), for: indexPath) as! PhotoTableViewCell
            photoCell.configure(photo: self.photo)
            cell = photoCell
        case Rows.title.rawValue:
            var textCell: TextTableViewCell? = tableView.dequeueReusableCell(withIdentifier: String(describing: TextTableViewCell.self)) as? TextTableViewCell
            if textCell == nil {
                textCell = TextTableViewCell()
            }
            textCell?.configureWith(label: "Title", andValue: self.photo.title)
            cell = textCell
        case Rows.place.rawValue:
            var textCell: TextTableViewCell? = tableView.dequeueReusableCell(withIdentifier: String(describing: TextTableViewCell.self)) as? TextTableViewCell
            if textCell == nil {
                textCell = TextTableViewCell()
            }
            textCell?.configureWith(label: "Location", andValue: self.photo.getPlace())
            cell = textCell
        case Rows.description.rawValue:
            var textCell: TextTableViewCell? = tableView.dequeueReusableCell(withIdentifier: String(describing: TextTableViewCell.self)) as? TextTableViewCell
            if textCell == nil {
                textCell = TextTableViewCell()
            }
            textCell?.configureWith(label: "Description", andValue: self.photo.descriptionText)
            cell = textCell
            
        default: break
        }

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case Rows.photo.rawValue: return PhotoTableViewCell.height
        case Rows.title.rawValue: return TextTableViewCell.heightWith(value: self.photo.title)
        case Rows.place.rawValue: return TextTableViewCell.heightWith(value: self.photo.getPlace())
        case Rows.description.rawValue: return TextTableViewCell.heightWith(value: self.photo.descriptionText)
            
        default: return 0.0
        }
    }

}
