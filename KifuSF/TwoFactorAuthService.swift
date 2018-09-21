//
//  TwoFactorAuth.swift
//  KifuSF
//
//  Created by Erick Sanchez on 9/20/18.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import Moya

struct TwoFactorAuthService {
    struct TwoFactorAuthy {
        fileprivate let requestId: String
        
        fileprivate init(requestId: String) {
            self.requestId = requestId
        }
    }
    
    /**
     Once user has enter their phone number, use this method to send the given
     number a code.
     
     - parameter completion: if successful, an object containing required info
     will be sent back. Otherwise, nil.
     
     - Attention: the returned object in the closure is required to be sent when
     the code needs to be verified when using +validate(code:authy:!)
     */
    static func sendTextMessage(
        to number: String,
        completion: @escaping (TwoFactorAuthy?) -> Void) {
        let provider = MoyaProvider<TwoFactorAuthEndPoints>()
        
        provider.request(.send(number: number)) { (result) in
            switch result {
            case .success(let response):
                let data = response.data
                
                guard
                    let jsonResponse = try? JSONSerialization.jsonObject(
                        with: data,
                        options: .allowFragments
                        ) as! [String: Any],
                    let requestId = jsonResponse["request_id"] as! String? else {
                        assertionFailure("failed to decode data")
                        
                        return completion(nil)
                }
                
                let authy = TwoFactorAuthy(requestId: requestId)
                completion(authy)
            case .failure(let error):
                assertionFailure("something went wrong \(error.localizedDescription)")
                
                return completion(nil)
            }
        }
    }
    
    /**
     Use to check if the given code is valid
     
     - parameter authy: this object originates from the +sendTextMessage(to:completion:).
     This is required
     - parameter completion: if the given code is a match, the closure returns true.
     */
    static func validate(
        code: String,
        authy: TwoFactorAuthy,
        completion: @escaping (_ validated: Bool) -> Void) {
        let provider = MoyaProvider<TwoFactorAuthEndPoints>()
        provider.request(.validate(code: code, requestId: authy.requestId)) { (result) in
            switch result {
            case .success(let response):
                let data = response.data
                
                guard
                    let jsonReponse = try? JSONSerialization.jsonObject(
                        with: data,
                        options: .allowFragments
                        ) as! [String: Any],
                    let statusString = jsonReponse["status"] as! String?,
                    let status = Int(statusString) else {
                        assertionFailure("failed to decode data")
                        
                        return completion(false)
                }
                
                switch status {
                case 0:
                    completion(true)
                default:
                    completion(false)
                }
            case .failure(let error):
                assertionFailure("something went wrong \(error.localizedDescription)")
                
                return completion(false)
            }
        }
    }
}
