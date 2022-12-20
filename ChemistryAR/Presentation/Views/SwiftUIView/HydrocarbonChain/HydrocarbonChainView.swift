//
//  HydrocarbonChainView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 04/12/2022.
//

import SwiftUI

struct HydrocarbonChainView: View {
    @Binding var isShowWikipediaView: Bool
    private let bgGradient = LinearGradient(
        colors: [Color.c1A1F2C.opacity(0.8), Color.c1A1F2C],
        startPoint: .top,
        endPoint: .bottom
    )
    private let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]

    var body: some View {
        GeometryReader { geo in
            ZStack {
                NavigationLink(
                    destination: NavigationLazyView(
                        ElementWikipediaView(
                            isPushToWikipediaView: $isShowWikipediaView,
                            url: "https://en.wikipedia.org/wiki/Polycyclic_aromatic_hydrocarbon"
                        )
                    ),
                    isActive: $isShowWikipediaView
                ) {
                    EmptyView()
                }
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 1)  {
                        ForEach(ChainModel.data) { item in
                            makeHydrocarbonChainItem(
                                chain: item,
                                width: geo.size.width
                            )
                        }
                    }
                }
            }
        }
        .onAppear {
            GA4Manager.shared.trackScreenView(.hydrocarbonChain)
        }
    }
}

private extension HydrocarbonChainView {
    func makeHydrocarbonChainItem(chain: ChainModel, width: CGFloat) -> some View {
        VStack(spacing: 0) {
            Image(chain.image)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 120)
                .frame(width: width / 2 - 1, height: width / 3)
                .background(bgGradient)
                .foregroundColor(chain.color)
            Rectangle()
                .fill(chain.color)
                .frame(width: width / 2, height: 3)
            HStack(spacing: 16) {
                Circle()
                    .fill(chain.color)
                    .overlay {
                        Text(String(chain.name.first ?? String.Element("")))
                            .font(.system(size: 20, weight: .bold))
                    }
                    .squareFrame(40)
                    .padding(.leading, 16)
                VStack(alignment: .leading, spacing: 4) {
                    Text(chain.name)
                        .font(.system(size: 16, weight: .bold))
                    Text(chain.parameter)
                        .font(.system(size: 14, weight: .medium))
                }
                .padding(.trailing, 8)
                Spacer()
            }
            .frame(width: width / 2 - 1, height: 70)
            .foregroundColor(.white)
            .background(Color.c1A1F2C.opacity(0.8))
        }
    }
}

struct ChainModel: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let parameter: String
    let color: Color

    static let data = [
        ChainModel(
            name: "Naphthalene",
            image: "naphthalene",
            parameter: "0.0031g/100ml",
            color: Color(hex: 0xFCA118)
        ),
        ChainModel(
            name: "Acenaphthene",
            image: "acenaphthene",
            parameter: "0.00347g/100ml",
            color: Color(hex: 0x358210)
        ),
        ChainModel(
            name: "Fluorite",
            image: "indeno",
            parameter: "0.000019g/100ml",
            color: Color(hex: 0xB16686)
        ),
        ChainModel(
            name: "Phenanthrene",
            image: "phenanthrene",
            parameter: "0.000018g/100ml",
            color: Color(hex: 0xA6E342)
        ),
        ChainModel(
            name: "Anthracene",
            image: "anthracene",
            parameter: "0.0031g/100ml",
            color: Color(hex: 0x7117B8)
        ),
        ChainModel(
            name: "Fluoranthene",
            image: "fluoranthene",
            parameter: "0.00265g/100ml",
            color: Color(hex: 0xFA814D)
        ),
        ChainModel(
            name: "Pyrene",
            image: "pyrene",
            parameter: "0.0031g/100ml",
            color: Color(hex: 0x92B0FB)
        ),
        ChainModel(
            name: "Benzo(a)",
            image: "benzo-a",
            parameter: "0.000014g/100ml",
            color: Color(hex: 0xE8DB64)
        ),
        ChainModel(
            name: "Chrysene",
            image: "chrysene",
            parameter: "0.000188g/100ml",
            color: Color(hex: 0xFCA118)
        ),
        ChainModel(
            name: "Benzo(b)",
            image: "benzo-b",
            parameter: "0.0031g/100ml",
            color: Color(hex: 0xA6E342)
        ),
        ChainModel(
            name: "Benzo(k)",
            image: "benzo-k",
            parameter: "0.0031g/100ml",
            color: Color(hex: 0xB16686)
        ),
        ChainModel(
            name: "Dibenzo(a,h)",
            image: "dibenzo",
            parameter: "0.0031g/100ml",
            color: Color(hex: 0x358210)
        ),
        ChainModel(
            name: "Benzo(ghi)",
            image: "benzo-ghi",
            parameter: "0.0031g/100ml",
            color: Color(hex: 0xB16686)
        ),
        ChainModel(
            name: "Indeno(1,2,3)",
            image: "indeno",
            parameter: "0.0031g/100ml",
            color: Color(hex: 0xFCA118)
        )
    ]
}
