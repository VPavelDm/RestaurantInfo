//
//  UIResponder+viewController.swift
//  RestaurantReservation
//
//  Created by VAITSIKHOUSKAYA on 10/01/2022.
//

import UIKit

extension UIResponder {
    var viewController: UIViewController? {
        if self is UIViewController {
            return self as? UIViewController
        } else if next != nil {
            return self.next?.viewController
        } else {
            return nil
        }
    }
}
