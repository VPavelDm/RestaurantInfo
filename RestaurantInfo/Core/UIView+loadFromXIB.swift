//
//  UIView+loadFromXIB.swift
//  RestaurantReservation
//
//  Created by VAITSIKHOUSKAYA on 09/01/2022.
//

import UIKit

extension UIView {
    func loadViewFromXIB() {
        let xib = UINib(nibName: String(describing: Self.self), bundle: nil)
        let views = xib.instantiate(withOwner: self, options: nil)
        let view = views.first as! UIView
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
