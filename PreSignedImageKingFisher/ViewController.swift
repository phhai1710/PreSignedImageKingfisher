//
//  ViewController.swift
//  PreSignedImageKingFisher
//
//  Created by Apple on 9/5/20.
//  Copyright © 2020 Hai Pham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let preSignedURL = "https://s3.amazonaws.com/mybucket/myimage.png?AWSAccessKeyId=AKISKSD87A3C4&Expires=109838429&Signature=s98df7s8df12f2jo4lfjfs9d0fu0sd9f"
        preSignedURL.isPresigned = true
        imageView.kf.setImage(with: PresignedImageURL(string: preSignedURL))
    }


}

