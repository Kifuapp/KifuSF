//
//  NoDataItem.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 08/01/2019.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.

import Foundation

protocol NoDataItem {
    var noDataView: SlideView { get }
}

// checkout this article on why the default implementation was removed
// https://team.goodeggs.com/overriding-swift-protocol-extension-default-implementations-d005a4428bda
