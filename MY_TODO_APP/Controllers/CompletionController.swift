//
//  CompletionController.swift
//  MY_TODO_APP
//
//  Created by (^ㅗ^)7 iMac on 2023/08/24.
//

import UIKit

class CompletionController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

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
//        tableView.dataSource = self
//        tableView.delegate = self
        navigationItem.title = "할 일 작성"
    }
}

// MARK: - UITableViewDataSource

//extension CompletionController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: Utility.completionCellIdentifier, for: indexPath) as? CompletionCell else { return UITableViewCell() }
//        return cell
//    }
//}
//
//// MARK: - UITableViewDelegate
//
//extension CompletionController: UITableViewDelegate {}
