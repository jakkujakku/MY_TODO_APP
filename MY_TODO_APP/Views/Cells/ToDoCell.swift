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
<<<<<<< HEAD
    var iseEditMode: Bool?
=======
    var isEditMode: Bool?
>>>>>>> master

    @objc func isSelectedSwitchAction(_ sender: UISwitch) {
        guard let indexPath = indexPath else { return }
        guard let tableView = tableView else { return }
        sleep(UInt32(1))
        if sender.isOn == true {
            let item = DataManager.dataManager[indexPath.section][indexPath.row]

            switch item.section {
            case Section.do.rawValue:
<<<<<<< HEAD
                DataManager.deleteFilterDatasource(indexPath)
                DataManager.deleteUserDefaults(indexPath)
=======
                if isEditMode == true {
                    DataManager.deleteFilterDatasource(indexPath)
                }

>>>>>>> master
                DataManager.completionDoData.insert(item, at: 0)
                DataManager.deleteUserDefaults(indexPath)

                DataManager.saveCompletionUserDefaults()
                DataManager.saveToDoUserDefaults()
                print("### \(DataManager.completionDoData) - DO")
            case Section.decide.rawValue:
<<<<<<< HEAD
                DataManager.deleteFilterDatasource(indexPath)
                DataManager.deleteUserDefaults(indexPath)
=======
                if isEditMode == true {
                    DataManager.deleteFilterDatasource(indexPath)
                }
>>>>>>> master
                DataManager.completionDecideData.insert(item, at: 0)
                DataManager.deleteUserDefaults(indexPath)
                DataManager.saveCompletionUserDefaults()
                DataManager.saveToDoUserDefaults()
                print("### \(DataManager.completionDecideData) - DECIDE")
            case Section.delegate.rawValue:
<<<<<<< HEAD
                DataManager.deleteFilterDatasource(indexPath)
                DataManager.deleteUserDefaults(indexPath)
=======
                if isEditMode == true {
                    DataManager.deleteFilterDatasource(indexPath)
                }
>>>>>>> master
                DataManager.completionDelegateData.insert(item, at: 0)
                DataManager.deleteUserDefaults(indexPath)
                DataManager.saveCompletionUserDefaults()
                DataManager.saveToDoUserDefaults()
                print("### \(DataManager.completionDecideData) - DELEGATE")
            case Section.delete.rawValue:
<<<<<<< HEAD
                DataManager.deleteFilterDatasource(indexPath)
                DataManager.deleteUserDefaults(indexPath)
=======
                if isEditMode == true {
                    DataManager.deleteFilterDatasource(indexPath)
                }
>>>>>>> master
                DataManager.completionDeleteData.insert(item, at: 0)
                DataManager.deleteUserDefaults(indexPath)
                DataManager.saveCompletionUserDefaults()
                DataManager.saveToDoUserDefaults()
                print("### \(DataManager.completionDecideData) - DELETE")
            default:
                return
            }
            DataManager.saveToDoUserDefaults()
            print("### tableView reloadData")
            tableView.reloadData()
        }
    }
}
