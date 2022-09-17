//
//  ServerConstant.swift
//  ChemistryAR
//
//  Created by NhatMinh on 17/09/2022.
//

import Foundation

struct ServerConstant {
    struct URLBase {
        static var baseAPIURL = "http://localhost:3000/api"
    }

    struct APIURL {
        static let category = ServerConstant.URLBase.baseAPIURL + "/category/%@/contents"
    }
}
