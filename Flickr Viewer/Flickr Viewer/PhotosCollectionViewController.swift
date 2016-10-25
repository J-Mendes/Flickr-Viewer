//
//  PhotosCollectionViewController.swift
//  Flickr Viewer
//
//  Created by Jorge Mendes on 24/10/16.
//  Copyright © 2016 Jorge Mendes. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    fileprivate var photos: [Photo] = []
    fileprivate var currentPage: UInt = 0
    fileprivate var isLoading: Bool = false
    fileprivate var hasReachedLastPage: Bool = false
    fileprivate var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initLayout()
        ProgressHUD.showProgressHUD(view: UIApplication.shared.keyWindow!, text: "Loading photos...")
        self.getPhotos()
    }
    
    fileprivate func initLayout() {
        self.title = "eyetwist's album"
        
        self.collectionView!.register(UINib(nibName: String(describing: PhotoCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: PhotoCollectionViewCell.self))
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        self.collectionView?.addSubview(self.refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoCollectionViewCell.self), for: indexPath) as! PhotoCollectionViewCell
    
        cell.configure(photo: self.photos[indexPath.row])
    
        if indexPath.row == self.photos.count - 20 && !self.isLoading && !self.hasReachedLastPage {
            self.getPhotos()
        }
        
        return cell
    }
    
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: PhotoCollectionViewCell.width, height: PhotoCollectionViewCell.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellsInLine: Int = Int(floor(UIScreen.main.bounds.width / PhotoCollectionViewCell.width))
        let sideSpace: CGFloat = (UIScreen.main.bounds.width - (PhotoCollectionViewCell.width * CGFloat(cellsInLine))) / CGFloat(cellsInLine + 1)
        return UIEdgeInsets(top: 20.0, left: sideSpace, bottom: 20.0, right: sideSpace)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let cellsInLine: Int = Int(floor(UIScreen.main.bounds.width / PhotoCollectionViewCell.width))
        let sideSpace: CGFloat = (UIScreen.main.bounds.width - (PhotoCollectionViewCell.width * CGFloat(cellsInLine))) / CGFloat(cellsInLine + 1)
        return sideSpace
    }
    

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: show detail view
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    
    // MARK: Data request
    
    fileprivate func getPhotos() {
        self.currentPage += 1
        self.isLoading = true
        DataManager.shared.getFlickerPhotos(page: self.currentPage) { (photos: [Photo], error: Error?) in
            self.isLoading = false
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            
            if error == nil {
                if self.currentPage == 1 {
                    self.photos = []
                }
                self.photos += photos
                self.collectionView?.reloadData()
                
                if photos.count == 0 {
                    self.hasReachedLastPage = true
                }
                ProgressHUD.dismissAllHuds(view: UIApplication.shared.keyWindow!)
            } else {
                self.hasReachedLastPage = true
                if !(error as! NSError).userInfo.keys.contains("isEnd") {
                    ProgressHUD.showErrorHUD(view: UIApplication.shared.keyWindow!, text: "An error has occurred while fetching ")
                }
            }
        }
    }
    
    internal func refreshData() {
        self.currentPage = 0
        self.hasReachedLastPage = false
        self.getPhotos()
    }

}
