//
//  SeriesListHttpEntity.swift
//  ChemistryAR
//
//  Created by NhatMinh on 14/11/2022.
//

import Foundation

struct SeriesListHttpEntity: Codable {
    let programSeries: CommonHttpEntity<SeriesHttpEntity>
    let branchSeries: CommonHttpEntity<SeriesHttpEntity>
    let chemistryNews: CommonHttpEntity<NewsHttpEntity>
    let lawSeries: CommonHttpEntity<SeriesHttpEntity>
}
