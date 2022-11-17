//
//  CommonEntity.swift
//  ChemistryAR
//
//  Created by NhatMinh on 14/11/2022.
//

import Foundation

struct CommonEntity<T> {
    let contents: [T]
    let totalCount: Int
    let offset: Int?
    let limit: Int?
}
