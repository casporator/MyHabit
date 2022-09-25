//
//  ProgressCell.swift
//  MyHabits2
//
//  Created by Oleg Popov on 24.09.2022.
//

import Foundation
import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private lazy var label : UILabel = {
        let label = UILabel()
        label.text = "Все получится!"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemGray
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var progressBar : UIProgressView = {
        let progress = UIProgressView()
        progress.tintColor = Colors.purpleColor
        progress.backgroundColor = .systemGray2
        progress.toAutoLayout()
        
        return progress
    }()
    
    private lazy var labelProgress : UILabel = {
        let percenteges = UILabel()
        percenteges.text = "0%"
        percenteges.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        percenteges.textColor = .systemGray
        percenteges.toAutoLayout()
        
        return percenteges
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        contentView.addSubviews(label, progressBar, labelProgress)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),

            labelProgress.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            labelProgress.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),

            progressBar.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            progressBar.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            progressBar.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 38),
        ])
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
  }
    
    
    func setup() {
        labelProgress.text = "\(Int(HabitsStore.shared.todayProgress * 100))%" // fix перевел в Int
        progressBar.progress = HabitsStore.shared.todayProgress
    }
}
