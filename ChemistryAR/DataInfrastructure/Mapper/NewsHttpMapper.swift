//
//  NewsHttpMapper.swift
//  ChemistryAR
//
//  Created by NhatMinh on 05/12/2022.
//

import Foundation

struct NewsHttpMapper {
    static func map(entities: CommonHttpEntity<NewsHttpEntity>) -> CommonEntity<CarouselViewEntity> {
        let contents = entities.contents.map {
            CarouselViewEntity(
                id: $0.id,
                title: $0.title,
                author: $0.author ?? AppConstant.NoContent,
                mainImageURL: $0.mainImage.url,
                externalLink: $0.externalLink ?? "",
                content: $0.content ?? ""
            )
        }
        return CommonEntity(
            contents: contents,
            totalCount: entities.totalCount,
            offset: entities.offset,
            limit: entities.limit
        )
    }
    
    static func map(entity: NewsHttpEntity) -> CarouselViewEntity {
        return CarouselViewEntity(
            id: entity.id,
            title: entity.title,
            author: entity.author ?? AppConstant.NoContent,
            mainImageURL: entity.mainImage.url,
            externalLink: entity.externalLink ?? "",
            content: entity.content ?? ""
        )
    }
}
