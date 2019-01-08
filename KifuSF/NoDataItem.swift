//
//  NoDataItem.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 08/01/2019.
//  Copyright © 2019 Alexandru Turcanu. All rights reserved.
//

import Foundation

protocol NoDataItem {
    var noDataView: SlideView { get }
}

extension NoDataItem {
    var noDataView: SlideView {
        return SlideView(image: .kfNoDataIcon,
                         title: "No Data",
                         description: "Go to..")
    }
}
