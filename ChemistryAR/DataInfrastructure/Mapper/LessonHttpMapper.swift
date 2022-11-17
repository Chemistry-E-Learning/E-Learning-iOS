//
//  LessonHttpMapper.swift
//  ChemistryAR
//
//  Created by NhatMinh on 16/11/2022.
//

import Foundation

struct LessonHttpMapper {
    static func map(entity: LessonHttpEntity) -> Lesson {
        return Lesson(
            id: entity.id,
            lessonName: entity.lessonName,
            coverImageURL: entity.coverImage.url,
            videoURL: entity.videoURL,
            content: entity.content,
            duration: entity.duration,
            series: LessonHttpMapper.seriesMap(entity: entity.series),
            lessonTag: entity.lessonTag
        )
    }

    static func map(entities: CommonHttpEntity<LessonHttpEntity>) -> CommonEntity<Lesson> {
        let contents = entities.contents.map {
            Lesson(
                id: $0.id,
                lessonName: $0.lessonName,
                coverImageURL: $0.coverImage.url,
                videoURL: $0.videoURL,
                content: $0.content,
                duration: $0.duration,
                series: LessonHttpMapper.seriesMap(entity: $0.series),
                lessonTag: $0.lessonTag
            )
        }
        return CommonEntity(
            contents: contents,
            totalCount: entities.totalCount,
            offset: entities.offset,
            limit: entities.limit
        )
    }

    static func seriesMap(entity: SeriesHttpEntity) -> Series {
        return Series(
            id: entity.id,
            seriesName: entity.seriesName,
            description: entity.description,
            author: entity.author,
            coverImage: entity.coverImage,
            thumbImage: entity.thumbImage,
            childSeriesNumber: entity.childSeriesNumber
        )
    }
}
