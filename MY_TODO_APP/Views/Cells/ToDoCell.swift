//
//  ToDoCell.swift
//  MY_TODO_APP
//
//  Created by (^ㅗ^)7 iMac on 2023/08/24.
//

import UIKit

class ToDoCell: UITableViewCell {
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var isSelectedSwitch: UISwitch!

    var indexPath: IndexPath?
    var tableView: UITableView?

    @objc func isSelectedSwitchAction(_ sender: UISwitch) {
        guard let indexPath = indexPath else { return }
        if sender.isOn == true {
            let item = DataManager.dataManager[indexPath.section][indexPath.row]
            DataManager.completionDataManager.append(item)
            DataManager.deleteUserDefaults(indexPath)
            tableView?.reloadData()
            DataManager.saveToUserDefaults()
        } else {
            fatalError()
        }
    }
}
