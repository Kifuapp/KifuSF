//
//  TwoFactorAuthService+Moya.swift
//  KifuSF
//
//  Created by Erick Sanchez on 9/20/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import Moya

enum TwoFactorAuthEndPoints {
    case send(number: String)
    case validate(code: String, requestId: String)
}

extension TwoFactorAuthEndPoints: TargetType {
    var baseURL: URL {
        return URL(string: "https://chatter-ton.glitch.me/")!
    }
    
    var path: String {
        switch self {
        case .send:
            return "request"
        case .validate:
            return "check"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .send(let number):
            let body: [String: Any] = [
                "number": number
            ]
            
            return .requestParameters(parameters: body, encoding: JSONEncoding.default)
        case .validate(let code, let requestId):
            let body: [String: Any] = [
                "code": code,
                "request_id": requestId
            ]
            
            return .requestParameters(parameters: body, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
