//
//  HabbitsViewController.swift
//  MyHabits2
//
//  Created by Oleg Popov on 21.09.2022.
//

import Foundation
import UIKit

class HabitsViewController : UIViewController {
    
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
        
        setUpView()
        navBarCustomization()
        view.addSubview(collectionView)
        addConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //MARK: Обновляю коллекцию, при перезапуске View
        collectionView.reloadData()
        navigationController?.navigationBar.prefersLargeTitles = true
        //устанавливаю обзервер для отслеживания иуведомлений - если придут то выполняется reloadData
        NotificationCenter.default.addObserver(self,
                        selector: #selector(methodOfReceivedNotification(notification:)),
                        name: Notification.Name("reloadData"),
                        object: nil)
    }
    
    func setUpView() {
        view.backgroundColor = .white
        tabBarController?.tabBar.backgroundColor = Colors.tabBarColor
        tabBarController?.tabBar.isTranslucent = false
        tabBarController?.tabBar.layer.borderColor = Colors.seporator.cgColor
        tabBarController?.tabBar.layer.borderWidth = 1
        tabBarController?.tabBar.layer.masksToBounds = true
    }
    
 
    // MARK: создаю навбар
    func navBarCustomization() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Создать"
        
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
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        collectionView.reloadData()
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension HabitsViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
    
    //MARK: добовляю функцию: при нажатиии на ячейку привычки - открывается HabitDetailsViewController
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != 0 {  //если ячейка не нулевая
            numberOfHabit = indexPath.row - 1
            let habitDetailsViewController = HabitDetailsViewController()
            habitDetailsViewController.index = indexPath.row - 1
            navigationController?.pushViewController(habitDetailsViewController, animated: false)
        }
    }
}
