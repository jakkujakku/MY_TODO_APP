//
//  CompletionController.swift
//  MY_TODO_APP
//
//  Created by (^ㅗ^)7 iMac on 2023/08/24.
//

import UIKit

class CompletionController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    let importanceSignal = ["🔴", "🟠", "🟡", "🟢"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}

extension CompletionController: SetupDelegateProtocol {
    func setup() {
        tableView.dataSource = self
        navigationItem.title = "할 일 작성"
    }
}

// MARK: - UITableViewDataSource

extension CompletionController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.completionDataManager.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Utility.completionCellIdentifier, for: indexPath) as? CompletionCell else { return UITableViewCell() }
        let item = DataManager.completionDataManager[indexPath.row]
        let sectionItem = item.section

        cell.completionLabel.text = item.title

        switch sectionItem {
        case Section.do.rawValue:
            cell.importanceLabel.text = importanceSignal[0]
        case Section.decide.rawValue:
            cell.importanceLabel.text = importanceSignal[1]
        case Section.delegate.rawValue:
            cell.importanceLabel.text = importanceSignal[2]
        case Section.delete.rawValue:
            cell.importanceLabel.text = importanceSignal[3]
        default:
            break
        }
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DataManager.completionDataManager.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
