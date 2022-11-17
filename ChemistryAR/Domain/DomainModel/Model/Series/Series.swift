//
//  Series.swift
//  ChemistryAR
//
//  Created by NhatMinh on 14/11/2022.
//

import Foundation

struct Series: Identifiable {
    let id: String
    let seriesName: String
    let description: String?
    let author: String?
    let coverImage: CMSImage?
    let thumbImage: CMSImage?
    let childSeriesNumber: Int?

    static let emptyData = Series(
        id: "",
        seriesName: AppConstant.ShortText,
        description: AppConstant.LongText,
        author: AppConstant.ShortText,
        coverImage: CMSImage(url: ""),
        thumbImage: CMSImage(url: ""),
        childSeriesNumber: 0
    )
}
