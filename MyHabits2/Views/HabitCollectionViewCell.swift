//
//  HabitCell.swift
//  MyHabits2
//
//  Created by Oleg Popov on 24.09.2022.
//

import Foundation
import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    private lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Выпить стакан воды"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 2
        label.toAutoLayout()
        
        return label
    }()

    private lazy var timeLabel : UILabel = {
        let label = UILabel()
        label.text = "Каждый день в 7:30"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray2
        label.toAutoLayout()
        
        return label
    }()

    private lazy var countLabel : UILabel = {
        let label = UILabel()
        label.text = "Счетчик 0"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray
        label.toAutoLayout()
        
        return label
    }()

    private lazy var roundButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 19
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        button.toAutoLayout()
        
        return button
    }()

        private lazy var completeMark : UIImageView = {
            let mark = UIImageView()
            mark.image = UIImage(named:"complete")
            mark.isHidden = true
            mark.toAutoLayout()
            
            return mark
        }()

    override init(frame: CGRect) {
        super .init(frame: frame)
        self.backgroundColor = .white

        contentView.addSubviews(nameLabel, timeLabel, countLabel, roundButton, completeMark)
       

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),

            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            timeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),

            countLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            countLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 92),

            roundButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
            roundButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 46),
            roundButton.heightAnchor.constraint(equalToConstant: 38),
            roundButton.widthAnchor.constraint(equalToConstant: 38),

            completeMark.centerXAnchor.constraint(equalTo: roundButton.centerXAnchor),
            completeMark.centerYAnchor.constraint(equalTo: roundButton.centerYAnchor),
            completeMark.heightAnchor.constraint(equalToConstant: 20),
            completeMark.widthAnchor.constraint(equalToConstant: 20),

        ])
    }

    required init?(coder: NSCoder) {
        super .init(coder: coder)

    }

    @objc func tapButton(){
        let index = nameLabel.tag

        if HabitsStore.shared.habits[index].isAlreadyTakenToday {
           
        } else {
            roundButton.backgroundColor = UIColor(cgColor: roundButton.layer.borderColor ?? Colors.lightGreyColor as! CGColor)
            HabitsStore.shared.track(HabitsStore.shared.habits[index])
            countLabel.text = "Счетчик \(HabitsStore.shared.habits[index].trackDates.count)"
            completeMark.isHidden = false
            
            NotificationCenter.default.post(name: Notification.Name("reloadData"), object: nil)
        }
    }

    func setup(index : Int) {
        nameLabel.tag = index
        nameLabel.text = HabitsStore.shared.habits[index].name
        nameLabel.textColor = HabitsStore.shared.habits[index].color
        timeLabel.text = "\(HabitsStore.shared.habits[index].dateString)"
        countLabel.text = "Счетчик \(HabitsStore.shared.habits[index].trackDates.count)"
        roundButton.layer.borderColor = HabitsStore.shared.habits[index].color.cgColor
        
     
        if HabitsStore.shared.habits[index].isAlreadyTakenToday {
            //если трекали, красим фон кнопки
            roundButton.backgroundColor = UIColor(cgColor: HabitsStore.shared.habits[index].color.cgColor)
            // и ставим галку
            completeMark.isHidden = false
        } else {
            //если не трекали то, фон и галка отсутствуют
            roundButton.backgroundColor = nil
            completeMark.isHidden = true
        }
    }
}

    
    

