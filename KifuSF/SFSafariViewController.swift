//
//  SFSafariViewController.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 03/01/2019.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import SafariServices

extension SFSafariViewController {
    convenience init?(website: URL.Websites) {
        guard let url = URL(website: website) else {
            return nil
        }

        self.init(url: url)
    }
}
