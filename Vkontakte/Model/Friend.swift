//
//  User.swift
//  Vkontakte
//
//  Created by Валерий Эль-Хатиб on 21.10.2019.
//  Copyright © 2019 EVM Corporation. All rights reserved.
//

import Foundation
import UIKit

struct Friend {
    var friendName: String?
    var friendImage: UIImage?
}

let steveJobs = Friend(friendName: "Steve Jobs", friendImage: UIImage(named: "SteveJobsPhoto"))
let jonathanIve = Friend(friendName: "Jonathan Ive", friendImage: UIImage(named: "JonathanIvePhoto"))
let elonMusk = Friend(friendName: "Elon Musk", friendImage: UIImage(named: "ElonMuskPhoto"))
let philKnight = Friend(friendName: "Phil Knight", friendImage: UIImage(named: "PhilKnightPhoto"))

let myFriends = [steveJobs, jonathanIve, elonMusk, philKnight]

