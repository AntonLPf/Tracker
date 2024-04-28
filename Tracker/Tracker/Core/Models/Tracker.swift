//
//  Tracker.swift
//  Tracker
//
//  Created by Антон Шишкин on 08.04.24.
//

import Foundation

struct Tracker: Identifiable {
    let id: UUID
    var name: String
    var color: CategoryColor
    var icon: Character
    var schedule: Set<WeekDay.WeekDayName>
}
