//
//  TrackersNavViewController.swift
//  Tracker
//
//  Created by Антон Шишкин on 06.04.24.
//

import UIKit

protocol TrackersNavViewControllerDelegate: AnyObject {
    func didAddTracker()
    func didDeleteAllTrackers()
}

class TrackersNavViewController: UINavigationController {
    
    weak var trackersVCdelegate: TrackersNavViewControllerDelegate? = nil
        
    override func viewDidLoad() {
        let trackersVC = TrackersViewController()
        trackersVC.delegate = self
        viewControllers = [trackersVC]
    }
}

extension TrackersNavViewController: TrackersViewControllerDelegate {
    func didAddTracker() {
        trackersVCdelegate?.didAddTracker()
    }
    
    func didDeleteAllTrackers() {
        trackersVCdelegate?.didDeleteAllTrackers()
    }
}
