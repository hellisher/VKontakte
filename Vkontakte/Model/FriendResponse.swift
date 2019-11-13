//
//  UserResponse.swift
//  Vkontakte
//
//  Created by Валерий Эль-Хатиб on 30.10.2019.
//  Copyright © 2019 EVM Corporation. All rights reserved.
//

import Foundation

class FriendResponse: Decodable {
    let count: Int = 0
    let items: [Friend]
}
