//
//  GroupResponse.swift
//  Vkontakte
//
//  Created by Валерий Эль-Хатиб on 30.10.2019.
//  Copyright © 2019 EVM Corporation. All rights reserved.
//

import Foundation

class GroupResponse: Decodable {
    let count: Int = 0
    let items: [Group]
}
