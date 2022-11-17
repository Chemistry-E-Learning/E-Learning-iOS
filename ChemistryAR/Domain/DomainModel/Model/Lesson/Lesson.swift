//
//  Lesson.swift
//  ChemistryAR
//
//  Created by NhatMinh on 16/11/2022.
//

import Foundation

struct Lesson: Identifiable {
    let id: String
    let lessonName: String
    let coverImageURL: String
    let videoURL: String?
    let content: String
    let duration: Int?
    let series: Series
    let lessonTag: [String]?

    static let emptyData = Lesson(
        id: "",
        lessonName: "",
        coverImageURL: "",
        videoURL: "",
        content: "",
        duration: nil,
        series: Series.emptyData,
        lessonTag: []
    )
}
