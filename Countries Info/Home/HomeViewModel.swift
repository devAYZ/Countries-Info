//
//  HomeViewModel.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 23/08/2024.
//

import Foundation
import Alamofire

protocol HomeView {
    func networkCallSuccess(data: CountriesResponseList?)
    func networkCallFailed(error: FError?)
}

typealias FError = AFError
typealias FResponse = DataResponse

class HomeViewModel {
    
    // MARK: Properties
    var networkClass: NetworkClassProtocol?
    var showLoading: ((Bool) -> Void)?
    var view: HomeView?

    // MARK: Initialiser
    init(
        networkClass: NetworkClassProtocol = NetworkClass()
    ) {
        self.networkClass = networkClass
    }
    
    func attachView(view: HomeView) {
        self.view = view
    }
    
    func fetchCountryList() {
        showLoading?(true)
        networkClass?.makeNetworkCall_AF(urlString: .allCountries) { [self] (response: FResponse<CountriesResponseList, FError>) in
            showLoading?(false)
            switch response.result {
            case .success(let data):
                view?.networkCallSuccess(data: data
                    .filter { $0.currencies != nil }
                    .sorted(by: { $0.name?.common ?? "" < $1.name?.common ?? "" })
                )
            case .failure(let error):
                view?.networkCallFailed(error: error)
            }
        }
    }
}
