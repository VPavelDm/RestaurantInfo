//
//  WidgetsDataSourceDelegate.swift
//  RestaurantReservation
//
//  Created by VAITSIKHOUSKAYA on 20/11/2021.
//

import UIKit

protocol WidgetDelegate: AnyObject {
    func widgetIsChanged()
    func layoutViewIfNeeded()
    
    var leadingConstraints: [NSLayoutConstraint]! { get }
    var screenWidth: CGFloat { get }
}

class WidgetsDataSourceDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var reservationInfo: [ReservationInfo] = [
        ReservationInfo(iconImage: "calendar", text: "Calendar", widget: .calendar),
        ReservationInfo(iconImage: "clock", text: "Clock", widget: .clock),
        ReservationInfo(iconImage: "person.3", text: "3 Person", widget: .peopleCount),
        ReservationInfo(iconImage: "person.3", text: "3 Person", widget: .pensonInfo)
    ]
    weak var delegate: WidgetDelegate?
    var visibleWidget: Widget = .calendar {
        didSet {
            delegate?.widgetIsChanged()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        reservationInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsHeaderCell", for: indexPath) as! DetailsHeaderCell
        cell.setUp(isLastItem: indexPath.row == reservationInfo.count - 1, info: reservationInfo[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / (CGFloat(reservationInfo.count) - 0.5)
        let height = collectionView.frame.size.height
        return CGSize(width: width, height: height)
    }
    
    func showNextWidget(collectionView: UICollectionView) {
        let visibleWidgetIndex = reservationInfo.firstIndex(where: { $0.widget == visibleWidget })!
        if visibleWidgetIndex < reservationInfo.count - 1 {
            let indexPath = IndexPath(item: visibleWidgetIndex + 1, section: 0)
            self.collectionView(collectionView, didSelectItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = delegate else { return }
        let visibleWidgetIndex = reservationInfo.firstIndex(where: { info in info.widget == visibleWidget })!
        if visibleWidgetIndex < indexPath.row {
            delegate.leadingConstraints[indexPath.row].constant = delegate.screenWidth
            delegate.layoutViewIfNeeded()
            delegate.leadingConstraints[visibleWidgetIndex].constant = -delegate.screenWidth
        } else {
            delegate.leadingConstraints[indexPath.row].constant = -delegate.screenWidth
            delegate.layoutViewIfNeeded()
            delegate.leadingConstraints[visibleWidgetIndex].constant = delegate.screenWidth
        }
        delegate.leadingConstraints[indexPath.row].constant = 0
        visibleWidget = reservationInfo[indexPath.row].widget
        UIView.animate(withDuration: 1) {
            self.delegate?.layoutViewIfNeeded()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
