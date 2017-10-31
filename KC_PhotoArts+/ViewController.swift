//
//  ViewController.swift
//  KC_PhotoArts+
//
//  Created by Kartheek chintalapati on 24/10/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //MARK: Variables
    var photoArts = [ArtData]()
    var inactiveQueue:DispatchQueue!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        //create custom size for each of the image items in the collection view. each item is 1/2 of the screen width, minus 5 points
        let itemSize = UIScreen.main.bounds.width/2 - 3
        
        //create a custom layout to hold yhr customer sized items
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        //set spacing between items in the collection view
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        
        //After connecting collection view to the ciewcontroller class. we can now add the new layout to the collection view.
        collectionView.collectionViewLayout = layout
        */
        
        if let queue = inactiveQueue
        {
            queue.activate()
        }
        
        let queueX = DispatchQueue(label: "edu.cs.niu.queueX")
        queueX.sync {
            fetchArtData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Collection view delegate functions
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL", for: indexPath) as! CVCell
        
        let singleArt:ArtData = photoArts[indexPath.row]
        
        cell.artImageView.image = loadImage(imageUrl: singleArt.smallImage)
        cell.artNameLabel.text = singleArt.itemName
        
        return cell
    }
    //MARK: - User defined function for JSON data
    func fetchArtData()
    {
        
        let api_url = URL(string: "http://faculty.cs.niu.edu/%7Ekrush/ios/photoarts-json") //create URL variable
        let urlRequest = URLRequest(url: api_url!) //create URL request
        
        //submit a request to JSON Data
        let task = URLSession.shared.dataTask(with: urlRequest)
        {
            (data,response,error) in
            //if there is an error, print it and do not continue
            if error != nil {
                print(error!)
                return
            }
            
            //if there is no error, fetch json content
            if let content = data {
                do {
                    let artObject = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    
                    //fetch only client data
                    if let artItem = artObject["photoarts"] as? [[String:AnyObject]] {
                        for item in artItem
                        {
                            if let itemName = item["item_name"] as? String, let itemNumber = item["item_number"] as? String, let largeImage = item["large_image"] as? String, let smallImage = item["small_image"] as? String
                            {
                                //print(itemName)
                               self.photoArts.append(ArtData(itemName: itemName, itemNumber: itemNumber, largeImage: largeImage, smallImage: smallImage))
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
                catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    //Function to load image from URL in a imageView. It takes the url as input and returns UIImage
    func loadImage(imageUrl:String) -> UIImage
    {
        let url = URL(string: imageUrl)
        let data = try? Data(contentsOf: url!)
        
        return UIImage(data: data!)!
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "itemNav")
        {
            let itemVC = segue.destination as! ItemViewController
            
            if let indexPath = self.collectionView.indexPathsForSelectedItems?.first
            {
                //let indexPath = indexPaths[0]
                let singleItem:ArtData = photoArts[indexPath.row]
            
                itemVC.sentLargeImage = singleItem.largeImage
                print(singleItem.itemName)
            }
        }
    }
}



