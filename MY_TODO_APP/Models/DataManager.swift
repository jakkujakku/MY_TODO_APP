//
//  DataManager.swift
//  MY_TODO_APP
//
//  Created by (^ㅗ^)7 iMac on 2023/08/22.
//

import Foundation

class DataManager: Codable {
//    static var dataManager = [dataManagerCopy0, dataManagerCopy1, dataManagerCopy2, dataManagerCopy3]
    static var dataManager: [[ToDoData]] = [doDataManager, decideDataManager, delegateDataManager, deleteDataManager]
    static var doDataManager: [ToDoData] = []
    static var decideDataManager: [ToDoData] = []
    static var delegateDataManager: [ToDoData] = []
    static var deleteDataManager: [ToDoData] = []
    static var completionDataManager: [ToDoData] = []

    static func saveToUserDefaults() {
        do {
            let encodedData = try JSONEncoder().encode(dataManager)
            UserDefaults.standard.set(encodedData, forKey: Utility.userDefaultsKey)
            print("\(encodedData) 저장 했습니다.")
        } catch {
            print("Error encoding data: \(error)")
        }
    }

    static func loadFromUserDefaults() {
        if let encodedData = UserDefaults.standard.data(forKey: Utility.userDefaultsKey) {
            do {
                dataManager = try JSONDecoder().decode([[ToDoData]].self, from: encodedData)
                print("\(dataManager) 를 불러왔습니다.")
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
    var section: String
}
