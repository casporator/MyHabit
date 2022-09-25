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
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "CustomProgressCell")
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "CustomHabbitCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Colors.lightGreyColor
        collectionView.toAutoLayout()
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.lightGreyColor
        navBarCustomization()
        view.addSubview(collectionView)
        addConstraints()
                                       
       }
    
    override func viewWillAppear(_ animated: Bool) {
        //MARK: Обновляю коллекцию, при перезапуске View
        collectionView.reloadData()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        }

// MARK: создаю навбар
func navBarCustomization () {
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = Colors.lightGreyColor
    self.navigationItem.title = "Сегодня"
    navigationItem.titleView?.layer.borderColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.29).cgColor
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

    private func addConstraints(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -6)
        ])
    }
    
}

extension HabbitsViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HabitsStore.shared.habits.count + 1 // кол-во ячеек = кол-ву привычек в массиве и добовляю 1 ячеку для прогресса
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // задаю прогресс бар как 0 ячейку
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomProgressCell", for: indexPath) as? ProgressCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            cell.layer.cornerRadius = 8
            cell.setup()
            return cell
        }
        //задаю все остольные ячейки как ячейки привычек
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomHabbitCell", for: indexPath) as? HabitCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        cell.layer.cornerRadius = 8
        cell.setup(index: indexPath.row - 1)
        return cell
    }
    
    //MARK: устанавливаю размер ячеек согласно макету
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //для ячейки прогресса
        if indexPath.row == 0 {
            return CGSize(width: view.frame.width-32 , height: 60)
        }
        //для яеек привычек
        return CGSize(width: view.frame.width-32 , height: 130)
    }
}

