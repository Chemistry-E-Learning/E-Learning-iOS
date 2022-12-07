//
//  SolubilityTable.swift
//  ChemistryAR
//
//  Created by NhatMinh on 01/11/2022.
//

import SwiftUI

struct SolubilityTableView: View {
    @Binding var isShowInformationSheet: Bool
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let solubilityInformations = [
        SolubilityModel(symbol: "S", xPos: 0, yPos: 0),
        SolubilityModel(symbol: "I", xPos: 0, yPos: 0),
        SolubilityModel(symbol: "SS", xPos: 0, yPos: 0),
        SolubilityModel(symbol: "D", xPos: 0, yPos: 0),
        SolubilityModel(symbol: "-", xPos: 0, yPos: 0),
    ]
    private let elementList = SolubilityModelList.readJSONFromFile()?.solubilityModelMatrix()
    ?? SolubilityModelList(data: []).solubilityModelMatrix()
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                makeSolubilityTableView(height: geo.size.height)
                    .onTapGesture {
                        withAnimation {
                            isShowInformationSheet = false
                        }
                    }
            }
        }
        .onAppear {
            GA4Manager.shared.trackScreenView(.solubilityTable)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
    }
}

private extension SolubilityTableView {
    func makeInformationView(height: CGFloat) -> some View {
        LazyVGrid(columns: columns, alignment: .leading)  {
            ForEach(solubilityInformations, id: \.self) { item in
                HStack {
                    makeSolubilityItemView(item: item, size: CGSize(width: 52, height: 52))
                        .background(Color.c1E2128)
                    Text(item.getTitle())
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                    Spacer()
                }
            }
        }
            .padding(.top, -48)
            .padding(.leading, 36)
    }

    func makeSolubilityTableView(height: CGFloat) -> some View {
        ScrollView([.vertical], showsIndicators: false) {
            VStack(alignment: .leading) {
                HStack(alignment: .top, spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        emptyCell
                        ForEach(Array(AppConstant.anions.enumerated()), id: \.offset) { index, anion in
                            makeIonItemView(item: anion, isCation: false)
                        }
                    }
                    ScrollView([.horizontal], showsIndicators: false)  {
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 0) {
                                ForEach(Array(AppConstant.cations.enumerated()), id: \.offset) { index, cation in
                                    makeIonItemView(item: cation, isCation: true)
                                }
                            }
                            ForEach(0...elementList.rows - 1, id: \.self) { i in
                                HStack(alignment: .center, spacing: 4) {
                                    ForEach(0...elementList.columns - 1, id: \.self) { j in
                                        makeSolubilityItemView(item: elementList[i, j])
                                    }
                                }
                            }
                            Spacer()
                        }
                        .frame(height: height)
                    }
                }
                makeInformationView(height: height)
            }
        }
        .background(
            Color.c2E2E3A
        )
    }

    func makeIonItemView(item: IONModel, isCation: Bool) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 1) {
            Text(item.symbol)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.white.opacity(0.8))
             Text(item.electrolysis)
                .foregroundColor(.white.opacity(0.8))
                .font(.system(size: 10, weight: .bold))
            .offset(y: -5)
        }
        .frame(width: isCation ? 52 : 80, height: 38)
        .border(.gray, width: 1)
        .background(Color.c1E2128)
    }

    var emptyCell: some View {
        Rectangle()
            .fill(Color.c1E2128)
            .frame(width: 80, height: 38)
            .border(.gray, width: 1)
    }

    func makeSolubilityItemView(
        item: SolubilityModel,
        size: CGSize = CGSize(width: 50, height: 38)
    ) -> some View {
        VStack(spacing: 0) {
            Spacer()
            Text(item.symbol)
                .foregroundColor(item.getColor())
                .font(.system(size: 16, weight: .medium))
            Spacer()
            Rectangle()
                .fill(item.getColor())
                .frame(width: size.width, height: 2)
        }
        .frame(width: size.width, height: size.height)
    }
}
// 1 -> 14 ..... 15 -> 19 <=> 18 -> 23
