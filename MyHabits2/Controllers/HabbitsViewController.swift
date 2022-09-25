//
//  HabbitsViewController.swift
//  MyHabits2
//
//  Created by Oleg Popov on 21.09.2022.
//

import Foundation
import UIKit

class HabbitsViewController : UIViewController {
    
    //MARK: создаю коллекцию
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 17)
        return layout
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.lightGreyColor
        navBarCustomization()
                                       
       }
    
    // MARK: создаю навбар
func navBarCustomization () {
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = Colors.lightGreyColor
    self.navigationItem.title = "Сегодня"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    // MARK: создаю кнопку + на навбаре
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goAddHabit))
    navigationItem.rightBarButtonItems = [addButton]
    navigationItem.rightBarButtonItem?.tintColor = Colors.purpleColor

}
   // MARK: создаю селектор для кнопки + (по условию открывает модально) отправляю на HabitViewController
@objc func goAddHabit(){
    let navController = UINavigationController(rootViewController: HabitViewController())
    navController.modalPresentationStyle = .fullScreen
    self.present(navController, animated:true, completion: nil)
}

    
    
}
