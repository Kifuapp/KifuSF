//
//  DonationRequestService.swift
//  KifuSF
//
//  Created by Noah Woodward on 1/9/19.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import Foundation
import Moya

struct DonationRequirementsService{
    // MARK: - Methods
    static func getRequirementsText(
        completion: @escaping (String?) -> Void) {
        let provider = MoyaProvider<DonationRequirementsEndpoints>()
        
        provider.request(.getRequirements()) { (result) in
            switch result {
            case .success(let response):
                let dataString = String(data: response.data, encoding: String.Encoding.utf8)
                completion(dataString)
                
            case .failure(let error):
                assertionFailure("something went wrong \(error.localizedDescription)")
                return completion(nil)
            }
        }
    }
}
