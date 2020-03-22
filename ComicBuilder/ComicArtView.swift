//
//  ComicArtView.swift
//  ComicBuilder
//
//  Created by Hamza Azam on 21/03/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import UIKit

class ComicArtView: UIView {

    
    var backgroundImage: UIImage? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // Only override draw() if you perform custom drawing.
     override func draw(_ rect: CGRect) {
        // Drawing code
        backgroundImage?.draw(in: bounds)
    }
    

}
