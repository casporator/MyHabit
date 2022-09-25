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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = false //отключаю большой заголовок
        navigationItem.title = HabitsStore.shared.habits[index].name
        
        let chengeButton = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(goToHabitViewController))

        navigationItem.rightBarButtonItems = [chengeButton]
        navigationItem.rightBarButtonItem?.tintColor = Colors.purpleColor

    }
    
    @objc func goToHabitViewController(){
        let navController = UINavigationController(rootViewController: HabitViewController())
        navController.modalPresentationStyle = .fullScreen
        
        self.present(navController, animated:true, completion: nil)
    }
    
}
