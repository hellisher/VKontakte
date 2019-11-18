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
    
    static let shared = Database()
    
    var friends = [Friend]()
    var myGroups = [Group]()
    
    //Сохранение списка друзей пользователя в Realm
    func saveUserFriendsData(_ friends: [Friend]) {
        do {
            let realm = try Realm()
            let oldFriends = realm.objects(Friend.self)
            realm.beginWrite()
            realm.delete(oldFriends)
            realm.add(friends)
            try realm.commitWrite()
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error)
        }
    }
    
    func loadFriendsData() {
        do {
            let realm = try Realm()
            let friends = realm.objects(Friend.self)
            self.friends = Array(friends)
        } catch {
            print(error)
        }
    }
    
    //Сохранение фотографий пользователя в Realm
    func saveUserPhotosData(_ photos: [UserPhoto]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(photos)
            try realm.commitWrite()
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error)
        }
    }
    
    //Сохранение списка групп пользователя в Realm
    func saveUserGroupsData(_ groups: [Group]) {
        do {
            let realm = try Realm()
            let oldGroups = realm.objects(Group.self)
            realm.beginWrite()
            realm.delete(oldGroups)
            realm.add(groups)
            try realm.commitWrite()
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error)
        }
    }
    
    func loadGroupsData() {
        do {
            let realm = try Realm()
            let groups = realm.objects(Group.self)
            self.myGroups = Array(groups)
        } catch {
            print(error)
        }
    }
    
}
