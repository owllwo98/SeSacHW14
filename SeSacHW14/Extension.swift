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

extension Date {
    func toDateHourString() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "HH:mm a"
        let dateString = formatter.string(from: self)
        return dateString
    }
    
    func toDateBeforeString() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyyMMdd"
        let yesterDay = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let dateString = formatter.string(from: yesterDay!)
        return dateString
    }
    
    func toDateString() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyyMMdd"
        let dateString = formatter.string(from: self)
        return dateString
    }
    
    func toDayString() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "dd"
        let dateString = formatter.string(from: self)
        return dateString
    }
}

extension String {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        formatter.timeZone = TimeZone(identifier: "KST")
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
    func toDate() -> Date? {
        let dateFormatter = Self.dateFormatter
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        return date
    }
}

