//
//  ScheduleVC.swift
//  Tracker
//
//  Created by Антон Шишкин on 21.04.24.
//

import UIKit

protocol ScheduleVCDelegate: AnyObject {
    func didDoneButtonPressed(schedule: [WeekDay])
}

class ScheduleVC: UIViewController {
    
    weak var delegate: ScheduleVCDelegate? = nil
    
    private lazy var doneButton: UIButton = {
        ActionButton(title: "Готово", action: #selector(didTapDoneButton), target: self)
    }()
    
    private var schedule: [WeekDay]
    
    private var switchStates: [Bool] = Array(repeating: false, count: 7)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
        
    override func viewDidLoad() {
        view.backgroundColor = .white
        setLogo(to: "Расписание")
        addAndConstrainBottomBlock(doneButton)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.logoHeight),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -Constant.paddingValue)
        ])
    }
    
    init(schedule: [WeekDay]) {
        self.schedule = schedule
        for weekDayIndex in schedule.indices {
            switchStates[weekDayIndex] = schedule[weekDayIndex].isChosen
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }
    
    @objc func didTapDoneButton() {
        for weekdayIndex in schedule.indices {
            schedule[weekdayIndex].isChosen = switchStates[weekdayIndex]
        }
        delegate?.didDoneButtonPressed(schedule: schedule)
    }
}

extension ScheduleVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        schedule.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = schedule[indexPath.row].name.fullDescription
        cell.backgroundColor = .ypBackgroundGray
        
        let toggle = UISwitch()
        toggle.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        toggle.isOn = schedule[indexPath.row].isChosen
        toggle.onTintColor = UIColor(resource: .ypBlue)
        toggle.translatesAutoresizingMaskIntoConstraints = false
        cell.addSubview(toggle)
        
        NSLayoutConstraint.activate([
            cell.heightAnchor.constraint(equalToConstant: Constant.cellHeihgt),
            toggle.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            toggle.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -Constant.paddingValue)
        ])
        return cell
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        guard let cell = sender.superview as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        switchStates[indexPath.row] = sender.isOn
    }
}

extension ScheduleVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
}
