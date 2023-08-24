//
//  ToDoController.swift
//  MY_TODO_APP
//
//  Created by (^ㅗ^)7 iMac on 2023/08/24.
//

import UIKit

class ToDoController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private let addBarButtonItem = CustomUIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        DataManager.loadFromUserDefaults()
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    @objc func tappedAddButton(_ sender: UIBarButtonItem) {
        print("눌렀다")
        showAlert()
    }
    
    // 날짜 형식 변환 ✅
    func dateFormatter()  -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. M. d a hh:mm:ss"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: Date())
    }

    func showAlert() {
        // Alert 생성
        let alert = UIAlertController(title: "할 일하기", message: nil, preferredStyle: .alert)
        // 등록 버튼 생성
        let registerButton = UIAlertAction(title: "등록", style: .default, handler: { [weak self] _ in
            guard let title = alert.textFields?[0].text else { return }
            let todoList = ToDoData(title: title)
            DataManager.dataManager[self!.dateFormatter()] = todoList
            DataManager.saveToUserDefaults()
            self?.tableView.reloadData()
        })

        // 취소 버튼 생성
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "할 일을 입력해주세요."
            textField.textAlignment = .center
        })

        alert.addAction(cancelButton)
        alert.addAction(registerButton)
        present(alert, animated: true, completion: nil)
    }
}

extension ToDoController: SetupDelegateProtocol {
    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = "할 일 작성"

        navigationItem.rightBarButtonItem = addBarButtonItem
        addBarButtonItem.target = self
        addBarButtonItem.action = #selector(tappedAddButton(_:))
    }
}

// MARK: - UITableViewDataSource

extension ToDoController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.dataManager.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Utility.todoCellIdentifier, for: indexPath) as? ToDoCell else { return UITableViewCell() }
        let dataManagerIndex = DataManager.dataManager.index(DataManager.dataManager.startIndex, offsetBy: indexPath.row)
        cell.todoLabel.text = DataManager.dataManager[dataManagerIndex].value.title
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ToDoController: UITableViewDelegate {}
