//
//  StorageError.swift
//  Tracker
//
//  Created by Антон Шишкин on 28.04.24.
//

import Foundation

enum StorageError: Error {
    case invalidTrackerData
    case trackerNotFound
    case categoryNotFound
}
