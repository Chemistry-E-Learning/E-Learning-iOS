//
//  SeriesHttpMapper.swift
//  ChemistryAR
//
//  Created by NhatMinh on 14/11/2022.
//

import Foundation

struct SeriesHttpMapper {
    static func map(entities: CommonHttpEntity<SeriesHttpEntity>) -> CommonEntity<Series> {
        let contents = entities.contents.map {
            Series(
                id: $0.id,
                seriesName: $0.seriesName,
                description: $0.description,
                author: $0.author,
                coverImage: $0.coverImage,
                thumbImage: $0.thumbImage,
                childSeriesNumber: $0.childSeriesNumber
            )
        }
        return CommonEntity(
            contents: contents,
            totalCount: entities.totalCount,
            offset: entities.offset,
            limit: entities.limit
        )
    }
}
