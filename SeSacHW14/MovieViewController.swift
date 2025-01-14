//
//  MovieViewController.swift
//  SeSacHW14
//
//  Created by 변정훈 on 1/13/25.
//

import UIKit
import SnapKit

class MovieViewController: UIViewController {
    
    let textField: UITextField = UITextField()
    let searchButton: UIButton = UIButton()
    let underLine: UIView = UIView()
    
    let tableView: UITableView = UITableView()

//    var list: [String] = ["엽문4: 더 파이널", "주디", "1917", "인비저블맨", "n번째 이별 중", "스캐어리 스토리: 어둠의", "날씨의 아이", "라라랜드", "너의 이름은.", "다크 워터스"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        
        configure()
        configureUI()
//        configureTextField(textField)
    
    }
    
    func configure() {
        textField.backgroundColor = .black
        
        underLine.backgroundColor = .white

        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        searchButton.backgroundColor = .white
        
        tableView.backgroundColor = .black
    }
    

    
    func configureUI() {
        view.addSubview(textField)
        view.addSubview(searchButton)
        view.addSubview(underLine)
        
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.trailing.equalTo(searchButton.snp.leading).inset(-8)
            make.leading.equalToSuperview().inset(8)
            make.bottom.equalTo(searchButton.snp.bottom)
        }
        
        underLine.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).inset(-1)
            make.horizontalEdges.equalTo(textField)
            make.height.equalTo(1)
        }
        
        
        
        searchButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.width.equalTo(100)
            make.height.equalTo(60)
            make.trailing.equalToSuperview().inset(8)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).inset(-16)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
        }
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        cell.rankingLabel.text = String(indexPath.row + 1)
        cell.movieLabel.text = MovieList[indexPath.row].movieList
        cell.dateLabel.text = MovieList[indexPath.row].movieDate
        
        return cell
    }
    
    
}
