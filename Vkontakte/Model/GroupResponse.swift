//
//  GroupResponse.swift
//  Vkontakte
//
//  Created by Валерий Эль-Хатиб on 30.10.2019.
//  Copyright © 2019 EVM Corporation. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GroupResponse: Decodable {
    let list: [Group]
}
