//
//  TodoWriteController.swift
//  MY_TODO_APP
//
//  Created by (^ㅗ^)7 iMac on 2023/08/24.
//

import UIKit

enum Section: String {
    case `do` = "DO"
    case decide = "DECIDE"
    case delegate = "DELEGATE"
    case delete = "DELETE"
}

class TodoWriteController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!

    let pickerViewCount = 1
    var sectionName: [Section] = [.do, .decide, .delegate, .delete]
    var selectedSection = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        pickerView.delegate = self
        pickerView.dataSource = self

        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        saveButton.isEnabled = false
        selectedSection = sectionName[0].rawValue
    }

    @objc private func textFieldDidChange() {
        saveButton.isEnabled = textField.text?.isEmpty == true ? false : true
    }

    @IBAction func tappedSaveButton(_ sender: UIButton) {
        guard let text = textField.text else { return }
        let todoData = ToDoData(title: text, section: selectedSection)

        switch selectedSection {
        case Section.do.rawValue:
            DataManager.doData.insert(todoData, at: 0)
            DataManager.saveToDoUserDefaults()
            print("\(DataManager.doData) - DO")
        case Section.decide.rawValue:
            DataManager.decideData.insert(todoData, at: 0)
            DataManager.saveToDoUserDefaults()
            print("\(DataManager.decideData) - DECIDE")
        case Section.delegate.rawValue:
            DataManager.delegateData.insert(todoData, at: 0)
            DataManager.saveToDoUserDefaults()
            print("\(DataManager.delegateData) - DELEGATE")
        case Section.delete.rawValue:
            DataManager.deleteData.insert(todoData, at: 0)
            DataManager.saveToDoUserDefaults()
            print("\(DataManager.deleteData) - DELETE")
        default:
            return
        }
        navigationController?.popViewController(animated: true)
    }
}

extension TodoWriteController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerViewCount
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sectionName.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sectionName[row].rawValue
    }
}

extension TodoWriteController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSection = sectionName[row].rawValue
    }
}
