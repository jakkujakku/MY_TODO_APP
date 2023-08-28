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

            switch item.section {
            case Section.do.rawValue:
                DataManager.completionDoData.insert(item, at: 0)
                DataManager.saveCompletionUserDefaults()
                print("\(DataManager.completionDoData) - DO")
            case Section.decide.rawValue:
                DataManager.completionDecideData.insert(item, at: 0)
                DataManager.saveCompletionUserDefaults()
                print("\(DataManager.completionDecideData) - DECIDE")
            case Section.delegate.rawValue:
                DataManager.completionDelegateData.insert(item, at: 0)
                DataManager.saveCompletionUserDefaults()
                print("\(DataManager.completionDecideData) - DELEGATE")
            case Section.delete.rawValue:
                DataManager.completionDeleteData.insert(item, at: 0)
                DataManager.saveCompletionUserDefaults()
                print("\(DataManager.completionDecideData) - DELETE")
            default:
                return
            }

            DataManager.deleteUserDefaults(indexPath)
            tableView?.reloadData()
            DataManager.saveToDoUserDefaults()
        } else {
            fatalError()
        }
    }
}
