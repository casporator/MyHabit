//
//  HabitViewController.swift
//  MyHabits2
//
//  Created by Oleg Popov on 21.09.2022.
//

import Foundation
import UIKit

//MARK: объявляю все элементы согласно макуету:
class HabitViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    private lazy var nameHabbit : UILabel = {
        let label = UILabel()
        label.text = "НАЗВАНИЕ"
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        label.textColor = .black
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var nameTextfield: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.font = UIFont(name: "SFProText-Regular", size: 17)
        textField.textColor = .systemGray2
        textField.toAutoLayout()
        
        return textField
    }()
    
    private lazy var colorHabbit : UILabel = {
        let label = UILabel()
        label.text = "ЦВЕТ"
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        label.textColor = .black
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var colorButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.OrangeColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(openColorPicker) , for: .touchUpInside)
        button.toAutoLayout()
        
        return button
    }()
    
    private lazy var timeHabbit : UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ"
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        label.textColor = .black
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var timeText : UILabel = {
        let label = UILabel()
        label.text = "Каждый день в "
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.textColor = .black
        label.toAutoLayout()
        
        return label
    }()
   
    private lazy var habitTimeLabel : UILabel = {
        let label = UILabel()
        label.text = "11:00 PM"
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.textColor = Colors.purpleColor
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var timePicker : UIDatePicker = {
        let tPicker = UIDatePicker()
        tPicker.datePickerMode = .time
        tPicker.preferredDatePickerStyle = .wheels
        tPicker.addTarget(self, action: #selector(selectTime), for: .valueChanged)
        tPicker.toAutoLayout()
        
        return tPicker
    }()
    //MARK: объявляю кнопку удаления привычки, которая видна только если перейти с DetailsViewController
    private lazy var deleteButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(Colors.redColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.addTarget(self, action: #selector(deleteHabbit) , for: .touchUpInside)
        button.toAutoLayout()
        
        return button
    }()
    
    //MARK: Объявляю alertController
    let alertController = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку ?", preferredStyle: .alert)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubviews(nameHabbit, nameTextfield, colorHabbit, colorButton, timeHabbit, timeText, habitTimeLabel, timePicker)
        addConstraints()
        setupNavigationBar()
        hideKeyboardWhenTappedAround() // прячу клавиатуру по тапу
        
        if placeOfCall == Text.detailPlace {
         
        //передаю все данные привычки от каторой перешли в настройки
        nameTextfield.text = HabitsStore.shared.habits[numberOfHabit].name //название
        colorButton.backgroundColor = HabitsStore.shared.habits[numberOfHabit].color //цвет
        habitTimeLabel.text = HabitsStore.shared.habits[numberOfHabit].dateString // время
        timePicker.date = HabitsStore.shared.habits[numberOfHabit].date //время на тайм пикере
        
        
        view.addSubview(deleteButton)
            addConstraintsForButton()
    
        alertController.addAction(UIAlertAction(title: "Отмена", style: .default, handler: { _ in
            print("Delete Canceled")
        }))
        alertController.addAction(UIAlertAction(title: "Удалить", style: .default, handler: { _ in
            HabitsStore.shared.habits.remove(at: numberOfHabit)
            self.dismiss(animated: true)
            mark = 1
            print("Habit was Delete")
        }))
       
        } else {

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            dateFormatter.string(from: timePicker.date)
            habitTimeLabel.text = "\(dateFormatter.string(from: timePicker.date))"
        }
    }
    
    //MARK: функция открытия ColorPicker'а
    @objc func openColorPicker(){
        let color = UIColorPickerViewController()
        color.supportsAlpha = false
        color.delegate = self
        color.selectedColor = colorButton.backgroundColor ?? Colors.OrangeColor
        present(color, animated: true)
    }
    
    //MARK: сохранение выбранный цвета в виде фона кнопки
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorButton.backgroundColor = viewController.selectedColor
    }
    
    //MARK: устанавка времени привычки
    @objc func selectTime(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.string(from: timePicker.date)
        habitTimeLabel.text = "\(dateFormatter.string(from: timePicker.date))"
    }
    
    //MARK:
    @objc func deleteHabbit(){
        alertController.message = "Вы хотите удалить привычку \"\(nameTextfield.text ?? "нет созданной привычки")\"?"
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: делаю верстку согласно макету
    func addConstraints(){
        NSLayoutConstraint.activate([
            nameHabbit.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            nameHabbit.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            
            nameTextfield.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            nameTextfield.topAnchor.constraint(equalTo: nameHabbit.bottomAnchor, constant: 7),
            
            colorHabbit.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            colorHabbit.topAnchor.constraint(equalTo: nameTextfield.bottomAnchor, constant: 15),
            
            colorButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            colorButton.topAnchor.constraint(equalTo: colorHabbit.bottomAnchor, constant: 7),
            colorButton.heightAnchor.constraint(equalToConstant: 30),
            colorButton.widthAnchor.constraint(equalToConstant: 30),
            
            timeHabbit.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            timeHabbit.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 15),
            
            timeText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            timeText.topAnchor.constraint(equalTo: timeHabbit.bottomAnchor, constant: 7),
            
            habitTimeLabel.leftAnchor.constraint(equalTo: timeText.rightAnchor),
            habitTimeLabel.topAnchor.constraint(equalTo: timeHabbit.bottomAnchor, constant: 7),
            
            timePicker.leftAnchor.constraint(equalTo: view.leftAnchor),
            timePicker.rightAnchor.constraint(equalTo: view.rightAnchor),
            timePicker.topAnchor.constraint(equalTo: timeText.bottomAnchor, constant: 15),
        ])
}
    func addConstraintsForButton(){
        NSLayoutConstraint.activate([
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 18),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 22),
    
            ])
    }
    
    //MARK: создаю навбар и 2 кнопки, согласно макету
    func setupNavigationBar(){
    
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
      
        if placeOfCall == Text.detailPlace {
      
      navigationItem.title = Text.habitNavTitle
      navigationItem.rightBarButtonItem = UIBarButtonItem(title: Text.rightHabitButton, style: .plain, target: self, action: #selector(saveEditHabbit))
        navigationItem.rightBarButtonItem?.tintColor = Colors.purpleColor
      navigationItem.leftBarButtonItem = UIBarButtonItem(title: Text.leftHabitButton, style: .plain, target: self, action: #selector(closeHabitViewController))
        navigationItem.leftBarButtonItem?.tintColor = Colors.purpleColor
        
            
        }else{
            
            navigationItem.title = Text.AddHabitTitile
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: Text.rightHabitButton, style: .plain, target: self, action: #selector(saveNewHabbit))
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: Text.leftHabitButton, style: .plain, target: self, action: #selector(closeHabitViewController))
        navigationItem.leftBarButtonItem?.tintColor = Colors.purpleColor
        navigationItem.rightBarButtonItem?.tintColor = Colors.purpleColor
        }
    }
    //MARK: функция закрытия модального окна для кнопки "Отменить"
    @objc func closeHabitViewController(){
        dismiss(animated: true)
       
    }
    
    //MARK: функция сохранения привычки
    @objc func saveNewHabbit(){
        let newHabit = Habit(
            name: nameTextfield.text ?? " ",
            date: timePicker.date,
            color: colorButton.backgroundColor ?? .systemGray)

        HabitsStore.shared.habits.append(newHabit)

        dismiss(animated: true)
        mark = 1
  
    }
    
    @objc func saveEditHabbit(){

        HabitsStore.shared.habits[numberOfHabit].name = nameTextfield.text ?? " "
        HabitsStore.shared.habits[numberOfHabit].date = timePicker.date
        HabitsStore.shared.habits[numberOfHabit].color = colorButton.backgroundColor ?? .systemGray

        HabitsStore.shared.save()

        dismiss(animated: true)
        mark = 1
    }
    
}

