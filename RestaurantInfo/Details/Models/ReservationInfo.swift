//
//  ReservationInfo.swift
//  RestaurantReservation
//
//  Created by VAITSIKHOUSKAYA on 06/10/2021.
//

import Foundation

struct ReservationInfo {
    var iconImage: String
    var text: String
    var widget: Widget
}

enum Widget: Int {
    case calendar
    case clock
    case peopleCount
    case pensonInfo
}
