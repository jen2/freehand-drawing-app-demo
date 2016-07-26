//
//  GalleryCollectionViewController.swift
//  FreehandDrawingTool
//
//  Created by Jennifer A Sipila on 7/19/16.
//  Copyright © 2016 Jennifer A Sipila. All rights reserved.
//

import Foundation

import UIKit

private let reuseIdentifier = "Cell"
var fetchedImages = []


// MARK: UICollectionViewController

class GalleryCollectionViewController: UICollectionViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(false)
        fetchAllSavedDrawings()
        collectionView?.reloadData()
    }
    
    func fetchAllSavedDrawings ()
    {
        let datastore = DrawingDatastore.sharedDatastore()
        datastore.fetchData()
        
        fetchedImages = datastore.images
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        return fetchedImages.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellID", forIndexPath: indexPath) as! GalleryCollectionViewCell
        //        cell.backgroundColor = UIColor.redColor()
        let drawnImage = fetchedImages[indexPath.row]
        NSLog("Drawn Image: \(drawnImage)")
        cell.cellImageView.image = drawnImage as? UIImage
        
        //        let imageview : UIImageView = UIImageView(frame: CGRectMake(50, 0, self.view.frame.width-200, 50))
        //        let entry = storedImages[indexPath.row]
        //        let image = entry
        //        imageview.image = drawingImage
        //        cell.contentView.addSubview(imageview)
        
        //        cell.setup(storedImages[indexPath.row].url!)
        
        //        if (images_cache[images[indexPath.row]] != nil)
        //        {
        //            cell.Image.image = images_cache[images[indexPath.row]]
        //        }
        //        else
        //        {
        //            load_image(images[indexPath.row], imageview:cell.Image)
        //        }
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return false
     }
     
     override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
     return false
     }
     
     override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
     
     }
     */
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
}
