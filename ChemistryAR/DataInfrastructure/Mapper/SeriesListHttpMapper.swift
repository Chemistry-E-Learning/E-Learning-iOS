//
//  SeriesListHttpMapper.swift
//  ChemistryAR
//
//  Created by NhatMinh on 14/11/2022.
//

import Foundation

struct SeriesListHttpMapper {
    static func map(entity: SeriesListHttpEntity) -> SeriesList {
        let programs = entity.programSeries.contents.map {
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
        let branches = entity.branchSeries.contents.map {
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
        let laws = entity.lawSeries.contents.map {
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
        let programSeries = CommonEntity<Series>(
            contents: programs,
            totalCount: entity.programSeries.totalCount,
            offset: entity.programSeries.offset,
            limit: entity.programSeries.limit
        )
        let branchSeries = CommonEntity<Series>(
            contents: branches,
            totalCount: entity.branchSeries.totalCount,
            offset: entity.branchSeries.offset,
            limit: entity.branchSeries.limit
        )
        let lawSeries = CommonEntity<Series>(
            contents: laws,
            totalCount: entity.lawSeries.totalCount,
            offset: entity.lawSeries.offset,
            limit: entity.lawSeries.limit
        )
        return SeriesList(
            programSeries: programSeries,
            branchSeries: branchSeries,
            lawSeries: lawSeries
        )
    }
}
