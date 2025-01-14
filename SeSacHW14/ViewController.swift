//
//  ViewController.swift
//  SeSacHW14
//
//  Created by 변정훈 on 1/13/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var jackFlixButton: UIButton = {
        let button = UIButton()
        button.setTitle("JackFlix", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(jackButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var naverButton: UIButton = {
        let button = UIButton()
        button.setTitle("Naver", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(naverButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var movieChartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Movie Chart", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(movieButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    @objc
    func jackButtonTapped() {
        let vc = JackFlixViewController()
        present(vc, animated: true)
    }
    
    @objc
    func naverButtonTapped() {
        let vc = NaverViewController()
        present(vc, animated: true)
    }
    
    @objc
    func movieButtonTapped() {
        let vc = MovieViewController()
        present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureUI()
        
    }
    
    func configureButtonUI(_ title: String,_ titleColor: UIColor,_ backgroundColor: UIColor) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        
        return button
    }
    
    
    func configureUI() {
        [jackFlixButton, naverButton, movieChartButton].forEach {
            view.addSubview($0)
        }
        
        let sectionInset: CGFloat = 100
        let cellSpacing: CGFloat = 100
        
        let deviceHeight = UIScreen.main.bounds.height
        let cellHeight = deviceHeight - (sectionInset * 2) - (cellSpacing * 2)
        
        jackFlixButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(sectionInset)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
        
        naverButton.snp.makeConstraints { make in
            make.top.equalTo(jackFlixButton).inset(cellSpacing)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
        
        movieChartButton.snp.makeConstraints { make in
            make.top.equalTo(naverButton).inset(cellSpacing)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
        
    }

}

