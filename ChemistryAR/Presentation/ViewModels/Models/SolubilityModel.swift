//
//  SolubilityModel.swift
//  ChemistryAR
//
//  Created by NhatMinh on 01/11/2022.
//

import Foundation
import SwiftUI

struct SolubilityModelList: Codable, Equatable {
    var data: [SolubilityModel]
}

extension SolubilityModelList {
    func solubilityModelMatrix() -> Matrix<SolubilityModel> {
        var elementMatrix: Matrix<SolubilityModel> = Matrix(
            rows: 19,
            columns: 27,
            defaultValue: SolubilityModel.dummyModel
        )
        for e in data {
            elementMatrix[e.yPos - 1 ,e.xPos - 1] = e
        }
        return elementMatrix
    }
}

struct SolubilityModel: Codable, Equatable, Hashable {
    let symbol: String
    let xPos: Int
    let yPos: Int

    static let dummyModel = SolubilityModel(
        symbol: "-",
        xPos: 1,
        yPos: 1
    )
}

extension SolubilityModel {
    func getColor() -> Color {
        switch self.symbol {
        case "S":
            return .blue
        case "SS":
            return .green
        case "I":
            return .yellow
        case "D":
            return .red
        case "-":
            return .gray
        default:
            return .gray
        }
    }

    func getTitle() -> String {
        switch self.symbol {
        case "S":
            return Localization.soluble.localizedString
        case "SS":
            return Localization.slightlySoluble.localizedString
        case "I":
            return Localization.insoluble.localizedString
        case "D":
            return Localization.decomposesInWater.localizedString
        case "-":
            return Localization.unavailableSoluble.localizedString
        default:
            return Localization.unavailableSoluble.localizedString
        }
    }
}

extension SolubilityModelList {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SolubilityModelList.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(data: [SolubilityModel]? = nil) -> SolubilityModelList {
        return SolubilityModelList(data: data ?? self.data)
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }

    static func readJSONFromFile(fileName: String = "SolubilityTableJSON") -> SolubilityModelList? {
        var json: SolubilityModelList?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                print("MinhNN- \(String(decoding: data, as: UTF8.self))")
                json = try? SolubilityModelList(data: data)
            } catch {
                // Handle error here
            }
        }
        return json
    }
}

extension SolubilityModel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SolubilityModel.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(symbol: String, xPos: Int, yPos: Int) -> SolubilityModel {
        return SolubilityModel(symbol: symbol, xPos: xPos, yPos: yPos)
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
