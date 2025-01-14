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
    
    var date: Date = Date()
    var didChanged: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        fetchMovieData()
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        
        textField.delegate = self
        configure()
        configureUI()
        configureTextField(textField)
            
    }
    
    func configure() {
        textField.backgroundColor = .black
        textField.placeholder = date.toDateBeforeString()
        textField.textColor = .white
        
        
        underLine.backgroundColor = .white

        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        searchButton.backgroundColor = .white
        searchButton.addTarget(self, action: #selector(searchbuttonTapped), for: .touchUpInside)
        
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
    
    @objc
    func searchbuttonTapped() {
        print(#function)
        
        guard let text = textField.text else {
            return
        }
        
        guard let newDate = text.toDate() else {
            return
        }
        
        if date > newDate{
            date = newDate
        } else {
            
        }

        print(date.toDateString())
        
        didChanged = false
        fetchMovieData()
        tableView.reloadData()
    }
}

// MARK: Cell 생성시 매번 네트워크 통신이 이루어진다. 불필요한 리소스가 증가한다.
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

// MARK: TextField 제약조건을 방법을 서치해봤습니다.
extension MovieViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text as NSString? else { return false }
        let updatedText = currentText.replacingCharacters(in: range, with: string)
        guard Int(string) != nil || string.isEmpty else { return false }
        guard updatedText.count <= 8 else { return false }

        return true
    }
}


extension MovieViewController: SkeletonTableViewDelegate, SkeletonTableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rank.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        cell.rankingLabel.text = rank[indexPath.row]
        cell.movieLabel.text = movieNm[indexPath.row]
        cell.dateLabel.text = openDt[indexPath.row]
        
        return cell
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "cell"
      }
      
      func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        skeletonView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      }
      
      func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        UITableView.automaticNumberOfSkeletonRows
      }
      
      func numSections(in collectionSkeletonView: UITableView) -> Int {
        1
      }
    
}

extension MovieViewController {
    
    // MARK: 데이터를 다 불러온 후 UI 를 그려주기 위해서는 LoadingView 나 SkeletonView 를 사용하는 방법만 있는지 이외의 방법은 무엇인 궁금합니다.
    func fetchMovieData() {
        rank = []
        movieNm = []
        openDt = []
        // Extension 속 func toDateDayString() 사용
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=b4126bd85d21685991482cd29b102fd8&targetDt=\(didChanged ? date.toDateBeforeString() : date.toDateString())"
        print(url)
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
