//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Artyom Sadyrin on 11/20/18.
//  Copyright © 2018 Artyom Sadyrin. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {
    
    private var NASA: Dictionary<String,URL> = {
        let NASAURLStrings = [
            "Cassini": "https://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
            "Earth": "https://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg",
            "Saturn": "https://www.nasa.gov/sites/default/files/saturn_collage.jpg"
        ]
        var urls = Dictionary<String,URL>()
        for (key, value) in NASAURLStrings {
            urls[key] = URL(string: value)
        }
        return urls
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if let url = NASA[identifier] {
                if let imageVC = segue.destination as? ImageViewController {
                    imageVC.imageURL = url
                    imageVC.title = (sender as? UIButton)?.currentTitle
                }
            }
        }
    }

}
