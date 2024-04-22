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
    
    var delegate: ScheduleVCDelegate? = nil
    
    private let doneButton = ActionButton(title: "Готово")
    
    private var schedule: [WeekDay]
    
    private var switchStates: [Bool] = Array(repeating: false, count: 7)
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
    override func viewDidLoad() {
        view.backgroundColor = .white
        setLogo(to: "Расписание")
        addAndConstrainBottomBlock(doneButton)
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        doneButton.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
        
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
        
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
}

#Preview {
    ScheduleVC(schedule: [
        WeekDay(name: .monday, isChosen: false),
        WeekDay(name: .tuesday, isChosen: false),
        WeekDay(name: .wendsday, isChosen: false),
        WeekDay(name: .thursday, isChosen: false),
        WeekDay(name: .friday, isChosen: false),
        WeekDay(name: .saturday, isChosen: false),
        WeekDay(name: .sunday, isChosen: false)
    ])
}
