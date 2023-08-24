//
//  DataManager.swift
//  MY_TODO_APP
//
//  Created by (^ㅗ^)7 iMac on 2023/08/22.
//

import Foundation

class DataManager: Codable {
    static var dataManager = [ToDoData]()

    // Userdefaults 저장
    static func saveToUserDefaults() {
        do {
            let encodedData = try JSONEncoder().encode(dataManager)
            UserDefaults.standard.set(encodedData, forKey: Utility.userDefaultsKey)
            print("저장된 데이터 : \(encodedData)")
        } catch {
            print("Error encoding data: \(error)")
        }
    }

    // Userdefaults 불러오기
    static func loadFromUserDefaults() {
        if let encodedData = UserDefaults.standard.data(forKey: Utility.userDefaultsKey) {
            do {
                dataManager = try JSONDecoder().decode([ToDoData].self, from: encodedData)
                print("로드 된 데이터 : \(dataManager))")
            } catch {
                print("Error decoding data: \(error)")
            }
        }
    }
}

// ToDo - Data
struct ToDoData: Codable {
    var title: String
    var date: String
}
