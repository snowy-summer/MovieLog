//
//  YoutubeWebViewController.swift
//  MovieLog
//
//  Created by 최승범 on 7/1/24.
//

import UIKit
import WebKit

final class YoutubeWebViewController: BaseViewController {
    
    private struct VideoModel {
        let id: String
        var videoInformation: VideoDTO?
    }
    
    private let webView = WKWebView()
    private var videoModel: VideoModel
    private let emptyLabel = UILabel()
    
    init(movieId: Int) {
        self.videoModel = VideoModel(id: String(movieId))
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.fetchData(VideoDTO.self,
                                        router: .video(videoModel.id)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                videoModel.videoInformation = data
                
                if let videoMM = videoModel.videoInformation {
                    if videoMM.results.isEmpty {
                        emptyLabel.isHidden = false
                        return
                    }
                    
                    let request = WebViewRouter.youtube(videoMM.results[0].key).request
                    webView.load(request)
                    
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    override func configureNavigationBar() {
        
        let popViewControllerItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                    style: .plain,
                                                    target: self,
                                                    action: #selector(popVC))
        
        navigationItem.leftBarButtonItem = popViewControllerItem
        
        navigationController?.navigationBar.tintColor = .baseFont
        
    }
    
    
    override func configureHierarchy() {
        
        view.addSubview(webView)
        view.addSubview(emptyLabel)
    }
    
    override func configureUI() {
        super.configureUI()
        
        emptyLabel.text = "준비된 영상이 없습니다."
        emptyLabel.textColor = .black
        emptyLabel.isHidden = true
    }
    
    override func configureLayout() {
        
        webView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
