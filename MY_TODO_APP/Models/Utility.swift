//
//  Utility.swift
//  MY_TODO_APP
//
//  Created by (^ㅗ^)7 iMac on 2023/08/24.
//

import Foundation

class Utility {
    // StoryBoards
    static let todoStoryboard = "ToDo"
    static let completionStoryboard = "Completion"
    static let writeToDoStoryboard = "WriteToDo"

    // Controllers
    static let mainControllerIdentifier = "MainController"
    static let todoControllerIdentifier = "ToDoController"
    static let completionControllerIdentifier = "CompletionController"
    static let todoWriteController = "TodoWriteController"

    // Cells
    static let todoCellIdentifier = "ToDoCell"
    static let completionCellIdentifier = "CompletionCell"

    // UserDefaultsKey
    static let userDefaultsKey = "userData"
    
    // 날짜 형식 변환 ✅
    static func dateFormatter() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. M. d a hh:mm:ss"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: Date())
    }
}
