//
//  TrendViewController.swift
//  MovieLog
//
//  Created by 최승범 on 6/25/24.
//

import UIKit
import Alamofire
import SnapKit

final class TrendViewController: BaseViewController {
    
    private lazy var trendCollectionView = UICollectionView(frame: self.view.frame,
                                                            collectionViewLayout: createCollectionViewLayout())
    private var trendMovieModel: TrendDTO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
    
        NetworkManager.shared.fetchData(TrendDTO.self,
                                        router: .trend(.week)) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let trendData):
                trendMovieModel = trendData
                trendCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - Configuration
    override func configureNavigationBar() {
        let menuItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"),
                                       style: .plain,
                                       target: self,
                                       action: #selector(menuButtonClicked))
        
        let searchItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(searchButtonClicked))
        
        navigationItem.leftBarButtonItem = menuItem
        navigationItem.rightBarButtonItem = searchItem
    }
    
    override func configureHierarchy() {
        view.addSubview(trendCollectionView)
    }
    
    override func configureLayout() {
        trendCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    private func configureCollectionView() {
        
        trendCollectionView.delegate = self
        trendCollectionView.dataSource = self
        
        trendCollectionView.register(TrendCollectionViewCell.self,
                                     forCellWithReuseIdentifier: TrendCollectionViewCell.identifier)
        
    }
    
    
    private func createCollectionViewLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        
        layout.itemSize = CGSize(width: view.frame.width - 40,
                                 height: view.frame.height * 0.4)
        return layout
    }
    
}

//MARK: - Method
extension TrendViewController {
    
    @objc private func menuButtonClicked() {
        
    }
    
    @objc private func searchButtonClicked() {
        
    }
    

}

//MARK: -  CollectionViewDelegate, DataSource
extension TrendViewController: UICollectionViewDelegate,
                               UICollectionViewDataSource,
                               UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let count = trendMovieModel?.results.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendCollectionViewCell.identifier,
                                                      for: indexPath) as? TrendCollectionViewCell else {
            return TrendCollectionViewCell()
        }
        
        if let data = trendMovieModel?.results[indexPath.row] {
            cell.updateContent(data: data)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = trendMovieModel?.results[indexPath.row] {
           
            navigationController?.pushViewController(MovieDetailViewController(movieId: movie.id),
                                                     animated: true)
        }
    }
    
    //MARK: - FlowLayoutDelegate
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 40
        let height = width
        
        return CGSize(width: width, height: height)
    }
    
}
