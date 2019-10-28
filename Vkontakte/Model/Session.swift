//
//  Session.swift
//  Vkontakte
//
//  Created by Валерий Эль-Хатиб on 23.10.2019.
//  Copyright © 2019 EVM Corporation. All rights reserved.
//

import Foundation
import UIKit

class Session {
    
    static let instance = Session()
    
    private init () {}
    
    var userName:String = "Valerii El-Khatib"
    var userPhoto: UIImage = UIImage(named: "El-Khatib")!
    var userID: Int = 0
    var token: String = ""
    
}
