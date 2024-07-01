//
//  HomeViewController.swift
//  MovieLog
//
//  Created by 최승범 on 6/27/24.
//

import UIKit
import SnapKit

final class HomeViewController: BaseViewController {
    
    private lazy var homeCollectionView = UICollectionView(frame: .zero,
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
                homeCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
//MARK: - Configuration
    override func configureNavigationBar() {
        
        let searchItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(searchButtonClicked))
        searchItem.tintColor = .baseFont
        
        navigationItem.rightBarButtonItem = searchItem
    }
    
    override func configureHierarchy() {
        view.addSubview(homeCollectionView)
    }
    
    override func configureLayout() {
        
        homeCollectionView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureCollectionView() {
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        homeCollectionView.showsVerticalScrollIndicator = false
        
        homeCollectionView.register(HomeMainCollectionViewCell.self,
                                    forCellWithReuseIdentifier: HomeMainCollectionViewCell.identifier)
        homeCollectionView.register(PosterCollectionViewCell.self,
                                    forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        
        homeCollectionView.register(TitleHeaderView.self,
                                         forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                         withReuseIdentifier: TitleHeaderView.identifier)
        
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let collectioViewCompositonalLayout = UICollectionViewCompositionalLayout {
            (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            return HomeCollectionViewSections(rawValue: sectionIndex)?.layoutSection
        }
        
        return collectioViewCompositonalLayout
        
    }

//MARK: - Objc
    @objc func searchButtonClicked() {
        navigationController?.pushViewController(SearchViewController(),
                                                 animated: true)
    }
    
}

//MARK: - CollectionViewDelegate, DataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HomeCollectionViewSections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        switch HomeCollectionViewSections(rawValue: section) {
        case .main:
            return 1
            
        case .trend:
            return trendMovieModel?.results.count ?? 0
            
        default:
            return 0
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch HomeCollectionViewSections(rawValue: indexPath.section) {
        case .main:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMainCollectionViewCell.identifier,
                                                                for: indexPath) as? HomeMainCollectionViewCell else {
                return HomeMainCollectionViewCell()
            }
            
            if let movie = trendMovieModel?.results.last,
               let posterPath = movie.posterPath {
                cell.updateContent(imageString: posterPath)
                cell.showVideo = { [weak self] in
                    self?.navigationController?.pushViewController(YoutubeWebViewController(movieId: movie.id),
                                                             animated: true)
                    
                }
            }
            
            
            return cell
            
        case .trend:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier,
                                                                for: indexPath) as? PosterCollectionViewCell else {
                return PosterCollectionViewCell()
            }
            
            if let path = trendMovieModel?.results[indexPath.item].posterPath {
                cell.updateContent(imageString: path)
            }
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                           withReuseIdentifier: TitleHeaderView.identifier,
                                                                           for: indexPath) as? TitleHeaderView else {
            return TitleHeaderView()
        }
        
        if let section = HomeCollectionViewSections(rawValue: indexPath.section),
           let title = section.title {
            header.updateContent(title: title)
        }
        
        return header
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        switch HomeCollectionViewSections(rawValue: indexPath.section) {
        case .trend:
            if let movie = trendMovieModel?.results[indexPath.row] {
                navigationController?.pushViewController(MovieDetailViewController(movieId: movie.id),
                                                         animated: true)
            }
        default:
            break
        }
    }
}

