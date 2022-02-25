//
//  UITextFieldWithPickerView.swift
//  Camnosa
//
//  Created by Jorge Zamarrón on 08/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation
import UIKit

class UITextFieldWithPickerView: UITextField {
    
    var pickViewOptions: Array<String> = []
    fileprivate let pickerView = UIPickerView()
    
    required init(coder aDecoder: (NSCoder!)) {
        super.init(coder: aDecoder)!
        
        pickerView.delegate = self
        
        //pickerView.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1.0);
        //pickerView.tintColor = UIColor.whiteColor()
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Ok", style: UIBarButtonItemStyle.plain , target: self, action: #selector(UITextFieldWithPickerView.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.barTintColor = UIColor(red: 255/255, green: 212/255, blue: 99/255, alpha: 1.0);
        toolBar.tintColor = UIColor.white
        
        let item : UITextInputAssistantItem = self.inputAssistantItem
        item.leadingBarButtonGroups = []
        item.trailingBarButtonGroups = []
        
        self.inputView = pickerView
        self.inputAccessoryView = toolBar
        if self.pickViewOptions.count > 0 {
            self.text = pickViewOptions[0]
        }
    }
    
    func defaultSelectedRow(_ row: Int) {
        self.text = pickViewOptions[row]
    }
    
    func selectedRow() -> Int {
        return self.pickerView.selectedRow(inComponent: 0)
    }
    
    func selectRow(_ row: Int) {
        self.pickerView.selectRow(row, inComponent: 0, animated: true)
        self.pickerView(self.pickerView, didSelectRow: row, inComponent: 0)
    }
}

extension UITextFieldWithPickerView : UIPickerViewDataSource, UIPickerViewDelegate {
    func donePicker() {
        self.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickViewOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickViewOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.text = pickViewOptions[row]
    }
}

