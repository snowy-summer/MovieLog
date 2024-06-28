//
//  SearchViewController.swift
//  MovieLog
//
//  Created by 최승범 on 6/28/24.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher

final class SearchViewController: BaseViewController {
    
    private let searchBar = UISearchBar()
    private lazy var searchCollectionView = UICollectionView(frame: .zero,
                                                             collectionViewLayout: createCollectioViewLayout())
    private var searchModel: SearchDTO? {
        didSet {
            searchCollectionView.reloadData()
        }
    }
    
    private var page = 1 {
        didSet {
            
            guard let text = searchBar.text else { return }
            if text.trimmingCharacters(in: .whitespaces).isEmpty { return }
            fetchData(keyword: text)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }
    
//MARK: - Configurtion
    override func configureNavigationBar() {
        
        let popViewControllerItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                    style: .plain,
                                                    target: self,
                                                    action: #selector(popVC))
        
        navigationItem.leftBarButtonItem = popViewControllerItem
        navigationItem.titleView = searchBar
        
        navigationController?.navigationBar.tintColor = .baseFont
        
    }
    
    override func configureHierarchy() {
        
        view.addSubview(searchCollectionView)
    }
    
    override func configureUI() {
        super.configureUI()
        
        configureSearchBar()
        configureCollectionView()
    }
    
    override func configureLayout() {
        
        searchCollectionView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureCollectionView() {
        
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.prefetchDataSource = self
        
        searchCollectionView.register(PosterCollectionViewCell.self,
                                      forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
    }
    
    private func configureSearchBar() {
        
        searchBar.placeholder = "영화를 검색하세요"
        searchBar.delegate = self
        searchBar.autocorrectionType = .no
        searchBar.spellCheckingType = .no
    }
    
    private func createCollectioViewLayout() -> UICollectionViewLayout{
        
        let layout = UICollectionViewFlowLayout()
        let width = (view.frame.width - 40) / 3
        
        layout.itemSize = CGSize(width: width , height: width * 1.2)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10,
                                           left: 10,
                                           bottom: 10,
                                           right: 10)
    
        return layout
    }
    
//MARK: - Method
    private func fetchData(keyword: String) {
        
        NetworkManager.shared.fetchData(SearchDTO.self,
                                        router: .search(keyword: keyword, page: page)) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                
                if page == 1 {
                    searchModel = data
                    searchCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
                                                            at: .top,
                                                            animated: false)
                    
                } else {
                    searchModel?.results.append(contentsOf: data.results)
                }

            case .failure(let failure):
                print(failure)
            }
        }
    }
}

//MARK: - CollectionViewDelegate, CollectionViewDataSource

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchModel?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier,
                                                            for: indexPath) as? PosterCollectionViewCell else { return PosterCollectionViewCell() }
        
        if let searchModel = searchModel,
           let path = searchModel.results[indexPath.item].posterPath {
            cell.updateContent(imageString: path)
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDataSourcePrefetching

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView,
                        prefetchItemsAt indexPaths: [IndexPath]) {
        
        for item in indexPaths {
            if page <= searchModel!.totalPages && searchModel!.results.count - 3 == item.row {
                page += 1
            }
        }
        
        
    }
}

//MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
    }
}

