//
//  MovieTableViewCell.swift
//  SeSacHW14
//
//  Created by 변정훈 on 1/13/25.
//

import UIKit
import SnapKit
import SkeletonView

class MovieTableViewCell: UITableViewCell {

    let rankingLabel: UILabel = UILabel()
    let movieLabel: UILabel = UILabel()
    let dateLabel: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.isSkeletonable = true
        self.contentView.isSkeletonable = true
        self.dateLabel.isSkeletonable = true
        self.movieLabel.isSkeletonable = true
        self.rankingLabel.isSkeletonable = true
        configure()
        
        contentView.addSubview(rankingLabel)
        contentView.addSubview(movieLabel)
        contentView.addSubview(dateLabel)
        
        rankingLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.trailing.equalTo(movieLabel.snp.leading).inset(-16)
            make.width.equalTo(40)
            make.height.equalTo(23)
     
            
        }
        
        movieLabel.snp.makeConstraints { make in
//            make.leading.equalTo(rankingLabel.snp.trailing)
            make.centerY.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        

    }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    private func configure() {
        self.backgroundColor = .black
        
        rankingLabel.textColor = .black
        rankingLabel.backgroundColor = .white
        rankingLabel.textAlignment = .center
        rankingLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        movieLabel.textColor = .white
        movieLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
        dateLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
    }

}
