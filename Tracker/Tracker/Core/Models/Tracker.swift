//
//  Tracker.swift
//  Tracker
//
//  Created by Антон Шишкин on 08.04.24.
//

import Foundation

struct Tracker: Identifiable {
    let id: UUID
    let name: String
    let color: CategoryColor
    let icon: Character
    let schedule: Set<WeekDay.WeekDayName>
}
