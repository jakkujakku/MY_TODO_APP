//
//  DataManager.swift
//  MY_TODO_APP
//
//  Created by (^ㅗ^)7 iMac on 2023/08/22.
//

import Foundation

class DataManager: Codable {
    // todo
    static var dataManager: [[ToDoData]] = []
    static var doData = [ToDoData]()
    static var decideData = [ToDoData]()
    static var delegateData = [ToDoData]()
    static var deleteData = [ToDoData]()

    // completion
    static var completionDataManager: [[ToDoData]] = []
    static var completionDoData: [ToDoData] = []
    static var completionDecideData: [ToDoData] = []
    static var completionDelegateData: [ToDoData] = []
    static var completionDeleteData: [ToDoData] = []

    // filterDataSource
    static var filterDatasource = dataManager

    static func saveToDoUserDefaults() {
        do {
            dataManager = [doData, decideData, delegateData, deleteData]
            let encodedData = try JSONEncoder().encode(dataManager)
            UserDefaults.standard.set(encodedData, forKey: Utility.userDefaultsKey)
            print("정상적으로 \(dataManager)를 저장 했습니다.")
        } catch {
            print("Error encoding data: \(error)")
        }
    }

    static func saveCompletionUserDefaults() {
        do {
            completionDataManager = [completionDoData, completionDecideData, completionDelegateData, completionDeleteData]
            let encodedData = try JSONEncoder().encode(completionDataManager)
            UserDefaults.standard.set(encodedData, forKey: Utility.completionUserDefaultsKey)
            print("정상적으로 \(completionDataManager)를 저장 했습니다.")
        } catch {
            print("Error encoding data: \(error)")
        }
    }

    static func loadFromToDoUserDefaults() {
        if let encodedData = UserDefaults.standard.data(forKey: Utility.userDefaultsKey) {
            do {
                dataManager = try JSONDecoder().decode([[ToDoData]].self, from: encodedData)
                if dataManager.isEmpty == false {
                    doData = dataManager[0]
                    decideData = dataManager[1]
                    delegateData = dataManager[2]
                    deleteData = dataManager[3]
                } else {
                    doData = []
                    decideData = []
                    delegateData = []
                    deleteData = []
                }
                print("정상적으로 \(dataManager)를 불러왔습니다.")
            } catch {
                print("Error decoding data: \(error)")
            }
        }
    }

    static func loadFromCompletionUserDefaults() {
        if let encodedData = UserDefaults.standard.data(forKey: Utility.completionUserDefaultsKey) {
            do {
                completionDataManager = try JSONDecoder().decode([[ToDoData]].self, from: encodedData)
                if completionDataManager.isEmpty == false {
                    completionDoData = completionDataManager[0]
                    completionDecideData = completionDataManager[1]
                    completionDelegateData = completionDataManager[2]
                    completionDeleteData = completionDataManager[3]
                } else {
                    completionDoData = []
                    completionDecideData = []
                    completionDelegateData = []
                    completionDeleteData = []
                }
                print("정상적으로 \(dataManager)를 불러왔습니다.")
            } catch {
                print("Error decoding data: \(error)")
            }
        }
    }

    static func deleteUserDefaults(_ indexPath: IndexPath) {
        dataManager[indexPath.section].remove(at: indexPath.row)
        doData = dataManager[0]
        decideData = dataManager[1]
        delegateData = dataManager[2]
        deleteData = dataManager[3]
        UserDefaults.standard.removeObject(forKey: Utility.userDefaultsKey)
        print("정상적으로 \(dataManager) 삭제되었습니다.")
    }

    static func deleteCompletionUserDefaults(_ indexPath: IndexPath) {
        completionDataManager[indexPath.section].remove(at: indexPath.row)
        completionDoData = completionDataManager[0]
        completionDecideData = completionDataManager[1]
        completionDelegateData = completionDataManager[2]
        completionDeleteData = completionDataManager[3]
        UserDefaults.standard.removeObject(forKey: Utility.completionUserDefaultsKey)
        print("정상적으로 \(completionDataManager) 삭제되었습니다.")
    }

    static func deleteFilterDatasource(_ indexPath: IndexPath) {
<<<<<<< HEAD
        DataManager.filterDatasource[indexPath.section].remove(at: indexPath.row)
=======
        filterDatasource[indexPath.section].remove(at: indexPath.row)
>>>>>>> master
    }
}

// ToDo - Data
struct ToDoData: Codable {
    var title: String
    var section: String
}
