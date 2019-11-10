//
//  FriendsGetModel.swift
//  Vkontakte
//
//  Created by Валерий Эль-Хатиб on 10.11.2019.
//  Copyright © 2019 EVM Corporation. All rights reserved.
//

import Foundation
import UIKit

class FriendsGetModel {
    struct  FriendList: Decodable {
        let response: ResponseHead
    }
    
    struct ResponseHead: Decodable {
        let count: Int
        let items: [FriendsItems]
    }
    
    struct FriendsItems: Decodable {
        let id: Int
        var firstName: String?
        var lastName: String?
        var isClosed: Bool?
        var nickName: String?
        var photo50: String?
        var photo100: String?
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
        case nickName = "nickname"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
    }
}
