//
//  ReservationTimeDataSource&Delegate.swift
//  RestaurantReservation
//
//  Created by VAITSIKHOUSKAYA on 20/11/2021.
//

import UIKit

class ReservationTimeDataSourceDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var sections: [ReservationTimeSection]
    var allTimes: [ReservationTime] {
        sections.flatMap({ section in section.times })
    }
    
    init(sections: [ReservationTimeSection]) {
        self.sections = sections
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].times.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReservationTimeCell", for: indexPath) as! ReservationTimeCell
        cell.setUp(time: sections[indexPath.section].times[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flow = collectionViewLayout as! UICollectionViewFlowLayout
        let numberOfColumns: CGFloat = 5
        let width = (collectionView.frame.width - (numberOfColumns - 1) * flow.minimumInteritemSpacing - flow.sectionInset.left - flow.sectionInset.right) / numberOfColumns
        return CGSize(width: width, height: 30)
    }
    /*
     1 + стало выбрано 1 время (было 0)
     2 + стало выбрано 2 времени (было 1) - все между ними тоже должны стать выбраны
     3 - стало выбрано 1 время (было 2) - все остальные (кроме выбранного), должны перестать быть выбраными
     4 + стало выбрано 0 времени (было 1)
     5 + стало выбрано 2 времени (было 2) - все между минимум из 3 и максимум из 3 станут выбранными
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let countOfChosenTimes = allTimes.filter({ time in time.isChosen }).count
        if countOfChosenTimes == 0 {
            sections[indexPath.section].times[indexPath.row].isChosen = true
            collectionView.reloadItems(at: [indexPath])
        } else if countOfChosenTimes == 1 && sections[indexPath.section].times[indexPath.row].isChosen {
            sections[indexPath.section].times[indexPath.row].isChosen = false
            collectionView.reloadItems(at: [indexPath])
        } else if countOfChosenTimes >= 1 && !sections[indexPath.section].times[indexPath.row].isChosen {
            sections[indexPath.section].times[indexPath.row].isChosen = true
            collectionView.reloadItems(at: [indexPath])
            let firstSectionIndexThatContainsChosenTime = sections
                .firstIndex(where: { section in
                    section.times.contains(where: { time in time.isChosen })
                })!
            let lastSectionIndexThatContainsChosenTime = sections
                .lastIndex(where: { section in
                    section.times.contains(where: { time in time.isChosen })
                })!
            let chosenCellIndexInFirstSection = sections[firstSectionIndexThatContainsChosenTime].times
                .firstIndex(where: { time in time.isChosen })!
            let chosenCellIndexInLastSection = sections[lastSectionIndexThatContainsChosenTime].times
                .lastIndex(where: { time in time.isChosen })!

            if firstSectionIndexThatContainsChosenTime != lastSectionIndexThatContainsChosenTime {

                let lastCellIndexInFirstSection = sections[firstSectionIndexThatContainsChosenTime].times.count
                for i in chosenCellIndexInFirstSection..<lastCellIndexInFirstSection {
                    sections[firstSectionIndexThatContainsChosenTime].times[i].isChosen = true
                    collectionView.reloadItems(at: [IndexPath(item: i, section: firstSectionIndexThatContainsChosenTime)])
                }
                
                for i in 0..<chosenCellIndexInLastSection {
                    sections[lastSectionIndexThatContainsChosenTime].times[i].isChosen = true
                    collectionView.reloadItems(at: [IndexPath(item: i, section: lastSectionIndexThatContainsChosenTime)])
                }
                
                for sectionIndex in firstSectionIndexThatContainsChosenTime+1..<lastSectionIndexThatContainsChosenTime {
                    for timeIndex in sections[sectionIndex].times.indices {
                        sections[sectionIndex].times[timeIndex].isChosen = true
                        collectionView.reloadItems(at: [IndexPath(item: timeIndex, section: sectionIndex)])
                    }
                }
            } else {
                for i in min(chosenCellIndexInFirstSection, chosenCellIndexInLastSection)...max(chosenCellIndexInFirstSection, chosenCellIndexInLastSection) {
                    sections[firstSectionIndexThatContainsChosenTime].times[i].isChosen = true
                    collectionView.reloadItems(at: [IndexPath(item: i, section: firstSectionIndexThatContainsChosenTime)])
                }
            }
        } else if countOfChosenTimes >= 2 && sections[indexPath.section].times[indexPath.row].isChosen {
            for i in indexPath.row..<sections[indexPath.section].times.count {
                sections[indexPath.section].times[i].isChosen = false
                collectionView.reloadItems(at: [IndexPath(item: i, section: indexPath.section)])
            }
            for sectionIndex in sections.indices {
                if indexPath.section < sectionIndex {
                    for i in sections[sectionIndex].times.indices {
                        sections[sectionIndex].times[i].isChosen = false
                        collectionView.reloadItems(at: [IndexPath(item: i, section: sectionIndex)])
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ReservationTimeHeader", for: indexPath) as! ReservationTimeHeader
        sectionHeader.sectionHeader.text = sections[indexPath.section].title
        return sectionHeader
    }
    
    private func makeIsChosenEqualsTrue(_ collectionView: UICollectionView, clickedIndexPath indexPath: IndexPath) {
        let firstChosenIndex = sections[indexPath.section].times.firstIndex(where: { time in time.isChosen }) ?? 0
        for i in min(firstChosenIndex, indexPath.row)...max(firstChosenIndex, indexPath.row) {
            sections[indexPath.section].times[i].isChosen = true
            collectionView.reloadItems(at: [IndexPath(item: i, section: indexPath.section)])
        }
    }
}
