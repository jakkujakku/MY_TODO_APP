//
//  MainController.swift
//  MY_TODO_APP
//
//  Created by (^ㅗ^)7 iMac on 2023/08/22.
//

import UIKit

class MainController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var goToToDoButton: UIButton!
    @IBOutlet weak var goToCompletionButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        goToToDoButton.tintColor = .systemBlue
        goToCompletionButton.tintColor = .systemPink
    }

    @IBAction func tappedGoToToDoPageButton(_ sender: UIButton) {
        let sb = UIStoryboard(name: Utility.todoStoryboard, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: Utility.todoControllerIdentifier) as? ToDoController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func tappedGoToCompletionPageButton(_ sender: UIButton) {
        let sb = UIStoryboard(name: Utility.completionStoryboard, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: Utility.completionControllerIdentifier) as? CompletionController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}

