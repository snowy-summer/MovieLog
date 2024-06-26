//
//  ViewController.swift
//  MovieLog
//
//  Created by 최승범 on 6/25/24.
//

import UIKit

final class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.fetchData(SearchDTO.self,
                                        router: .search("소리")) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let failure):
                print(failure)
            }
        }
    }


}

