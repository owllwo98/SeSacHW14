//
//  MovieViewController.swift
//  SeSacHW14
//
//  Created by 변정훈 on 1/13/25.
//

import UIKit
import SnapKit
import Alamofire
import SkeletonView

class MovieViewController: UIViewController {
    
    let textField: UITextField = UITextField()
    let searchButton: UIButton = UIButton()
    let underLine: UIView = UIView()
    let tableView: UITableView = UITableView()

    
    var rank: [String] = []
    var movieNm: [String] = []
    var openDt: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        fetchMovieData()
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        
    
        configure()
        configureUI()
        configureTextField(textField)
            
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
            make.top.equalToSuperview().inset(100)
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
            make.top.equalToSuperview().inset(100)
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

//extension MovieViewController: UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return rank.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
//        
//        
//        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=b4126bd85d21685991482cd29b102fd8&targetDt=20250113"
        
//        AF.request(url, method: .get).responseDecodable(of: BoxOffice.self) { response in
//            
//            switch response.result {
//            case .success(let value):
//                for i in 0..<value.boxOfficeResult.dailyBoxOfficeList.count {
//                    cell.rankingLabel.text = value.boxOfficeResult.dailyBoxOfficeList[indexPath.row].rank
//                    cell.movieLabel.text = value.boxOfficeResult.dailyBoxOfficeList[indexPath.row].movieNm
//                    cell.dateLabel.text = value.boxOfficeResult.dailyBoxOfficeList[indexPath.row].openDt
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//
//        return cell
//    }
//}


extension MovieViewController: SkeletonTableViewDelegate, SkeletonTableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rank.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        cell.rankingLabel.text = rank[indexPath.row]
        cell.movieLabel.text = movieNm[indexPath.row]
        cell.dateLabel.text = openDt[indexPath.row]
        
//        print(rank.count)
        return cell
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "cell"
      }
      
      func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        skeletonView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      }
      
      func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        UITableView.automaticNumberOfSkeletonRows // <- 편리하게 사용 가능
      }
      
      func numSections(in collectionSkeletonView: UITableView) -> Int {
        1
      }
    
}

extension MovieViewController {
    
    // MARK: 해당 메서드를 사용해서 데이터를 다 불러온 후 UI 를 그려주기 위해서는 LoadingView 나 SkeletonView 를 사용하는게 정답인지 궁금합니다.
    func fetchMovieData() {
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=b4126bd85d21685991482cd29b102fd8&targetDt=20250113"
        
        AF.request(url, method: .get).responseDecodable(of: BoxOffice.self) { response in
            
            switch response.result {
            case .success(let value):
                for i in 0..<value.boxOfficeResult.dailyBoxOfficeList.count {
                    self.rank.append(value.boxOfficeResult.dailyBoxOfficeList[i].rank)
                    self.movieNm.append(value.boxOfficeResult.dailyBoxOfficeList[i].movieNm)
                    self.openDt.append(value.boxOfficeResult.dailyBoxOfficeList[i].openDt)
                }
                
                DispatchQueue.main.async {
                    self.tableView.stopSkeletonAnimation()
                    self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
