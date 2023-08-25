//
//  DataManager.swift
//  MY_TODO_APP
//
//  Created by (^ㅗ^)7 iMac on 2023/08/22.
//

import Foundation

class DataManager: Codable {
    static var dataManager: [[ToDoData]] = []
    static var doDataManager = [ToDoData]()
    static var decideDataManager = [ToDoData]()
    static var delegateDataManager = [ToDoData]()
    static var deleteDataManager = [ToDoData]()

    static var completionDataManager = [ToDoData]()

    static func saveToUserDefaults() {
        do {
            dataManager = [doDataManager, decideDataManager, delegateDataManager, deleteDataManager]
            let encodedData = try JSONEncoder().encode(dataManager)
            UserDefaults.standard.set(encodedData, forKey: Utility.userDefaultsKey)
            print("정상적으로 \(dataManager)를 저장 했습니다.")
        } catch {
            print("Error encoding data: \(error)")
        }
    }

    static func loadFromUserDefaults() {
        if let encodedData = UserDefaults.standard.data(forKey: Utility.userDefaultsKey) {
            do {
                dataManager = try JSONDecoder().decode([[ToDoData]].self, from: encodedData)
                if dataManager.isEmpty == false {
                    doDataManager = dataManager[0]
                    decideDataManager = dataManager[1]
                    delegateDataManager = dataManager[2]
                    deleteDataManager = dataManager[3]
                } else {
                    doDataManager = []
                    decideDataManager = []
                    delegateDataManager = []
                    deleteDataManager = []
                }
                print("정상적으로 \(dataManager)를 불러왔습니다.")
            } catch {
                print("Error decoding data: \(error)")
            }
        }
    }

    static func deleteUserDefaults(_ indexPath: IndexPath) {
        DataManager.dataManager[indexPath.section].remove(at: indexPath.row)
        doDataManager = dataManager[0]
        decideDataManager = dataManager[1]
        delegateDataManager = dataManager[2]
        deleteDataManager = dataManager[3]
        UserDefaults.standard.removeObject(forKey: Utility.userDefaultsKey)
        print("정상적으로 \(dataManager) 삭제되었습니다.")
    }
}

// ToDo - Data
struct ToDoData: Codable {
    var title: String
    var date: String
    var section: String
}
