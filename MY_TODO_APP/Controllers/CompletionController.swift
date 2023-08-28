//
//  CompletionController.swift
//  MY_TODO_APP
//
//  Created by (^ㅗ^)7 iMac on 2023/08/24.
//

import UIKit

enum Signal: String {
    case red = "🔴"
    case orange = "🟠"
    case yellow = "🟡"
    case green = "🟢"
}

class CompletionController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    let importanceSignal: [Signal] = [.red, .orange, .yellow, .green]

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addSearchBar()
        topViewUp()
    }

    override func viewWillAppear(_ animated: Bool) {
        DataManager.loadFromCompletionUserDefaults()
        tableView.reloadData()
    }
}

extension CompletionController: SetupDelegateProtocol {
    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = "할 일 작성"
    }

    // 스크롤시 서치바 보이게 하는 함수 ✅
    func topViewUp() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            // 상단에 서치바 올리기
            self.view.transform = CGAffineTransform(translationX: 0, y: 0)
            self.addSearchBar()
            self.view.layoutIfNeeded()
        })
    }

    // 서치바 추가 ✅
    func addSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        // 검색컨트롤러는 검색하는 동안 네비게이션바에 가려지지않도록한다
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
}

// MARK: - UITableViewDataSource

extension CompletionController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return DataManager.completionDataManager.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.completionDataManager[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Utility.completionCellIdentifier, for: indexPath) as? CompletionCell else { return UITableViewCell() }
        let item = DataManager.completionDataManager[indexPath.section][indexPath.row]
        let sectionItem = item.section

        cell.completionLabel.text = item.title

        switch sectionItem {
        case Section.do.rawValue:
            cell.importanceLabel.text = importanceSignal[0].rawValue
        case Section.decide.rawValue:
            cell.importanceLabel.text = importanceSignal[1].rawValue
        case Section.delegate.rawValue:
            cell.importanceLabel.text = importanceSignal[2].rawValue
        case Section.delete.rawValue:
            cell.importanceLabel.text = importanceSignal[3].rawValue
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
            DataManager.deleteCompletionUserDefaults(indexPath)
            DataManager.saveCompletionUserDefaults()
            tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "완료된 DO의 개수 \(DataManager.completionDoData.count)"
        } else if section == 1 {
            return "완료된 DECIDE의 개수 \(DataManager.completionDecideData.count)"
        } else if section == 2 {
            return "완료된 DELEGATE의 개수 \(DataManager.completionDelegateData.count)"
        } else if section == 3 {
            return "완료된 DELETE의 개수 \(DataManager.completionDeleteData.count)"
        }
        return ""
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        if section == 0 {
            return "DO - 중요하고 긴급한 일 \(Signal.red.rawValue)"
        } else if section == 1 {
            return "DECIDE - 중요하지 않지만 긴급한 일 \(Signal.orange.rawValue)"
        } else if section == 2 {
            return "DELEGATE - 중요하지만 긴급하지 않은 일 \(Signal.yellow.rawValue)"
        } else if section == 3 {
            return "DELETE - 중요하지도 긴급하지도 않은 일 \(Signal.green.rawValue)"
        }
        return ""
    }
}

extension CompletionController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
}

extension CompletionController: UISearchBarDelegate {}
