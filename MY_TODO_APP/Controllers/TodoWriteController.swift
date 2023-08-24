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
        let todoData = ToDoData(title: text, date: dateFormatter(), section: selectedSection)
        print(selectedSection)

        
        switch selectedSection {
        case "DO":
            DataManager.dataManagerCopy0.append(todoData)
            DataManager.dataManager = [DataManager.dataManagerCopy0, DataManager.dataManagerCopy1, DataManager.dataManagerCopy2, DataManager.dataManagerCopy3]
            DataManager.saveToUserDefaults(section: "DO")
            print("\(DataManager.dataManagerCopy0) - DO")
        case "DECIDE":
            DataManager.dataManagerCopy1.append(todoData)
            DataManager.dataManager = [DataManager.dataManagerCopy0, DataManager.dataManagerCopy1, DataManager.dataManagerCopy2, DataManager.dataManagerCopy3]
            DataManager.saveToUserDefaults(section: "DECIDE")
            print("\(DataManager.dataManagerCopy1) - DECIDE")
        case "DELEGATE":
            DataManager.dataManagerCopy2.append(todoData)
            DataManager.dataManager = [DataManager.dataManagerCopy0, DataManager.dataManagerCopy1, DataManager.dataManagerCopy2, DataManager.dataManagerCopy3]
            DataManager.saveToUserDefaults(section: "DELEGATE")
            print("\(DataManager.dataManagerCopy2) - DELEGATE")
        case "DELETE":
            DataManager.dataManagerCopy3.append(todoData)
            DataManager.dataManager = [DataManager.dataManagerCopy0, DataManager.dataManagerCopy1, DataManager.dataManagerCopy2, DataManager.dataManagerCopy3]
            DataManager.saveToUserDefaults(section: "DELETE")
            print("\(DataManager.dataManagerCopy3) - DELETE")
        default:
            return
        }
        
        navigationController?.popViewController(animated: true)
    }

    // 날짜 형식 변환 ✅
    func dateFormatter() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. M. d a hh:mm:ss"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: Date())
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
