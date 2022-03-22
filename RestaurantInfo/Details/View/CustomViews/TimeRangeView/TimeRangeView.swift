//
//  TimeRangeView.swift
//  RestaurantReservation
//
//  Created by VAITSIKHOUSKAYA on 15/01/2022.
//

import UIKit

class TimeRangeView: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var timeCollectionView: UICollectionView!
    
    // MARK: - Properties
    var sections: [ReservationTimeSection] = [
        ReservationTimeSection(title: "Lunch",
                               times: (8..<14)
                                .flatMap({ time in ["\(time):00", "\(time):30"] })
                                .map({ time in ReservationTime(time: time, isChosen: false) })),
        ReservationTimeSection(title: "Dinner",
                               times: (14...18)
                                .flatMap({ time in ["\(time):00", "\(time):30"] })
                                .map({ time in ReservationTime(time: time, isChosen: false) }))
    ]
    lazy var timeDataSourceDelegate = ReservationTimeDataSourceDelegate(sections: sections)

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loadViewFromXIB()
        let cellXib = UINib(nibName: "ReservationTimeCell", bundle: nil)
        let headerXib = UINib(nibName: "ReservationTimeHeader", bundle: nil)
        timeCollectionView.register(cellXib, forCellWithReuseIdentifier: "ReservationTimeCell")
        timeCollectionView.register(headerXib, forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: "ReservationTimeHeader")
        timeCollectionView.delegate = timeDataSourceDelegate
        timeCollectionView.dataSource = timeDataSourceDelegate
    }
}
