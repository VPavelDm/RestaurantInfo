//
//  ReservationTimeCell.swift
//  RestaurantReservation
//
//  Created by VAITSIKHOUSKAYA on 19/11/2021.
//

import UIKit

class ReservationTimeCell: UICollectionViewCell {
    @IBOutlet weak var backgroundViewTime: UIView!
    @IBOutlet weak var time: UILabel!
    
    func setUp(time reservationTime: ReservationTime) {
        backgroundViewTime.backgroundColor = reservationTime.isChosen ? UIColor.blue : .systemGray6
        time.textColor = reservationTime.isChosen ? .white : .black
        time.text = reservationTime.time
        backgroundViewTime.layer.cornerRadius = 8
    }
}
