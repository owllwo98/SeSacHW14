//
//  LottoViewController.swift
//  SeSacHW14
//
//  Created by 변정훈 on 1/14/25.
//

import UIKit
import SnapKit
import Alamofire

class LottoViewController: UIViewController {
    
    var number: [Int] = Array<Int>(1...1154)
    var list: [Int] = []
    var drwNumberList: [Int] = []
    var isFirst: Bool = true

    let lottoTextField: UITextField = UITextField()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "당첨번호 안내"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        
        return label
    }()
    
    let lottoDateLabel: UILabel = UILabel()
    
    let separatorLine: UIView = UIView()
    
    let drwNoLabel: UILabel = UILabel()
    
    let subDrwNoLabel: UILabel = UILabel()
    
    let drwtNoList: [UILabel] = [UILabel(), UILabel(), UILabel(), UILabel(), UILabel(), UILabel()]
    
    let plusImageView: UIImageView = UIImageView()
    
    let drwNoPickerView: UIPickerView = UIPickerView()
    
    let bnusNo: UILabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lottoTextField.inputView = drwNoPickerView
        
        drwNoPickerView.delegate = self
        drwNoPickerView.dataSource = self
        
        view.backgroundColor = .white
        
        configure()
        configureUI()
        
        initialLotto()
        
       
    }
    
    func configure() {
        lottoTextField.backgroundColor = .white
        lottoTextField.layer.borderWidth = 1
        lottoTextField.layer.borderColor = UIColor.lightGray.cgColor
        lottoTextField.textAlignment = .center
        lottoTextField.addTarget(self, action: #selector(textFieldTapped), for: .editingDidBegin)
        
        lottoDateLabel.text = "2020-05-30 추첨"
        lottoDateLabel.textColor = .black
        lottoDateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
        separatorLine.backgroundColor = .lightGray
        
        drwNoLabel.text = "913회 당첨결과"
        drwNoLabel.textColor = .yellow
        drwNoLabel.textAlignment = .center
        drwNoLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        subDrwNoLabel.text = "당첨결과"
        subDrwNoLabel.textColor = .black
        subDrwNoLabel.textAlignment = .center
        subDrwNoLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        drwtNoList.forEach {
            $0.textColor = .white
            $0.clipsToBounds = true
            $0.textAlignment = .center
        }
        
        drwtNoList.forEach { UILabel in
            DispatchQueue.main.async {
                UILabel.layer.cornerRadius = UILabel.frame.width / 2
            }
        }
        drwtNoList[0].backgroundColor = .yellow
        drwtNoList[1].backgroundColor = .blue
        drwtNoList[2].backgroundColor = .blue
        drwtNoList[3].backgroundColor = .red
        drwtNoList[4].backgroundColor = .red
        drwtNoList[5].backgroundColor = .lightGray
        
        plusImageView.image = UIImage(systemName: "plus")
        plusImageView.tintColor = .black
        
        bnusNo.textColor = .white
        bnusNo.clipsToBounds = true
        bnusNo.textAlignment = .center
        bnusNo.backgroundColor = .lightGray
        
        DispatchQueue.main.async {
            self.bnusNo.layer.cornerRadius = self.bnusNo.frame.width / 2
        }
        
        drwNoPickerView.isHidden = true
    }
    
    func configureUI() {
        [lottoTextField, infoLabel, lottoDateLabel, separatorLine, drwNoLabel, subDrwNoLabel, plusImageView, bnusNo, drwNoPickerView].forEach {
            view.addSubview($0)
        }
        
        drwtNoList.forEach {
            view.addSubview($0)
        }
        
        lottoTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(lottoTextField.snp.bottom).inset(-16)
            make.leading.equalToSuperview().inset(16)
        }
        
        lottoDateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(infoLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(16)
        }
        
        separatorLine.snp.makeConstraints { make in
            make.top.equalTo(lottoDateLabel.snp.bottom).inset(-16)
            make.horizontalEdges.equalTo(lottoTextField)
            make.height.equalTo(1)
        }
        
        drwNoLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorLine.snp.bottom).inset(-32)
            make.leading.equalToSuperview().inset(120)
          
        }
        
        subDrwNoLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorLine.snp.bottom).inset(-32)
            make.leading.equalTo(drwNoLabel.snp.trailing).inset(-8)
            make.centerY.equalTo(drwNoLabel.snp.centerY)
        }
        
       
        for i in 0...5 {
            if isFirst {
                drwtNoList[i].snp.makeConstraints { make in
                    make.top.equalTo(drwNoLabel.snp.bottom).inset(-16)
                    make.leading.equalToSuperview().inset(16)
                    make.size.equalTo(40)
                }
                isFirst = false
            } else {
                drwtNoList[i].snp.makeConstraints { make in
                    make.top.equalTo(drwNoLabel.snp.bottom).inset(-16)
                    make.leading.equalTo(drwtNoList[i-1].snp.trailing).inset(-4)
                    make.size.equalTo(40)
                }
            }
        }
        
        plusImageView.snp.makeConstraints { make in
            make.centerY.equalTo(drwtNoList[5].snp.centerY)
            make.leading.equalTo(drwtNoList[5].snp.trailing).inset(-16)
        }
        
        bnusNo.snp.makeConstraints { make in
            make.top.equalTo(drwNoLabel.snp.bottom).inset(-16)
            make.trailing.equalToSuperview().inset(16)
            make.size.equalTo(40)
        }
        
        
        
        
        drwNoPickerView.snp.makeConstraints { make in
            make.bottom.equalTo(view).inset(4)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
    }
    
    @objc
    func textFieldTapped() {
        drwNoPickerView.isHidden = false
    }
    
    func initialLotto() {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1154"
        
        AF.request(url, method: .get).responseDecodable(of: lotto.self) { response in
            
            switch response.result {
            case .success(let value):
                print(value.drwNo)
                self.drwNoLabel.text = value.drwNo.formatted() + "회"
                self.list = Array<Int>(1...value.drwNo)
                
                for number in [value.drwtNo1, value.drwtNo2, value.drwtNo3, value.drwtNo4, value.drwtNo5, value.drwtNo6] {
                    self.drwNumberList.append(number)
                }
                
                for i in 0...5 {
                    self.drwtNoList[i].text = self.drwNumberList[i].formatted()
                }
                self.bnusNo.text = value.bnusNo.formatted()
            case .failure(let error):
                print(error)
            }
        }

    }
    
}




extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row].formatted()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lottoTextField.text = list[row].formatted()
        drwNumberList = []
        
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number[row])"
        
        AF.request(url, method: .get).responseDecodable(of: lotto.self) { response in
            
            switch response.result {
            case .success(let value):
                for number in [value.drwtNo1, value.drwtNo2, value.drwtNo3, value.drwtNo4, value.drwtNo5, value.drwtNo6] {
                    self.drwNumberList.append(number)
                }
                for i in 0...5 {
                    self.drwtNoList[i].text = self.drwNumberList[i].formatted()
                }
                self.drwNoLabel.text = value.drwNo.formatted() + "회"
                self.lottoDateLabel.text = value.drwNoDate + " 추첨"
                self.bnusNo.text = value.bnusNo.formatted()
            case .failure(let error):
                print(error)
            }
        }
    }
}
