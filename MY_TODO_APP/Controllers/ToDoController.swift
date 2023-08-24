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
        DataManager.loadFromUserDefaults(section: "DO")
        DataManager.loadFromUserDefaults(section: "DECIDE")
        DataManager.loadFromUserDefaults(section: "DELEGATE")
        DataManager.loadFromUserDefaults(section: "DELETE")
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
//        if section == 0 {
//            return DataManager.dataManagerCopy0.count
//        } else if section == 1 {
//            return DataManager.dataManagerCopy.count
//        } else if section == 2 {
//            return DataManager.dataManagerCopy2.count
//        }
        return DataManager.dataManager[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Utility.todoCellIdentifier, for: indexPath) as? ToDoCell else { return UITableViewCell() }
//        if section == 0 {
//            let item = DataManager.dataManager[indexPath.row]
//            DataManager.dataManager.sort(by: { $0.date > $1.date })
//            cell.todoLabel.text = item.title
//            cell.todoLabel.text = item.title
//            cell.isSelectedSwitch.isOn = false
//            return cell
//
//        } else if section == 1 {
//            let item = DataManager.dataManagerCopy[indexPath.row]
//            DataManager.dataManagerCopy.sort(by: { $0.date > $1.date })
//            cell.todoLabel.text = item.title
//            cell.todoLabel.text = item.title
//            cell.isSelectedSwitch.isOn = false
//            return cell
//
//        } else if section == 2 {
//            let item = DataManager.dataManagerCopy2[indexPath.row]
//            DataManager.dataManagerCopy2.sort(by: { $0.date > $1.date })
//            cell.todoLabel.text = item.title
//            cell.todoLabel.text = item.title
//            cell.isSelectedSwitch.isOn = false
//            return cell
//        } else if section == 3 {
//            let item = DataManager.dataManagerCopy3[indexPath.row]
//            DataManager.dataManagerCopy3.sort(by: { $0.date > $1.date })
//            cell.todoLabel.text = item.title
//            cell.todoLabel.text = item.title
//            cell.isSelectedSwitch.isOn = false
//            return cell
//        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: Utility.todoCellIdentifier, for: indexPath) as? ToDoCell else { return UITableViewCell() }
//        let dataArray = [DataManager.dataManager, DataManager.dataManagerCopy, DataManager.dataManagerCopy2, DataManager.dataManagerCopy3]
//        let dataArray = [DatManager.dataManager,DatManager.dataManager]
//        memoSection[indexPath.section].memoDatas[indexPath.row].time
        let item = DataManager.dataManager[indexPath.section][indexPath.row]
        //        DataManager.deleteData.sort(by: { $0.date > $1.date })
        //        cell.todoLabel.text = item.title
        cell.todoLabel.text = item.title
        cell.isSelectedSwitch.isOn = false

        return cell
    }
}
