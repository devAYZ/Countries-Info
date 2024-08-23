//
//  HomeViewModel.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 23/08/2024.
//

import Foundation

class HomeViewModel {
    
    // MARK: Properties
    private var networkClass: NetworkClassProtocol?
    var networkCallSuccess: ((CountriesResponseList?) -> Void)?
    var networkCallFailed: ((FError?) -> Void)?
    var showLoading: ((Bool) -> Void)?

    // MARK: Initialiser
    init(
        networkClass: NetworkClassProtocol = NetworkClass()
    ) {
        self.networkClass = networkClass
    }
    
    func fetchCountryList() {
        showLoading?(true)
        networkClass?.makeNetworkCall_AF(urlString: .allCountries) { [self] (response: FResponse<CountriesResponseList, FError>) in
            showLoading?(false)
            switch response.result {
            case .success(let data):
                networkCallSuccess?(data)
            case .failure(let error):
                networkCallFailed?(error)
            }
        }
    }
    
    private func fetchCountryList_V1() {
        networkClass?.makeNetworkCall_Native(urlString: .allCountries) { (result: Result<CountriesResponseList, NetworkError>) in
            switch result {
            case .failure(_):
                break
            case .success(_):
                break
            }
        }
    }
}
