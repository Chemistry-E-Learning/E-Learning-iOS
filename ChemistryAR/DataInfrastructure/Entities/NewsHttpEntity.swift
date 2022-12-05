//
//  NewsHttpEntity.swift
//  ChemistryAR
//
//  Created by NhatMinh on 05/12/2022.
//

import Foundation

struct NewsHttpEntity: Codable {
    let id: String
    let title: String
    let author: String?
    let mainImage: CMSImage
    let externalLink: String?
    let content: String?
}
