//
//  TrackerData.swift
//  Tracker
//
//  Created by Антон Шишкин on 28.04.24.
//

import Foundation

protocol TrackerData {
    var name: String { get }
    var categoryName: String { get }
    var color: CategoryColor { get }
    var icon: Character { get }
    
    var schedule: Set<WeekDay.WeekDayName> { get }
}
