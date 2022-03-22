//
//  UITextField+toolbar.swift
//  RestaurantReservation
//
//  Created by VAITSIKHOUSKAYA on 16/01/2022.
//

import UIKit

extension UITextField {
    func addDoneButtonInToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneIsPressed))
        toolBar.items = [flexBarButton, done]
        
        inputAccessoryView = toolBar
    }
    
    @objc func doneIsPressed() {
        resignFirstResponder()
    }
}
