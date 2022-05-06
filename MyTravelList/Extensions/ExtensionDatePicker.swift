import UIKit

extension UITextField {
    func setInputView(target: Any, selector: Selector) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 220))
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.sizeToFit()
        
        inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44))
        let spacing = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cansel", style: .plain, target: nil, action: #selector(tapCancel))
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.backgroundColor = .systemGray6
        doneButton.tintColor = .black
        cancel.tintColor = .black
        toolBar.setItems([cancel, spacing, doneButton], animated: false)
        inputAccessoryView = toolBar
    }
    
    @objc func tapCancel() {
        resignFirstResponder()
    }
}

