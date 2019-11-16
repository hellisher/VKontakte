//
//  Database.swift
//  Vkontakte
//
//  Created by Валерий Эль-Хатиб on 16.11.2019.
//  Copyright © 2019 EVM Corporation. All rights reserved.
//

import Foundation
import RealmSwift

class Database {
    let database = Database()
    
    //Сохранение списка  друзей пользователя в Realm
    func saveUserFriendsData(_ friends: [Friend]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(friends)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    
}
