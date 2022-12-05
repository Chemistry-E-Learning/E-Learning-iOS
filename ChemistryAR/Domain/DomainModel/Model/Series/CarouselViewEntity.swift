//
//  CarouselViewEntity.swift
//  ChemistryAR
//
//  Created by NhatMinh on 04/12/2022.
//

import Foundation

struct CarouselViewEntity: Identifiable, Equatable {
    let id: String
    let title: String
    let author: String
    let mainImageURL: String
    let externalLink: String
    let content: String

    static var emptyData = CarouselViewEntity(
        id: "",
        title: "",
        author: AppConstant.NoContent,
        mainImageURL: "",
        externalLink: "",
        content: ""
    )
}
