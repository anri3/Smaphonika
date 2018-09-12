//
//  User.swift
//  Smaphonika
//
//  Created by 米山杏里 on 2018/08/04.
//  Copyright © 2018年 jp.yoneyamaanri. All rights reserved.
//

import UIKit

class User {

    var objectId: String
    var userName: String
    var displayName: String?
    var introduction: String?
    
    init(objectId: String, userName: String) {
        self.objectId = objectId
        self.userName = userName
    }
    
}
