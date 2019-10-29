//
//  User.swift
//  Vkontakte
//
//  Created by Валерий Эль-Хатиб on 28.10.2019.
//  Copyright © 2019 EVM Corporation. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    var id: String
    var firstName: String
    var lastName: String
    var photo: URL?
    
    init(_ json: JSON) {
        self.id = json["id"].stringValue
        self.firstName = json["firstName"].stringValue
        self.lastName = json["lastName"].stringValue
        let photoString = json["photoString"].stringValue
        self.photo = URL(string: photoString)
    }
    
}
