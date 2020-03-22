//
//  ComicBuilderViewController.swift
//  ComicBuilder
//
//  Created by Hamza Azam on 21/03/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import UIKit

class ComicArtViewController: UIViewController, UIDropInteractionDelegate, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    //Generic UI View to register drop interaction
    @IBOutlet weak var dropZone: UIView! {
        didSet{
            
            //controller will handle drops so Self, So Delegate also added
            dropZone.addInteraction(UIDropInteraction(delegate: self ))
        }
    }
    
    
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var scrollViewWidth: NSLayoutConstraint!
    
    
    //To Set Background Image
    var comicArtView = ComicArtView()
       
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 0.1
            scrollView.maximumZoomScale = 5.0
            scrollView.delegate = self
            scrollView.addSubview(comicArtView)
        }
        
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        scrollViewHeight.constant = scrollView.contentSize.height
        scrollViewWidth.constant = scrollView.contentSize.width
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return comicArtView
    }
    
    var comicArtBackgroundImage: UIImage? {
        get {
            return comicArtView.backgroundImage
        }
        set {
            scrollView?.zoomScale = 1.0
            comicArtView.backgroundImage = newValue
            let size = newValue?.size ?? CGSize.zero
            comicArtView.frame = CGRect(origin: CGPoint.zero, size: size)
            scrollView?.contentSize = size
            
            scrollViewHeight?.constant = size.height
            scrollViewWidth?.constant = size.width
            
            if let dropZone = self.dropZone, size.width>0, size.height>0 {
                scrollView?.zoomScale = max(dropZone.bounds.size.width / size.width, dropZone.bounds.size.height / size.height)
            }
        }
    }
    
    
    var comicChars = [#imageLiteral(resourceName: "ironman (1)"),#imageLiteral(resourceName: "ironman (1)"),#imageLiteral(resourceName: "ironman (1)"),#imageLiteral(resourceName: "ironman (1)")]
    
    @IBOutlet weak var comicCollectionVIew: UICollectionView! {
        didSet {
            comicCollectionVIew.dataSource = self
            comicCollectionVIew.delegate = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comicChars.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComicCharCell", for: indexPath)
        if let comicCharCell = cell as? ComicCharCollectionViewCell {
            comicCharCell.charImage.image = comicChars[indexPath.item]
        }
        return cell
    }
      

    
    
    
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        
        //dragged item/background should have both the image and url associated with it
        return session.canLoadObjects(ofClass: NSURL.self) && session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        //Always copy the object
        return UIDropProposal(operation: .copy)
    }
    
    
    var imageFetcher: ImageFetcher!
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        imageFetcher = ImageFetcher() { (url,image) in
            DispatchQueue.main.async {
                self.comicArtBackgroundImage = image
            }
        }
        session.loadObjects(ofClass: NSURL.self) { nsurls in
            //fetch first url
            if let url = nsurls.first as? URL {
                self.imageFetcher.fetch(url)
            }
        }
        session.loadObjects(ofClass: UIImage.self) { images in
            //fetch first image
            if let image = images.first as? UIImage {
                self.imageFetcher.backup = image
            }
        }
    }
    
   
}
