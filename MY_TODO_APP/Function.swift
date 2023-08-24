//
//  Function.swift
//  MY_TODO_APP
//
//  Created by (^ㅗ^)7 iMac on 2023/08/24.
//

import UIKit

protocol SetupDelegateProtocol {
    func setup()
}

struct Function {
//    static func showAlert(alertTitle: String) {
//        // Alert 생성
//        let alert = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
//        // 등록 버튼 생성
//        let registerButton = UIAlertAction(title: "등록", style: .default, handler: { [weak self] _ in
//            guard let title = alert.textFields?[0].text else { return }
//            let todoLists = TodoList(title: title, isSelected: false)
//            self?.todoList.append(todoLists)
//            self?.tableView.reloadData()
//        })
//        
//        // 취소 버튼 생성
//        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
//        alert.addTextField(configurationHandler: { textField in
//            textField.placeholder = "할 일을 입력해주세요."
//            textField.textAlignment = .center
//        })
//        alert.addAction(cancelButton)
//        alert.addAction(registerButton)
//        self.present(alert, animated: true, completion: nil)
//    }
}

