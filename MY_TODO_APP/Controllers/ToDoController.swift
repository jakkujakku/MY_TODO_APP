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
    }

    override func viewWillAppear(_ animated: Bool) {
        DataManager.loadFromUserDefaults()
        DataManager.saveToUserDefaults()
        tableView.reloadData()
    }

    @objc func tappedAddButton(_ sender: UIBarButtonItem) {
        print("눌렀다")
        let sb = UIStoryboard(name: Utility.writeToDoStoryboard, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: Utility.todoWriteController) as? TodoWriteController else { return }
        navigationController?.pushViewController(vc, animated: true)
//        DataManager.dataManager.removeAll()
//        tableView.reloadData()
//        UserDefaults.standard.removeObject(forKey: Utility.userDefaultsKey)
//        print(DataManager.dataManager)
//        DataManager.saveToUserDefaults()
    }

    func tapDeleteButton(data: ToDoData) {
        DataManager.dataManager
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
        let section = indexPath.section
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Utility.todoCellIdentifier, for: indexPath) as? ToDoCell else { return UITableViewCell() }

        let item = DataManager.dataManager[indexPath.section][indexPath.row]
        cell.todoLabel.text = item.title
        cell.isSelectedSwitch.isOn = false
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
