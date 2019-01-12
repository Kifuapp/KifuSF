//
//  DonationRequirementsService.swift
//  KifuSF
//
//  Created by Noah Woodward on 1/9/19.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import Foundation
import Moya

// MARK: - DonationRequirementsEndpoints
enum DonationRequirementsEndpoints{
    case getRequirements()
}

// MARK: - TargetType
extension DonationRequirementsEndpoints: TargetType {
    var baseURL: URL {
        return URL(string: "https://chatter-ton.glitch.me")!
    }

    var path: String {
        switch self {
        case .getRequirements:
            return "donationsreq"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}
