//
//  TodoWriteController.swift
//  MY_TODO_APP
//
//  Created by (^ㅗ^)7 iMac on 2023/08/24.
//

import UIKit

class TodoWriteController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!

    let maxValue = 2
    let pickerViewCount = 1
    var sectionName = ["DO", "DECIDE", "DELEGATE", "DELETE"]
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
        selectedSection = sectionName[0]
    }

    @objc private func textFieldDidChange() {
        saveButton.isEnabled = textField.text?.isEmpty == true ? false : true
    }

    @IBAction func tappedSaveButton(_ sender: UIButton) {
        guard let text = textField.text else { return }
        let todoData = ToDoData(title: text, date: Utility.dateFormatter(), section: selectedSection)
        print(selectedSection)

        switch selectedSection {
        case "DO":
            DataManager.doDataManager.append(todoData)
            DataManager.dataManager.append(DataManager.doDataManager)
            DataManager.saveToUserDefaults()
            print("\(DataManager.doDataManager) - DO")
        case "DECIDE":
            DataManager.decideDataManager.append(todoData)
            DataManager.dataManager.append(DataManager.decideDataManager)
            DataManager.saveToUserDefaults()
            print("\(DataManager.decideDataManager) - DECIDE")
        case "DELEGATE":
            DataManager.delegateDataManager.append(todoData)
            DataManager.dataManager.append(DataManager.delegateDataManager)
            DataManager.saveToUserDefaults()
            print("\(DataManager.delegateDataManager) - DELEGATE")
        case "DELETE":
            DataManager.deleteDataManager.append(todoData)
            DataManager.dataManager.append(DataManager.deleteDataManager)
            DataManager.saveToUserDefaults()
            print("\(DataManager.deleteDataManager) - DELETE")
        default:
            return
        }
        DataManager.dataManager = [DataManager.doDataManager, DataManager.decideDataManager, DataManager.delegateDataManager, DataManager.deleteDataManager]
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
        return sectionName[row]
    }
}

extension TodoWriteController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSection = sectionName[row]
    }
}
