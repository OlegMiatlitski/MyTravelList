import UIKit

//extension UITextField {
//    func setInputView(text: String, target: Any, selector: Selector) {
//        let arr = [1,2,3,4,5,6,67,7,8,9,0]
//    let screenWidth = UIScreen.main.bounds.width
//        let picker = UIPickerView(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 220))
//        
//        func numberOfComponents(in pickerView: UIPickerView) -> Int {
//            return 1
//        }
//        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//            return arr.count
//        }
//        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//            return String(arr[row])
//        }
//        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//            countryTextField.text = String(arr[row])
//        }
//        
//            picker.sizeToFit()
//        
//        
//        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44))
//        
//        let spacing = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        
//        let cancel = UIBarButtonItem(title: "Cansel", style: .plain, target: nil, action: #selector(tapCancel))
//
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
//        
//        toolBar.setItems([cancel, spacing, doneButton], animated: false)
//        inputAccessoryView = toolBar
//        
//}
//    
//    @objc func tapCancel() {
//        resignFirstResponder()
//    }
//}
//
