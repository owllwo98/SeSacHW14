//
//  JackFlixViewController.swift
//  SeSacHW14
//
//  Created by 변정훈 on 1/13/25.
//

import UIKit
import SnapKit

class JackFlixViewController: UIViewController {
    
    let titleLabel: UILabel = UILabel()
    
    let extraInfo: UILabel = UILabel()
    
    let extraSwitch: UISwitch = UISwitch()
    
    lazy var emailButton: UIButton = {
        let button = UIButton()
        button.setTitle("이메일 주소 또는 전화번호", for: .normal)
        
        return button
    }()
    
    lazy var passwordButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호", for: .normal)
        
        return button
    }()
    
    lazy var nicknameButton: UIButton = {
        let button = UIButton()
        button.setTitle("닉네임", for: .normal)
        
        return button
    }()
    
    lazy var locationButton: UIButton = {
        let button = UIButton()
        button.setTitle("위치", for: .normal)
        
        return button
    }()
    
    lazy var recommendButton: UIButton = {
        let button = UIButton()
        button.setTitle("추천 코드 입력", for: .normal)
        
        return button
    }()
    
    lazy var joinButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        
        return button
    }()
    
//    func setButtonUI() -> UIButton {
//        let button = UIButton()
//        button.setTitle("", for: .normal)
//        
//        return button
//    }
    
//    lazy var buttonList: [UIButton] = [emailButton, passwordButton, nicknameButton, locationButton, recommendButton, joinButton]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        configureUI()
        
        }
    
    func configureUI() {
        
        view.addSubview(titleLabel)
        
        [emailButton, passwordButton, nicknameButton, locationButton, recommendButton].forEach {
            view.addSubview($0)
            $0.backgroundColor = .gray
            $0.layer.cornerRadius = 5
        }
        
        view.addSubview(joinButton)
        view.addSubview(extraInfo)
        view.addSubview(extraSwitch)
        
        
        
        titleLabel.text = "JACKFLIX"
        titleLabel.textColor = .red
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        
        joinButton.backgroundColor = .white
        joinButton.setTitleColor(.black, for: .normal)
        joinButton.layer.cornerRadius = 5
        
        extraInfo.text = "추가 정보 입력"
        extraInfo.font = .systemFont(ofSize: 12, weight: .regular)
        extraInfo.textColor = .white
        
        extraSwitch.isOn = true
        extraSwitch.onTintColor = .red
    
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.centerX.equalTo(view)
        }
        
        
        emailButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-100)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(36)
        }
        
        passwordButton.snp.makeConstraints { make in
            make.top.equalTo(emailButton.snp.bottom).inset(-16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(36)
        }
        
        nicknameButton.snp.makeConstraints { make in
            make.top.equalTo(passwordButton.snp.bottom).inset(-16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(36)
        }
        
        locationButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameButton.snp.bottom).inset(-16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(36)
        }
        
        recommendButton.snp.makeConstraints { make in
            make.top.equalTo(locationButton.snp.bottom).inset(-16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(36)
        }
        
        joinButton.snp.makeConstraints { make in
            make.top.equalTo(recommendButton.snp.bottom).inset(-16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(36)
        }
        
        extraInfo.snp.makeConstraints { make in
            make.top.equalTo(joinButton.snp.bottom).inset(-16)
            make.leading.equalTo(view).inset(36)
        }
        
        extraSwitch.snp.makeConstraints { make in
            make.top.equalTo(joinButton.snp.bottom).inset(-16)
            make.trailing.equalTo(view).inset(36)
        }
        
    }
}

