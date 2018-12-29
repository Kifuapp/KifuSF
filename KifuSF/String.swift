//
//  String.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 17/12/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

extension String {
    func deleteOccurrences(of characters: [Character]) -> String {
        return self.filter { (character) -> Bool in
            !characters.contains(character)
        }
    }
}
