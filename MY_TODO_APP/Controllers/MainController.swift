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
        setupUI()
    }
    
    func setupUI() {
        goToToDoButton.tintColor = .systemBlue
        goToCompletionButton.tintColor = .systemPink
    }

    @IBAction func tappedGoToToDoPageButton(_ sender: UIButton) {
        let sb = UIStoryboard(name: Name.todoStoryboard, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: Name.todoControllerIdentifier) as? ToDoController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func tappedGoToCompletionPageButton(_ sender: UIButton) {
        let sb = UIStoryboard(name: Name.completionStoryboard, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: Name.completionControllerIdentifier) as? CompletionController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
