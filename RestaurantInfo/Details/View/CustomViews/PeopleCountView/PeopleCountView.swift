//
//  PeopleCountView.swift
//  RestaurantReservation
//
//  Created by VAITSIKHOUSKAYA on 15/01/2022.
//

import UIKit

class PeopleCountView: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var childrenCountLabel: UILabel!
    @IBOutlet weak var adultsCountLabel: UILabel!
    
    // MARK: - Properties
    var childrenCount: Int {
        Int(childrenCountLabel.text!)!
    }
    var adultsCount: Int {
        Int(adultsCountLabel.text!)!
    }

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loadViewFromXIB()
    }
    
    // MARK: - Actions
    @IBAction func minusChildIsPressed(_ sender: Any) {
        if childrenCount > 0 {
            childrenCountLabel.text = "\(childrenCount - 1)"
        }
    }
    @IBAction func plusChildIsPressed(_ sender: Any) {
        childrenCountLabel.text = "\(childrenCount + 1)"
    }
    @IBAction func minusAdultIsPressed(_ sender: Any) {
        if adultsCount > 0 {
            adultsCountLabel.text = "\(adultsCount - 1)"
        }
    }
    @IBAction func plusAdultsIsPressed(_ sender: Any) {
        adultsCountLabel.text = "\(adultsCount + 1)"
    }

}
