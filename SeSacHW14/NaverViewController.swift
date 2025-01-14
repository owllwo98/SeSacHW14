//
//  NaverViewController.swift
//  SeSacHW14
//
//  Created by 변정훈 on 1/13/25.
//

import UIKit
import SnapKit

class NaverViewController: UIViewController {
    
    let naverSegment: UISegmentedControl = UISegmentedControl()
    
    let whiteView: UIView = UIView()
    let logoImageView: UIImageView = UIImageView()
    let headerLabel: UILabel = UILabel()
    let subHeaderLabel: UILabel = UILabel()
    
    let xButton: UIButton = UIButton()
    
    let titleImageView: UIImageView = UIImageView()
    let titleLabel: UILabel = UILabel()
    
    let creditButton: UIButton = UIButton()
    let cancelButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.031, green: 0.082, blue: 0.114, alpha: 1)
        
        configure()
        configureUI()
    }
    
    func configure() {
        naverSegment.insertSegment(withTitle: "멤버쉽", at: 0, animated: true)
        naverSegment.insertSegment(withTitle: "현장결제", at: 1, animated: true)
        naverSegment.insertSegment(withTitle: "쿠폰", at: 2, animated: true)
        
        naverSegment.backgroundColor = .black
        naverSegment.selectedSegmentTintColor = .lightGray
        
        naverSegment.setTitleTextAttributes([.foregroundColor: UIColor.white.cgColor], for: .selected)
        naverSegment.setTitleTextAttributes([.foregroundColor: UIColor.systemGray6], for: .normal)
        
        naverSegment.selectedSegmentIndex = 1
        
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 10

        logoImageView.image = UIImage(systemName: "n.circle.fill")
        logoImageView.tintColor = .black
        
        headerLabel.text = "pay"
        headerLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        subHeaderLabel.text = "국내"
        subHeaderLabel.textColor = .lightGray
        
        xButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        xButton.setTitleColor(.gray, for: .normal)
        xButton.tintColor = .gray
        
        titleImageView.image = UIImage(systemName: "lock.fill")
        titleImageView.tintColor = .green
        titleImageView.contentMode = .scaleAspectFill
        
        titleLabel.text = "한 번만 인증하고\n 비밀번호 없이 결제하세요"
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        creditButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        creditButton.semanticContentAttribute = .forceLeftToRight
        creditButton.setTitle("바로 결제 사용하기", for: .normal)
        creditButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        creditButton.setTitleColor(.black, for: .normal)
        creditButton.tintColor = .green
        
        
        cancelButton.setTitle("확인", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.backgroundColor = UIColor(red: 0, green: 0.678, blue: 0.529, alpha: 1)
        cancelButton.layer.cornerRadius = 20
    }
    
    func configureUI() {
        view.addSubview(naverSegment)
        view.addSubview(whiteView)
        
        [logoImageView, headerLabel, subHeaderLabel, xButton, titleImageView, titleLabel, creditButton, cancelButton].forEach {
            whiteView.addSubview($0)
        }
        
        naverSegment.snp.makeConstraints { make in
            make.top.equalTo(view).inset(36)
            make.horizontalEdges.equalTo(view).inset(36)
        }
        
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(naverSegment.snp.bottom).inset(-16)
            make.bottom.equalTo(view).inset(240)
            make.horizontalEdges.equalTo(view).inset(20)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(8)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.leading.equalTo(logoImageView.snp.trailing).inset(-4)
            make.centerY.equalTo(logoImageView.snp.centerY)
        }
        
        subHeaderLabel.snp.makeConstraints { make in
            make.leading.equalTo(headerLabel.snp.trailing).inset(-4)
            make.top.equalToSuperview().inset(20)
        }
        
        xButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        titleImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(120)
            make.bottom.equalTo(titleLabel.snp.top).inset(-48)
            make.horizontalEdges.equalToSuperview().inset(120)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        creditButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-80)
            make.horizontalEdges.equalToSuperview().inset(100)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(creditButton.snp.bottom).inset(-36)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(24)
        }
        
    }
    

}
