//
//  CalendarView.swift
//  RestaurantReservation
//
//  Created by VAITSIKHOUSKAYA on 15/01/2022.
//

import UIKit

class CalendarView: UIView {
    
    @IBOutlet weak var calendar: UIDatePicker!
    @IBOutlet weak var nextButton: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loadViewFromXIB()
        calendar.minimumDate = Date()
        calendar.maximumDate = Date(timeIntervalSinceNow: 60*60*24*14)
        calendar.date = Date(timeIntervalSinceNow: 60*60*24)
    }
}


