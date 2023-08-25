//
//  ToDoController.swift
//  MY_TODO_APP
//
//  Created by (^ㅗ^)7 iMac on 2023/08/24.
//

import UIKit

// 셀 자체에서 상태 값이 변하는 것을 컨트롤러로 전달 -> 컨트롤러는 상태의 변화 인지하고, 셀을 삭제 여부 결정

class ToDoController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private let addBarButtonItem = CustomUIBarButtonItem()
    private var indexPathValue: IndexPath?
    var cunrrentSwitchValue: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        DataManager.loadFromUserDefaults()
        tableView.reloadData()
    }

    @objc func tappedAddButton(_ sender: UIBarButtonItem) {
        print("눌렀다")
        let sb = UIStoryboard(name: Utility.writeToDoStoryboard, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: Utility.todoWriteController) as? TodoWriteController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ToDoController: SetupDelegateProtocol {
    func setup() {
        tableView.dataSource = self
        navigationItem.title = "할 일 작성"
        navigationItem.rightBarButtonItem = addBarButtonItem
        addBarButtonItem.target = self
        addBarButtonItem.action = #selector(tappedAddButton(_:))
    }
}

// MARK: - UITableViewDataSource

extension ToDoController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return DataManager.dataManager.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.dataManager[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Utility.todoCellIdentifier, for: indexPath) as? ToDoCell else { return UITableViewCell() }
        let item = DataManager.dataManager[indexPath.section][indexPath.row]
        cell.todoLabel.text = item.title
        cell.isSelectedSwitch.isOn = false

        cell.indexPath = indexPath
        cell.tableView = tableView
        cell.isSelectedSwitch.addTarget(cell, action: #selector(cell.isSelectedSwitchAction(_:)), for: .valueChanged)

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "DO"
        } else if section == 1 {
            return "DECIDE"
        } else if section == 2 {
            return "DELEGATE"
        } else if section == 3 {
            return "DELETE"
        }
        return ""
    }
}
