//
//  InMemoryStorage.swift
//  Tracker
//
//  Created by Антон Шишкин on 28.04.24.
//

import Foundation

class InMemoryStorage: TrackersStorage {
    
    init(debugMode: Bool = false) {
        if debugMode {
            self.inMemoryTrackers = [
                TrackerCategory(name: "Домашний уют", trackers: [
                    Tracker(id: UUID(), name: "Поливать растения", color: .color5, icon: "❤️", schedule: [.tuesday, .wendsday, .thursday, .friday, .saturday, .sunday]),
                ]),
                TrackerCategory(name: "Радостные мелочи", trackers: [
                    Tracker(id: UUID(), name: "Кошка заслонила камеру на созвоне", color: .color2, icon: "😻", schedule: []),
                    Tracker(id: UUID(), name: "Бабушка прислала открытку в вотсапе", color: .color1, icon: "🌺", schedule: [])
                ]),
            ]
        }
    }
    
    private var inMemoryTrackers: [TrackerCategory] = []
    
    private var inMemoryRecords: Set<TrackerRecord> = []
    
    func getTrackers(date: Date) -> [TrackerCategory] {
        var result: [TrackerCategory] = []
        
        let weekDayName = getWeekDay(from: date)
        
        for trackerCategory in inMemoryTrackers {
            var filteredTrackers: [Tracker] = []
            
            for tracker in trackerCategory.trackers {
                if isTrackerIrregular(tracker: tracker) {
                    let records = getTrackerRecords(trackerId: tracker.id)
                    if let record = records.first {
                        if record.date == date {
                            filteredTrackers.append(tracker)
                        }
                    } else {
                        filteredTrackers.append(tracker)
                    }
                } else {
                    if tracker.schedule.contains(weekDayName) {
                        filteredTrackers.append(tracker)
                    }
                }
            }
            
            let categoryToUpdateName = trackerCategory.name
            let newCategory = TrackerCategory(name: categoryToUpdateName,
                                              trackers: filteredTrackers)
            result.append(newCategory)
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
        
        do {
            try add(tracker: newTracker, toCategory: categoryName)
        } catch {
            createNewCategory(name: categoryName)
            try add(tracker: newTracker, toCategory: categoryName)
        }
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
                
                let oldCategory = inMemoryTrackers[trackerCategoryIndex]
                
                if data.categoryName == oldCategory.name {
                    let oldTracker = oldCategory.trackers[trackerIndex]
                    let newTracker = Tracker(id: oldTracker.id,
                                             name: data.name,
                                             color: data.color,
                                             icon: data.icon,
                                             schedule: data.schedule)
                    
                    let oldTrackers = oldCategory.trackers
                    
                    var newTrackers = oldTrackers
                    newTrackers[trackerIndex] = newTracker
                    let newCategory = TrackerCategory(name: oldCategory.name, trackers: newTrackers)
                    
                    inMemoryTrackers[trackerCategoryIndex] = newCategory
                    return
                } else {
                    var newTrackersWithoutMovedTracker = oldCategory.trackers
                    newTrackersWithoutMovedTracker.remove(at: trackerIndex)
                    
                    let newCategory = TrackerCategory(name: oldCategory.name, trackers: newTrackersWithoutMovedTracker)
                    inMemoryTrackers[trackerCategoryIndex] = newCategory
                    
                    let trackerToMove = oldCategory.trackers[trackerIndex]
                    
                    let newTracker = Tracker(id: trackerToMove.id,
                                             name: data.name,
                                             color: data.color,
                                             icon: data.icon,
                                             schedule: data.schedule)
                    createNewCategory(name: data.categoryName)
                    try add(tracker: newTracker, toCategory: data.categoryName)
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
                
                var newTrackers = inMemoryTrackers[trackerCategoryIndex].trackers
                newTrackers.remove(at: trackerIndex)
                
                let oldCategory = inMemoryTrackers[trackerCategoryIndex]
                let newCategory = TrackerCategory(name: oldCategory.name, trackers: newTrackers)
                
                inMemoryTrackers[trackerCategoryIndex] = newCategory
            }
            throw StorageError.trackerNotFound
        }
    }
    
    func getRecords(date: Date?) -> Set<TrackerRecord> {
        let result: Set<TrackerRecord> = inMemoryRecords
        
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
        for categoryNameIndex in inMemoryTrackers.indices {
            if inMemoryTrackers.first?.name == categoryName {
                let categoryToUpdate = inMemoryTrackers[categoryNameIndex]
                let trackers = categoryToUpdate.trackers
                
                var newTrackers = trackers
                newTrackers.append(tracker)
                
                let newCategory = TrackerCategory(name: categoryToUpdate.name,
                                                  trackers: newTrackers)
                
                inMemoryTrackers[categoryNameIndex] = newCategory
                debugPrint("Added tracker: \(tracker)")
                return
            }
        }
        throw StorageError.categoryNotFound
    }
    
    private func getWeekDay(from date: Date) -> WeekDay.WeekDayName {
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        let weekDayIndex = calendar.component(.weekday, from: date)
        let adjustedWeekDayIndex = (weekDayIndex + 5) % 7
        let weekDay = WeekDay.WeekDayName(rawValue: adjustedWeekDayIndex)
        return weekDay ?? .monday
    }
    
    private func isTrackerIrregular(tracker: Tracker) -> Bool {
        tracker.schedule.isEmpty
    }
    
    private func getTrackerRecords(trackerId: UUID) -> Set<TrackerRecord> {
        let records = getRecords(date: nil)
        let filteredRecords = records.filter({ $0.trackerId == trackerId })
        return Set(filteredRecords)
    }
    
}
