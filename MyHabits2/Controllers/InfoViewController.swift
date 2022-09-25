//
//  InfoViewController.swift
//  MyHabits2
//
//  Created by Oleg Popov on 21.09.2022.
//

import Foundation
import UIKit

class InfoViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.toAutoLayout()
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        
        return view
    }()
    
    private lazy var infoTitleLable: UILabel = {
        let infoTitle = UILabel()
        infoTitle.text = TitleForInfo
        infoTitle.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        infoTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        infoTitle.toAutoLayout()
        
        return infoTitle
    }()
    
    private lazy var infoTextLable: UILabel = {
        let infoText = UILabel()
        infoText.text = TextForInfo
        infoText.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        infoText.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        infoText.numberOfLines = 0
        infoText.lineBreakMode = .byWordWrapping
        infoText.toAutoLayout()
        
        return infoText
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        navBarCustomization()
        addConstraints()
    }
    
    // MARK: настройка навигационного бара
    func navBarCustomization () {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Colors.lightGreyColor
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationItem.title = "Информация"
        
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 876),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 22),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo:scrollView.bottomAnchor, constant: -60),
            
            infoTitleLable.topAnchor.constraint(equalTo: contentView.topAnchor),
            infoTitleLable.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            
            infoTextLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            infoTextLable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            infoTextLable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            infoTextLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -122),
        ])
     }
    
    func addViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(infoTitleLable)
        contentView.addSubview(infoTextLable)
    }
}



