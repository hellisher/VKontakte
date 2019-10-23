//
//  Group.swift
//  Vkontakte
//
//  Created by Валерий Эль-Хатиб on 21.10.2019.
//  Copyright © 2019 EVM Corporation. All rights reserved.
//

import Foundation
import UIKit

struct Group {
    var groupName: String?
    var groupImage: UIImage?
}

let apple = Group(groupName: "Apple", groupImage: UIImage(named: "AppleGroupImage"))
let tesla = Group(groupName: "Tesla", groupImage: UIImage(named: "TeslaGroupImage"))
let netflix = Group(groupName: "Netflix", groupImage: UIImage(named: "NetflixGroupImage"))
let nikeRunClub = Group(groupName: "Nike Run Club", groupImage: UIImage(named: "NRCGroupImage"))
let yandex = Group(groupName: "Яндекс", groupImage: UIImage(named: "ЯндексGroupImage"))

let groups = [apple, tesla, netflix, nikeRunClub, yandex]
