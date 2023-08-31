
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
    private var indexPathValue: IndexPath?
    var cunrrentSwitchValue: Bool = false

    var isEditMode: Bool {
        let searchController = navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addSearchBar()
        topViewUp()
    }

    override func viewWillAppear(_ animated: Bool) {
        DataManager.loadFromToDoUserDefaults()
        tableView.reloadData()
    }

    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = "할 일 작성"
        navigationItem.rightBarButtonItem = addBarButtonItem
        addBarButtonItem.target = self
        addBarButtonItem.action = #selector(tappedAddButton(_:))
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
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }

    @objc func tappedAddButton(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: Utility.writeToDoStoryboard, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: Utility.todoWriteController) as? TodoWriteController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ToDoController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return isEditMode ? DataManager.filterDatasource.count : DataManager.dataManager.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isEditMode ? DataManager.filterDatasource[section].count : DataManager.dataManager[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Utility.todoCellIdentifier, for: indexPath) as? ToDoCell else { return UITableViewCell() }
        cell.todoLabel.text = isEditMode ? DataManager.filterDatasource[indexPath.section][indexPath.row].title : DataManager.dataManager[indexPath.section][indexPath.row].title
        cell.indexPath = indexPath
        cell.tableView = tableView
        cell.isEditMode = isEditMode
        cell.isSelectedSwitch.isOn = false
        cell.isSelectedSwitch.addTarget(cell, action: #selector(cell.isSelectedSwitchAction(_:)), for: .valueChanged)
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DataManager.deleteUserDefaults(indexPath)
            DataManager.saveToDoUserDefaults()
            tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "DO의 개수 \(DataManager.doData.count)"
        } else if section == 1 {
            return "DECIDE의 개수 \(DataManager.decideData.count)"
        } else if section == 2 {
            return "DELEGATE의 개수 \(DataManager.delegateData.count)"
        } else if section == 3 {
            return "DELETE의 개수 \(DataManager.deleteData.count)"
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

extension ToDoController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(isEditing ? DataManager.filterDatasource[indexPath.row] : DataManager.dataManager[indexPath.section][indexPath.row])
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
}

extension ToDoController: UISearchBarDelegate {
    override class func didChangeValue(forKey key: String) {
        print(DataManager.filterDatasource.count)
    }
}

extension ToDoController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        DataManager.filterDatasource = DataManager.dataManager.compactMap {
            $0.filter { $0.title.contains(text) }
        }
        tableView.reloadData()
    }
}
