//
//  ServerConstant.swift
//  ChemistryAR
//
//  Created by NhatMinh on 17/09/2022.
//

import Foundation

struct ServerConstant {
    struct URLBase {
        static var baseAPIURL = "http:/192.168.2.5:3000/api/v1"
    }

    struct APIURL {
        static let mainSeries = ServerConstant.URLBase.baseAPIURL + "/series"
        static let seriesDetail = ServerConstant.URLBase.baseAPIURL + "/series/%@"
        static let elementDetail = ServerConstant.URLBase.baseAPIURL + "/elements/%@"
        static let predictReaction = ServerConstant.URLBase.baseAPIURL + "/reaction"
        static let lessonsList = ServerConstant.URLBase.baseAPIURL + "/lessons/%@"
        static let lessonDetail = ServerConstant.URLBase.baseAPIURL + "/lesson/%@"
        static let chemicalsList = ServerConstant.URLBase.baseAPIURL + "/chemicals"
        static let entityDetail = ServerConstant.URLBase.baseAPIURL + "/entity/%@"
        static let newsDetail = ServerConstant.URLBase.baseAPIURL + "/news/%@"
    }
}
