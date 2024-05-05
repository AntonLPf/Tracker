//
//  TrackerData.swift
//  Tracker
//
//  Created by Антон Шишкин on 05.05.24.
//

import Foundation

struct TrackerData {
    let name: String
    
    let categoryName: String
    
    let color: CategoryColor
    
    let icon: Character
    
    let schedule: Set<WeekDay.WeekDayName>
}
