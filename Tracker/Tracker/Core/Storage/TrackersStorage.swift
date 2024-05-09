//
//  TrackersStorage.swift
//  Tracker
//
//  Created by Антон Шишкин on 28.04.24.
//

import Foundation

protocol TrackersStorage {
    func getTrackers(weekDayName: WeekDay.WeekDayName?) -> [TrackerCategory]
    func addNewTracker(data: TrackerData) throws
    func updateTracker(id: UUID, with data: TrackerData) throws
    func deleteTracker(id: UUID) throws
    
    func getRecords(date: Date?) -> Set<TrackerRecord>
    func addRecord(_ record: TrackerRecord)
    func removeRecord(_ record: TrackerRecord)
    
}
