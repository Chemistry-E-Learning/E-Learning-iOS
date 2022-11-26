//
//  AppConstant.swift
//  ChemistryAR
//
//  Created by NhatMinh on 26/09/2022.
//

import Foundation

struct AppConstant {
    static let ChemistryElementResource = "Chemistry Element"
    static let ChemistryBookResource = "Chemistry Book"
    static let NoAsset = "Missing expected asset catalog resources."
    static let MaximumImageTracking = 2
    static let NoContent = "---"
    static let BackImage = "chevron.backward"
    static let PlayImage = "play.fill"
    static let BackSide = "backside"
    static let GasIndex = "2"
    static let ShortText = "lorem ipsum est"
    static let LongText = "Le lorem ipsum est, en imprimerie, une suite Le lorem ipsum est, en imprimerie, une suite"
    static let Paragraph = "Le lorem ipsum est, en imprimerie, une suite L rimerie, une suite Le lorem ipsum est, en imprimerie, une sui rimerie, une suite Le lorem ipsum est, en imprimerie, une suie lorem ipsum est, en imprimerie, une suite rimerie, une suite Le lorem ipsum est, en imprimerie, une sui "
}

struct IONModel {
    let symbol: String
    let electrolysis: String
}


// MARK: - Dummy Data
extension AppConstant {
    static let branchesDummyData = [
        Series(id: "1", seriesName: AppConstant.ShortText, description: nil, author: nil, coverImage: nil, thumbImage: nil, childSeriesNumber: nil),
        Series(id: "2", seriesName: AppConstant.ShortText, description: nil, author: nil, coverImage: nil, thumbImage: nil, childSeriesNumber: nil),
        Series(id: "3", seriesName: AppConstant.ShortText, description: nil, author: nil, coverImage: nil, thumbImage: nil, childSeriesNumber: nil),
        Series(id: "4", seriesName: AppConstant.ShortText, description: nil, author: nil, coverImage: nil, thumbImage: nil, childSeriesNumber: nil),
        Series(id: "5", seriesName: AppConstant.ShortText, description: nil, author: nil, coverImage: nil, thumbImage: nil, childSeriesNumber: nil),
        Series(id: "6", seriesName: AppConstant.ShortText, description: nil, author: nil, coverImage: nil, thumbImage: nil, childSeriesNumber: nil)
    ]
    static let elements = PeriodicElementList.readJSONFromFile()?.elements ?? []
    static let cations = [
        IONModel(symbol: "H", electrolysis: "+"),
        IONModel(symbol: "NH4", electrolysis: "+"),
        IONModel(symbol: "Li", electrolysis: "+"),
        IONModel(symbol: "Rb", electrolysis: "+"),
        IONModel(symbol: "K", electrolysis: "+"),
        IONModel(symbol: "Ba", electrolysis: "2+"),
        IONModel(symbol: "Sr", electrolysis: "2+"),
        IONModel(symbol: "Ca", electrolysis: "2+"),
        IONModel(symbol: "Na", electrolysis: "+"),
        IONModel(symbol: "Mg", electrolysis: "2+"),
        IONModel(symbol: "Be", electrolysis: "2+"),
        IONModel(symbol: "Al", electrolysis: "3+"),
        IONModel(symbol: "Mn", electrolysis: "2+"),
        IONModel(symbol: "Zn", electrolysis: "2+"),
        IONModel(symbol: "Cr", electrolysis: "2+"),
        IONModel(symbol: "Cr", electrolysis: "3+"),
        IONModel(symbol: "Fe", electrolysis: "2+"),
        IONModel(symbol: "Fe", electrolysis: "3+"),
        IONModel(symbol: "Cd", electrolysis: "2+"),
        IONModel(symbol: "Co", electrolysis: "2+"),
        IONModel(symbol: "Co", electrolysis: "3+"),
        IONModel(symbol: "Ni", electrolysis: "2+"),
        IONModel(symbol: "Sn", electrolysis: "2+"),
        IONModel(symbol: "Pb", electrolysis: "2+"),
        IONModel(symbol: "Cu", electrolysis: "2+"),
        IONModel(symbol: "Ag", electrolysis: "+"),
        IONModel(symbol: "Hg", electrolysis: "2+")
    ]
    static let anions = [
        IONModel(symbol: "I", electrolysis: "-"),
        IONModel(symbol: "S", electrolysis: "2-"),
        IONModel(symbol: "SO4", electrolysis: "2-"),
        IONModel(symbol: "HSO4", electrolysis: "-"),
        IONModel(symbol: "SO3", electrolysis: "2-"),
        IONModel(symbol: "ClO4", electrolysis: "-"),
        IONModel(symbol: "ClO3", electrolysis: "-"),
        IONModel(symbol: "NO3", electrolysis: "-"),
        IONModel(symbol: "NO2", electrolysis: "-"),
        IONModel(symbol: "PO4", electrolysis: "3-"),
        IONModel(symbol: "HPO4", electrolysis: "2-"),
        IONModel(symbol: "H2PO4", electrolysis: "-"),
        IONModel(symbol: "CH3COO", electrolysis: "2-"),
        IONModel(symbol: "Cr2O7", electrolysis: "2-"),
        IONModel(symbol: "CrO4", electrolysis: "-"),
        IONModel(symbol: "MnO4", electrolysis: "-"),
        IONModel(symbol: "CO3", electrolysis: "2-"),
        IONModel(symbol: "HCO3", electrolysis: "-"),
        IONModel(symbol: "SiO3", electrolysis: "2-")
    ]
    static let HtmlContent = """
<!DOCTYPE html>
  <html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <meta charset="UTF-8">
    <link href="https://fonts.googleapis.com/css2?family=Zen+Kaku+Gothic+Antique:wght&display=swap" rel="stylesheet">
    <style>
      #video1 {margin: 0 !important;width: 100%;}

h1 {
    background-color: #FFF7C3;
    border-left: 4px solid #FFD335;
    padding: 4px 8px;
    margin-top: 16px;
    margin-bottom: 0px;
    color: rgba(0, 0, 0, 0.8);
    font: -apple-system-title3;
    font-weight: 700;
}
h2, h3, h4, h5 {
    border-left: 4px solid #FFD335;
    padding-left: 8px;
    margin-top: 16px;
    margin-bottom: 0px;
    color: rgba(0, 0, 0, 0.8);
    font: -apple-system-headline;
}
* + h1 {
    margin-top: 48px;
}
* + h2, h3, h4, h5 {
    margin-top: 32px;
}
p, ol, ul {
    margin-top: 16px;
    margin-bottom: 0px;
    color: rgba(0, 0, 0, 0.8);
    font: -apple-system-body;
}
p {
    line-height: 1.5;
}
li > ul, li >  ol {
    margin-top: 0;
}
a {
    color: #176BEB;
}
strong {
    font-weight: 700;
}
img {
    display: block;
    margin: 16px auto 0;
    max-width: 100%;
    max-height: 520px;
    object-fit: contain;
}
img + br + img{
    margin-top: 0;
}

    </style>
  </head>
  <body>
    <p>Dummy Content</p>
  </body>
  </html>
"""
}
