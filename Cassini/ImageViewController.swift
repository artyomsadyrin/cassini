//
//  ImageViewController.swift
//  Cassini
//
//  Created by Artyom Sadyrin on 11/20/18.
//  Copyright © 2018 Artyom Sadyrin. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: Properties

    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 0.04
            scrollView.maximumZoomScale = 1.0
            scrollView.delegate = self
            scrollView.addSubview(imageView)
        }
    }
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView? .contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
    
    var imageView = UIImageView()
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //MARK: Methods
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    private func fetchImage() {
        if let url = imageURL {
            spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                DispatchQueue.main.async { //put setting of image in main queue because this is UI stuff
                    if let imageData = urlContents, url == self?.imageURL {
                        self?.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
}
