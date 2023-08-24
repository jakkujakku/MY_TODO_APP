//
//  MainController.swift
//  MY_TODO_APP
//
//  Created by (^ㅗ^)7 iMac on 2023/08/22.
//

import UIKit

class MainController: UIViewController {
    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tappedGoToToDoPageButton(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: Name.todoControllerIdentifier) as? ToDoController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func tappedGoToCompletionPageButton(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: Name.completionControllerIdentifier) as? CompletionController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
