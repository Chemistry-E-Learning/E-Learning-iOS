//
//  GA4Manager.swift
//  ChemistryAR
//
//  Created by NhatMinh on 06/12/2022.
//

import Foundation

final class GA4Manager {
    static let shared = GA4Manager()

    struct VideoInfo {
        let itemID: String
        let genre: String
        let series: String
        let tag: String
    }

    struct LessonInfo {
        let itemID: String
        let genre: String
        let series: String
        let tag: String
    }

    struct NewsInfo {
        let itemID: String
        let newsName: String
        let author: String
    }

    // MARK: - Tracking
    func trackScreenView(
        _ screenView: GA4EventScreenView,
        parameters: [String: String] = [String: String]()
    ) {
        var parameterList = screenView.parameter
        if !parameters.isEmpty {
            parameterList = parameterList.merging(parameters) { first, _ in
                first
            }
        }
        let event = CustomEvent(
            customEventName: GA4EventName.screenView.name,
            parameterList: parameterList
        )
        AnalyticsManager.shared.sendEvent(event)
    }

    func trackCustomEvent(eventName: GA4EventName, parameters: [String: String]) {
        let event = CustomEvent(
            customEventName: eventName.name,
            parameterList: parameters
        )
        AnalyticsManager.shared.sendEvent(event)
    }
}

// MARK: Public Methods
extension GA4Manager {
    static func parameterNewsDetail(_ info: GA4Manager.NewsInfo) -> [String: String] {
        [
            GA4ParameterKey.itemID.key: info.itemID,
            GA4ParameterKey.newsName.key: info.newsName,
            GA4ParameterKey.author.key: info.author
        ]
    }

    static func parameterVideoInfo(_ info: GA4Manager.VideoInfo) -> [String: String] {
        [
            GA4ParameterKey.itemID.key: info.itemID,
            GA4ParameterKey.genre.key: info.genre,
            GA4ParameterKey.series.key: info.series,
            GA4ParameterKey.tag.key: info.tag
        ]
    }

    static func parameterLessonInfo(_ info: GA4Manager.LessonInfo) -> [String: String] {
        [
            GA4ParameterKey.itemID.key: info.itemID,
            GA4ParameterKey.genre.key: info.genre,
            GA4ParameterKey.series.key: info.series,
            GA4ParameterKey.tag.key: info.tag
        ]
    }
}

// MARK: Event Screen View
enum GA4EventScreenView: String {
    case newsDetail = "chemistry-ar-app/news"
    case lessonDetail = "chemistry-ar-app/lesson"
    case videoDetail = "chemistry-ar-app/video"
    case branchesOfChemistry = "chemistry-ar-app/branches"
    case chemistryLaws = "chemistry-ar-app/laws"
    case virtualLab = "chemistry-ar-app/virtualLab"
    case arCamera = "chemistry-ar-app/arCamera"
    case periodicTable = "chemistry-ar-app/periodicTable"
    case solubilityTable = "chemistry-ar-app/solubilityTable"
    case electrochemicalSeries = "chemistry-ar-app/electrochemicalSeries"
    case alkaneProperties = "chemistry-ar-app/alkaneProperties"
    case hydrocarbonChain = "chemistry-ar-app/hydrocarbonChain"

    var screenName: String {
        switch self {
        case .newsDetail:
            return "Chemistry News"
        case .lessonDetail:
            return "Lesson Detail"
        case .videoDetail:
            return "Video Detail"
        case .branchesOfChemistry:
            return "Branches Of Chemistry"
        case .chemistryLaws:
            return "Chemistry Laws"
        case .virtualLab:
            return "Virtual Lab"
        case .arCamera:
            return "AR Camera"
        case .periodicTable:
            return "Periodic Table"
        case .solubilityTable:
            return "Solubility Table"
        case .electrochemicalSeries:
            return "Electrochemical Series"
        case .alkaneProperties:
            return "Alkane Properties"
        case .hydrocarbonChain:
            return "Hydrocarbon Chain"
        }
    }

    var parameter: [String: String] {
        [
            GA4ParameterKey.screenName.rawValue: self.screenName,
            GA4ParameterKey.screenClass.rawValue: self.rawValue
        ]
    }
}

enum GA4EventName: String {
    case screenView = "screen_view"
    case selectContent = "select_content"
    case completeLesson = "complete_lesson"
    case completeNews = "complete_news"
    case completeVideo = "complete_video"

    var name: String {
        self.rawValue
    }
}

/// パラメータキー | Parameter key
enum GA4ParameterKey: String {
    case contentGroup = "content_group"
    case contentType = "content_type"
    case category = "category"
    case itemID = "item_id"
    case programName = "program_name"
    case firstTime = "first_time"
    case genre = "genre"
    case author = "author"
    case series = "series"
    case newsName = "news_name"
    case tag = "tag"
    case screenName = "screen_name"
    case screenClass = "screen_class"

    var key: String {
        self.rawValue
    }
}

enum GA4ParameterValue: String {
    case series = "Series"
    case video = "Video"
    case lesson = "Lesson"
    case seriesName = "Series Name"
    case news = "Chemistry News"

    var value: String {
        self.rawValue
    }
}
