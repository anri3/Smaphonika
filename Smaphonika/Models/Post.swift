//
//  Post.swift
//  Smaphonika
//
//  Created by 米山杏里 on 2018/08/04.
//  Copyright © 2018年 jp.yoneyamaanri. All rights reserved.
//

import UIKit

class Post {
    
    var objectId: String
    var user: User
    var imageUrl: String
    var text: String
    var title: String
    var weather: String
    var day: String
    var month: String
    var createDate: Date
    var isLiked: Bool?
    var comments: [Comment]?
    var likeCount: Int = 0
    
    init(objectId: String, user: User, imageUrl: String, text: String, title: String, day: String, month: String,  weather: String, createDate: Date) {
        self.objectId = objectId
        self.user = user
        self.imageUrl = imageUrl
        self.text = text
        self.title = title
        self.weather = weather
        self.day = day
        self.month = month
        self.createDate = createDate
        
    }
    

}
