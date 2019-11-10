//
//  GroupJSON.swift
//  Vkontakte
//
//  Created by Валерий Эль-Хатиб on 28.10.2019.
//  Copyright © 2019 EVM Corporation. All rights reserved.
//

import Foundation

class Group: Decodable {
    dynamic var groupName = ""
    
    enum GroupKeys: String, CodingKey {
        case groupName = "name"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: GroupKeys.self)
        self.groupName = try values.decode(String.self, forKey: .groupName)
    }
}
