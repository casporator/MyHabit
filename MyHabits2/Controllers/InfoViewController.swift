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
        infoTitle.text = Text.titleForInfo
        infoTitle.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        infoTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        infoTitle.toAutoLayout()
        
        return infoTitle
    }()
    
    private lazy var infoTextLable: UILabel = {
        let infoText = UILabel()
        infoText.text = Text.textForInfo
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
        navigationItem.title = Text.infoNavTitle
        
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo:scrollView.bottomAnchor),
            
            infoTitleLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            infoTitleLable.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            
            infoTextLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 62),
            infoTextLable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            infoTextLable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            infoTextLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -22)
        ])
     }
    
    func addViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(infoTitleLable)
        contentView.addSubview(infoTextLable)
    }
}



