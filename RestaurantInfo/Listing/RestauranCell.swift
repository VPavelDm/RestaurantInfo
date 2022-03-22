//
//  RestaurantInfo.swift
//  RestaurantReservation
//
//  Created by VAITSIKHOUSKAYA on 23/08/2021.
//

import UIKit

class RestaurantCell: UITableViewCell {
    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantAdress: UILabel!
    
    func setUp(info: RestaurantInfo) {
        restaurantName.text = info.name
        restaurantAdress.text = info.adress
        restaurantImage.layer.cornerRadius = 8
    }
    
}
