//
//  TrackersStorage.swift
//  Tracker
//
//  Created by Антон Шишкин on 28.04.24.
//

import Foundation

protocol TrackersStorage {
    func getTrackers() -> [TrackerCategory]
    func addNewTracker(data: TrackerData) throws
    func updateTracker(id: UUID, with data: TrackerData) throws
    func deleteTracker(id: UUID) throws
}
