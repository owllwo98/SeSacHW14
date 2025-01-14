//
//  Extension.swift
//  SeSacHW14
//
//  Created by 변정훈 on 1/14/25.
//

import UIKit

func configureTextField(_ textField: UITextField ) {
    let border = CALayer()
    border.frame = CGRect(x: 0, y: textField.frame.size.height - 1, width: textField.frame.width, height: 1)
    border.backgroundColor = UIColor.white.cgColor
    
    textField.layer.addSublayer(border)
    textField.borderStyle = .none
}


struct lotto: Decodable {
    let drwNo: Int
    let drwNoDate: String
  
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    
    let bnusNo: Int
    
}
