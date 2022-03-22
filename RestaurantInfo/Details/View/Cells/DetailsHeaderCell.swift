//
//  DetailsHeaderCell.swift
//  RestaurantReservation
//
//  Created by VAITSIKHOUSKAYA on 29/09/2021.
//

import UIKit

class DetailsHeaderCell: UICollectionViewCell {
    
    @IBOutlet weak var separatorWidth: NSLayoutConstraint!
    @IBOutlet weak var icone: UIImageView!
    @IBOutlet weak var text: UILabel!
    
    func setUp(isLastItem: Bool, info: ReservationInfo) {
        separatorWidth.constant = isLastItem ? 0 : 1
        icone.image = UIImage(systemName: info.iconImage)
    }
}
