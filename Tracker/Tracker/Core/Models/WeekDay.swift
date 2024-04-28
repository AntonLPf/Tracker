//
//  WeekDay.swift
//  Tracker
//
//  Created by Антон Шишкин on 21.04.24.
//

import Foundation

struct WeekDay: Hashable {
    let name: WeekDayName
    var isChosen: Bool
    
    enum WeekDayName {
        case monday
        case tuesday
        case wendsday
        case thursday
        case friday
        case saturday
        case sunday
        
        var shortDescription: String {
            switch self {
            case .monday:
                return "Пн"
            case .tuesday:
                return "Вт"
            case .wendsday:
                return "Ср"
            case .thursday:
                return "Чт"
            case .friday:
                return "Пт"
            case .saturday:
                return "Сб"
            case .sunday:
                return "Вс"
            }
        }
        
        var fullDescription: String {
            switch self {
            case .monday:
                return "Понедельник"
            case .tuesday:
                return "Вторник"
            case .wendsday:
                return "Среда"
            case .thursday:
                return "Четверг"
            case .friday:
                return "Пятница"
            case .saturday:
                return "Суббота"
            case .sunday:
                return "Воскресенье"
            }
        }
    }
}
