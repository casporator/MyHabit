//
//  HabitViewController.swift
//  MyHabits2
//
//  Created by Oleg Popov on 21.09.2022.
//

import Foundation
import UIKit

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
        button.backgroundColor = OrangeColor
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
   
    private lazy var timeLabel : UILabel = {
        let label = UILabel()
        label.text = "11:00 PM"
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.textColor = purpleColor
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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubviews(nameHabbit, nameTextfield, colorHabbit, colorButton, timeHabbit, timeText, timeLabel, timePicker)
        }
    

        
        
    @objc func openColorPicker(){
        let color = UIColorPickerViewController()
        color.supportsAlpha = false
        color.delegate = self
        color.selectedColor = colorButton.backgroundColor ?? OrangeColor
        present(color, animated: true)
    }
    
    @objc func selectTime(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.string(from: timePicker.date)
        timeLabel.text = "\(dateFormatter.string(from: timePicker.date))"
    }
    
    
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
            
            timeLabel.leftAnchor.constraint(equalTo: timeText.rightAnchor),
            timeLabel.topAnchor.constraint(equalTo: timeHabbit.bottomAnchor, constant: 7),
            
            timePicker.leftAnchor.constraint(equalTo: view.leftAnchor),
            timePicker.rightAnchor.constraint(equalTo: view.rightAnchor),
            timePicker.topAnchor.constraint(equalTo: timeText.bottomAnchor, constant: 15),
            ])
    }
}
