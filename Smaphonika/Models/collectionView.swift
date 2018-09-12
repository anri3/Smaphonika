//
//  collectionView.swift
//  Smaphonika
//
//  Created by 米山杏里 on 2018/09/02.
//  Copyright © 2018年 jp.yoneyamaanri. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewSeeController: UIViewController{
    
    @IBOutlet var imageView: UIImageView!
    var selectedImg: UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = selectedImg
        // 画像のアスペクト比を維持しUIImageViewサイズに収まるように表示
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
