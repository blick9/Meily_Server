//
//  DataModel.swift
//  Kitura-Maily
//
//  Created by Febrix on 2017. 4. 4..
//
//

import Foundation

public class DataBase {
    static let sharedInstance : DataBase = {
        let instance = DataBase()
        return instance
    }()
    private var usersListDictionary = [[String:String]]()
    private var currentLogInUser = String()
    
    func getUserEmailList() -> [String] {
        var tempArray = [String]()
        for items in usersListDictionary {
            if let existItem = items["email"] {
                tempArray.append(existItem)
            }
        }
        return tempArray
    }
    
    func saveUserData(Email : String, Password : String) -> Bool {
        var isSuccess = false
        if validDuplication(email: Email) == false {
            let user = ["email":Email, "password":Password]
            usersListDictionary.append(user)
            isSuccess = true
        } else {
            isSuccess = false
        }
        return isSuccess
    }
    
    func validDuplication(email : String) -> Bool {
        let usersList = getUserEmailList()
        var isDuplication = false
        if usersList.contains(email) {
            isDuplication = true
        }
        return isDuplication
    }
    
    func login(Email : String, Password : String) -> Bool {
        let user = usersListDictionary.filter{$0.values.contains(Email)}.map {$0["password"]!}
        var isLogin = false
        if user[0] == Password {
            isLogin = true
        }
        return isLogin
    }
}
