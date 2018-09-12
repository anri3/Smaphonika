//
//  Comment.swift
//  Smaphonika
//
//  Created by 米山杏里 on 2018/08/04.
//  Copyright © 2018年 jp.yoneyamaanri. All rights reserved.
//

import UIKit

class Comment {
    var postId: String
    var user: User
    var text: String
    var createDate: Date
    
    init(postId: String, user: User, text: String, createDate: Date) {
        self.postId = postId
        self.user = user
        self.text = text
        self.createDate = createDate
    }
}
