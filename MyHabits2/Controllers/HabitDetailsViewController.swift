//
//  HabitDetailsViewController.swift
//  MyHabits2
//
//  Created by Oleg Popov on 25.09.2022.
//

import Foundation
import UIKit

class HabitDetailsViewController: UIViewController {
  
    var index : Int = 0
    
    private lazy var table : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "defaultTableCellIdentifier")
        table.toAutoLayout()
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupView()
        view.addSubview(table)
        addConstraints()

    }
    
    func setupView(){
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false //отключаю большой заголовок
        navigationItem.title = HabitsStore.shared.habits[index].name
        
        
        //MARK: создаю правую кнопку нав бара
        let chengeButton = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(goToHabitViewController))
        navigationItem.rightBarButtonItems = [chengeButton]
        navigationItem.rightBarButtonItem?.tintColor = Colors.purpleColor
        

    }
    
    @objc func goToHabitViewController(){
        let navController = UINavigationController(rootViewController: HabitViewController())
        navController.modalPresentationStyle = .fullScreen
        placeOfCall = "fromDetailsViewController" //метка откуда вызывем
        self.present(navController, animated:true, completion: nil)
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([

            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leftAnchor.constraint(equalTo: view.leftAnchor),
            table.rightAnchor.constraint(equalTo: view.rightAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor),

        ])
    }
}

extension HabitDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    //задаю хедер
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "АКТИВНОСТЬ"
    }
    //задаю кол-во секций = 1
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    //задаю кол-во строк в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HabitsStore.shared.dates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultTableCellIdentifier", for: indexPath)
        //задаю цвет ячейки
        cell.backgroundColor = .white
        //задаю текст для ячейки
        let text = HabitsStore.shared.trackDateString(forIndex: indexPath.row)
        cell.textLabel?.text = text

        //если привычка была затрекана, то ставим галку
        if HabitsStore.shared.habit(HabitsStore.shared.habits[index], isTrackedIn: HabitsStore.shared.dates[indexPath.row]) {
            cell.tintColor = Colors.purpleColor
            cell.accessoryType = .checkmark
        }

        return cell

    }
}
