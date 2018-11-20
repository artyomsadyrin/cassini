//
//  ImageViewController.swift
//  Cassini
//
//  Created by Artyom Sadyrin on 11/20/18.
//  Copyright © 2018 Artyom Sadyrin. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    //https://upload.wikimedia.org/wikipedia/commons/5/55/Stanford_Oval_September_2013_panorama.jpg
    //https://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg
    
    static let stanford = Bundle.main.url(forResource: "oval", withExtension: ".jpg")
    
    var imageURL: URL? {
        didSet {
            imageView.image = nil
            imageView.sizeToFit()
            scrollView.contentSize = imageView.frame.size
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imageView.image == nil {
            fetchImage()
        }
    }

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.addSubview(imageView)
        }
    }
    
    var imageView = UIImageView()
    
    private func fetchImage() {
        if let url = imageURL {
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents {
                imageView.image = UIImage(data: imageData)
                imageView.sizeToFit()
                scrollView.contentSize = imageView.frame.size
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageView.image == nil {
            imageURL = ImageViewController.stanford
        }
    }
    
}
