//
//  MovieDetailViewController.swift
//  MovieLog
//
//  Created by 최승범 on 6/26/24.
//

import UIKit
import SnapKit

final class MovieDetailViewController: BaseViewController {
    
    private lazy var recommendCollectionView = UICollectionView(frame: .zero,
                                                                collectionViewLayout: createCollectionViewLayout())
    
    private var movieModel: MovieCreditModel
    
    init(movieId: Int) {
        self.movieModel = MovieCreditModel(movieId: String(movieId))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .base
        
        configureCollectionView()
        fetchData()
        
    }
    
    override func configureHierarchy() {
        view.addSubview(recommendCollectionView)
    }
    
    override func configureLayout() {
        
        recommendCollectionView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureCollectionView() {
        recommendCollectionView.delegate = self
        recommendCollectionView.dataSource = self
        
        
        recommendCollectionView.register(OverviewCollectionViewCell.self,
                                         forCellWithReuseIdentifier: OverviewCollectionViewCell.identifier)
        recommendCollectionView.register(CastCollectionViewCell.self,
                                         forCellWithReuseIdentifier: CastCollectionViewCell.identifier)
        recommendCollectionView.register(PosterCollectionViewCell.self,
                                         forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        
        recommendCollectionView.register(TitleHeaderView.self,
                                         forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                         withReuseIdentifier: TitleHeaderView.identifier)
    }
    
}

extension MovieDetailViewController {
    
    private func fetchData() {
        let id = movieModel.movieId
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async {
            NetworkManager.shared.fetchData(MovieDetailDTO.self,
                                            router: .detail(id)) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let detailData):
                    movieModel.movieDetail = detailData
                    group.leave()
                    
                case .failure(let failure):
                    print(failure)
                    group.leave()
                }
                
                
            }
        }
        
        
        group.enter()
        DispatchQueue.global().async {
            NetworkManager.shared.fetchData(Casts.self,
                                            router: .credit(id)) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let castData):
                    movieModel.movieCast = castData
                    group.leave()
                    
                case .failure(let failure):
                    print(failure)
                    group.leave()
                }
                
                
            }
        }
        
        
        group.enter()
        DispatchQueue.global().async {
            NetworkManager.shared.fetchData(RecommendedMoviesDTO.self,
                                            router: .recommendedMovies(id)) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let recommedData):
                    movieModel.recommendedMovies = recommedData
                    group.leave()
                    
                case .failure(let failure):
                    print(failure)
                    group.leave()
                }
                
                
            }
        }
        
        
        group.enter()
        DispatchQueue.global().async {
            NetworkManager.shared.fetchData(SimilarMoviesDTO.self,
                                            router: .similarMovies(id)) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let similarData):
                    movieModel.similarMovies = similarData
                    group.leave()
                    
                case .failure(let failure):
                    print(failure)
                    group.leave()
                }
                
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.recommendCollectionView.reloadData()
        }
        
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let collectioViewCompositonalLayout = UICollectionViewCompositionalLayout {
            (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            return MovieCreditCollectionViewSections(rawValue: sectionIndex)?.layoutSection
        }
        

        
        return collectioViewCompositonalLayout
        
    }
    
}

//MARK: - collectionView Delegate Datasource
extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        var sectionsCount = MovieCreditCollectionViewSections.allCases.count
        
        if movieModel.movieCast?.cast.isEmpty ?? true {
            sectionsCount -= 1
        }
        
        if movieModel.similarMovies?.results.isEmpty ?? true {
            sectionsCount -= 1
        }
        
        if movieModel.recommendedMovies?.results.isEmpty ?? true {
            sectionsCount -= 1
        }
        
        return sectionsCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        switch MovieCreditCollectionViewSections(rawValue: section) {
        case .collectioViewHeader:
            return 1
        case .overview:
            return 1
        case .cast:
            return movieModel.movieCast?.cast.count ?? 0
        case .similarMovies:
            return movieModel.similarMovies?.results.count ?? 0
        case .recommendedMovies:
            return movieModel.recommendedMovies?.results.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch MovieCreditCollectionViewSections(rawValue: indexPath.section) {
        case .collectioViewHeader:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier,
                                                                for: indexPath) as? PosterCollectionViewCell else {
                return PosterCollectionViewCell()
            }
            
            if let data = movieModel.movieDetail?.backdropPath {
                cell.updateContent(imageString: data)
            }
            
            return cell
            
        case .overview:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OverviewCollectionViewCell.identifier,
                                                                for: indexPath) as? OverviewCollectionViewCell else {
                return OverviewCollectionViewCell()
            }
            
            if let data = movieModel.movieDetail?.overview {
                cell.updateContent(data: data)
            }
            
            return cell
            
        case .cast:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier,
                                                                for: indexPath) as? CastCollectionViewCell else {
                return CastCollectionViewCell()
            }
            
            if let data = movieModel.movieCast {
                cell.updateContent(data: data.cast[indexPath.item])
            }
            
            return cell
            
        case .similarMovies:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier,
                                                                for: indexPath) as? PosterCollectionViewCell else {
                return PosterCollectionViewCell()
            }
            
            if let data = movieModel.similarMovies?.results[indexPath.row],
               let posterPath = data.posterPath {
                cell.updateContent(imageString: posterPath)
            }
            
            return cell
            
        case .recommendedMovies:
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier,
                                                                for: indexPath) as? PosterCollectionViewCell else {
                return PosterCollectionViewCell()
            }
            
            if let data = movieModel.recommendedMovies?.results[indexPath.row],
               let posterPath = data.posterPath {
                cell.updateContent(imageString: posterPath)
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
        
        if let section = MovieCreditCollectionViewSections(rawValue: indexPath.section) {
            header.updateContent(title: section.sectionTitle)
        }
        
        return header
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch MovieCreditCollectionViewSections(rawValue: indexPath.section) {
        case .overview:
            if let cell = collectionView.cellForItem(at: indexPath) as? OverviewCollectionViewCell {
                cell.changeCellHeight()
                collectionView.reloadData()
            }
        default:
            break
        }
        
    }
    
}
