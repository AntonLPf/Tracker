//
//  InMemoryStorage.swift
//  Tracker
//
//  Created by Антон Шишкин on 28.04.24.
//

import Foundation

class InMemoryStorage: TrackersStorage {
    
    private var inMemoryTrackers: [TrackerCategory] = [
        TrackerCategory(name: "Домашний уют", trackers: [
            Tracker(id: UUID(), name: "Поливать растения", color: .color5, icon: "❤️", schedule: [.tuesday, .wendsday, .thursday, .friday, .saturday, .sunday]),
        ]),
        TrackerCategory(name: "Радостные мелочи", trackers: [
            Tracker(id: UUID(), name: "Кошка заслонила камеру на созвоне", color: .color2, icon: "😻", schedule: []),
            Tracker(id: UUID(), name: "Бабушка прислала открытку в вотсапе", color: .color1, icon: "🌺", schedule: [])
        ]),
    ]
    
    private var inMemoryRecords: Set<TrackerRecord> = []
    
    func getTrackers(weekDayName: WeekDay.WeekDayName?) -> [TrackerCategory] {
        guard let weekDayName = weekDayName else { return inMemoryTrackers }
        
        var result: [TrackerCategory] = []
        
        for trackerCategory in inMemoryTrackers {
            var filteredTrackers: [Tracker] = []
            
            for tracker in trackerCategory.trackers {
                if tracker.schedule.isEmpty || tracker.schedule.contains(weekDayName) {
                    filteredTrackers.append(tracker)
                }
            }
            
            var category = trackerCategory
            category.trackers = filteredTrackers
            result.append(category)
        }
        
        return result
    }
    
    func addNewTracker(data: TrackerData) throws {
        guard
            !data.name.isEmpty,
            !data.categoryName.isEmpty
        else { throw StorageError.invalidTrackerData }
        
        let newTracker = Tracker(id: UUID(),
                                 name: data.name,
                                 color: data.color,
                                 icon: data.icon,
                                 schedule: data.schedule)
        
        let categoryName = data.categoryName
        
        for categoryNameIndex in inMemoryTrackers.indices {
            if inMemoryTrackers.first?.name == categoryName {
                inMemoryTrackers[categoryNameIndex].trackers.append(newTracker)
                debugPrint("Added tracker: \(newTracker)")
                return
            }
        }
        createNewCategory(name:  categoryName)
        try add(tracker: newTracker, toCategory: categoryName)
    }
    
    func updateTracker(id: UUID, with data: TrackerData) throws {
        guard
            !data.name.isEmpty,
            !data.categoryName.isEmpty
        else { throw StorageError.invalidTrackerData }
        
        for trackerCategoryIndex in inMemoryTrackers.indices {
            for trackerIndex in inMemoryTrackers[trackerCategoryIndex].trackers.indices {
                let currentTrackerId = inMemoryTrackers[trackerCategoryIndex].trackers[trackerIndex].id
                guard currentTrackerId == id else { continue }
                
                if data.categoryName == inMemoryTrackers[trackerCategoryIndex].name {
                    inMemoryTrackers[trackerCategoryIndex].trackers[trackerIndex].name = data.name
                    inMemoryTrackers[trackerCategoryIndex].trackers[trackerIndex].color = data.color
                    inMemoryTrackers[trackerCategoryIndex].trackers[trackerIndex].icon = data.icon
                    return
                } else {
                    var trackerToMove = inMemoryTrackers[trackerCategoryIndex].trackers.remove(at: trackerIndex)
                    trackerToMove.name = data.name
                    trackerToMove.color = data.color
                    trackerToMove.icon = data.icon
                    
                    createNewCategory(name: data.categoryName)
                    try add(tracker: trackerToMove, toCategory: data.categoryName)
                    return
                }
            }
            throw StorageError.trackerNotFound
        }
    }
    
    func deleteTracker(id: UUID) throws {
        for trackerCategoryIndex in inMemoryTrackers.indices {
            for trackerIndex in inMemoryTrackers[trackerCategoryIndex].trackers.indices {
                let currentTrackerId = inMemoryTrackers[trackerCategoryIndex].trackers[trackerIndex].id
                guard currentTrackerId == id else { continue }
                    
                inMemoryTrackers[trackerCategoryIndex].trackers.remove(at: trackerIndex)
            }
            throw StorageError.trackerNotFound
        }
    }
    
    func getRecords(date: Date?) -> Set<TrackerRecord> {
        var result: Set<TrackerRecord> = inMemoryRecords
        
        if let date {
            return result.filter { $0.date == date }
        }
        
        return result
    }
    
    func addRecord(_ record: TrackerRecord) {
        inMemoryRecords.insert(record)
    }
    
    func removeRecord(_ record: TrackerRecord) {
        if let trackerIndex = (inMemoryRecords.firstIndex { $0.trackerId == record.trackerId }) {
            inMemoryRecords.remove(at: trackerIndex)
        }
    }
    
    private func createNewCategory(name: String) {
        let newCategory = TrackerCategory(name: name, trackers: [])
        inMemoryTrackers.append(newCategory)
    }
    
    private func add(tracker: Tracker, toCategory categoryName: String) throws {
        for trackerCategoryIndex in inMemoryTrackers.indices {
            if inMemoryTrackers[trackerCategoryIndex].name == categoryName {
                inMemoryTrackers[trackerCategoryIndex].trackers.append(tracker)
                debugPrint("Added tracker: \(tracker)")
                return
            }
        }
        throw StorageError.categoryNotFound
    }
        
}
