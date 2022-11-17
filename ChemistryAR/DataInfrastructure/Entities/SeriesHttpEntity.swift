//
//  SeriesHttpEntity.swift
//  ChemistryAR
//
//  Created by NhatMinh on 14/11/2022.
//

import Foundation

struct SeriesHttpEntity: Codable {
    let id: String
    let seriesName: String
    let description: String?
    let author: String?
    let coverImage: CMSImage?
    let thumbImage: CMSImage?
    let childSeriesNumber: Int?
}

struct CMSImage: Codable {
    let url: String
}
