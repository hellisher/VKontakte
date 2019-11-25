//
//  Database.swift
//  Vkontakte
//
//  Created by Валерий Эль-Хатиб on 16.11.2019.
//  Copyright © 2019 EVM Corporation. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDatabase {
    
    static let shared = RealmDatabase()
    private init () {}
    
    //Сохранение списка друзей пользователя в Realm
    func saveUserFriendsData(_ friends: [Friend]) {
        do {
            let realm = try Realm()
            let oldFriends = realm.objects(Friend.self)
            try! realm.write {
                realm.delete(oldFriends)
                realm.add(friends)
            }
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error)
        }
    }
    
    //Загрузка списка друзей пользователя из базы данных Realm
    func loadFriendsData() -> [Friend] {
            let realm = try! Realm()
            let friends = realm.objects(Friend.self)
            return Array(friends)
    }
    
    //Сохранение фотографий пользователя в Realm
    func saveUserPhotosData(_ photos: [UserPhoto]) {
        do {
            let realm = try Realm()
            let oldPhotos = realm.objects(UserPhoto.self)
            try! realm.write {
                realm.delete(oldPhotos)
                realm.add(photos)
            }
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error)
        }
    }
    
    //Загрузка фотографий пользователя из базы данных Realm
    func loadUserPhotosData() -> [UserPhoto] {
        let realm = try! Realm()
        let photos = realm.objects(UserPhoto.self)
        return Array(photos)
    }
    
    //Сохранение списка групп пользователя в Realm
    func saveUserGroupsData(_ groups: [Group]) {
        do {
            let realm = try Realm()
            let oldGroups = realm.objects(Group.self)
            try! realm.write {
                realm.delete(oldGroups)
                realm.add(groups)
            }
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error)
        }
    }
    
    //Загрузка списка групп пользователя из базы данных Realm
    func loadGroupsData() -> [Group] {
            let realm = try! Realm()
            let groups = realm.objects(Group.self)
            return Array(groups)
    }
    
}
