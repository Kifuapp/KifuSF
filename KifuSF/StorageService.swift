//
//  StorageService.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 28/07/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage


struct StorageService {
    public static func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> ()) {
        guard let imageData = UIImageJPEGRepresentation(image, 0.1) else { return completion(nil) }
        
        reference.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            reference.downloadURL(completion: { (url, error) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return  completion(nil)
                }
                return completion(url)
            })
        }
    }
}
