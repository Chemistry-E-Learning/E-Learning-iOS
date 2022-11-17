//
//  LessonHttpEntity.swift
//  ChemistryAR
//
//  Created by NhatMinh on 16/11/2022.
//

import Foundation

struct LessonHttpEntity: Codable {
    let id: String
    let lessonName: String
    let coverImage: CMSImage
    let videoURL: String?
    let content: String
    let duration: Int?
    let series: SeriesHttpEntity
    let lessonTag: [String]?
}
