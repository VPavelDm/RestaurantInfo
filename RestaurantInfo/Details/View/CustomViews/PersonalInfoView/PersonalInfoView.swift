//
//  PersonalInfoView.swift
//  RestaurantReservation
//
//  Created by VAITSIKHOUSKAYA on 16/01/2022.
//

import UIKit

class PersonalInfoView: UIView, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    var activeTextField: UITextField {
        if email.isFirstResponder {
            return email
        } else if firstName.isFirstResponder {
            return firstName
        } else if lastName.isFirstResponder {
            return lastName
        } else {
            return phoneNumber
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loadViewFromXIB()
        email.delegate = self
        firstName.delegate = self
        lastName.delegate = self
        phoneNumber.delegate = self
        phoneNumber.addDoneButtonInToolbar()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if email.isFirstResponder {
            firstName.becomeFirstResponder()
        } else if firstName.isFirstResponder {
            lastName.becomeFirstResponder()
        } else if lastName.isFirstResponder {
            phoneNumber.becomeFirstResponder()
        } else {
            phoneNumber.resignFirstResponder()
        }
        return false
    }
    
}
