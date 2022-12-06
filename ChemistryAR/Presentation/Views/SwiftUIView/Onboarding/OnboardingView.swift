//
//  OnboardingView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 04/10/2022.
//

import SwiftUI

struct OnboardingView: View {
    @State private var offset: CGFloat = 0
    var body: some View {
        OffsetPageTabView(offset: $offset) {
            HStack(spacing: 0) {
                ForEach(BoardingModel.screens) { screen in
                    VStack(spacing: 16) {
                        Image(screen.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .squareFrame(getScreenBounds().width * 0.6)
                            .offset(y: -getScreenBounds().width * 0.46)
                        VStack(alignment: .leading, spacing: 12) {
                            Text(screen.title)
                                .font(.largeTitle.bold())
                                .foregroundColor(.white)
                            Text(screen.description)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .offset(y: -40)
                    }
                    .padding()
                    .frame(width: getScreenBounds().width)
                    .frame(maxHeight: .infinity)
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 50)
                .fill(.white)
                .frame(
                    width: getScreenBounds().width - 100,
                    height: getScreenBounds().width - 100
                )
                .scaleEffect(2)
                .rotationEffect(.init(degrees: getRotation()))
                .rotationEffect(.init(degrees: 35))
                .offset(y: -getScreenBounds().width + 20)
        )
        .background(
            backgroundView
        )
        .ignoresSafeArea(.container, edges: .all)
        .overlay {
            VStack(spacing: 28) {
                Spacer()
                if getIndex() == 2 {
                    Button {
                        UserDefaultsData.shared.isFirstLaunch = false
                        AppState.shared.route()
                    } label: {
                        HStack {
                            Spacer()
                            Text(Localization.startButtonTitle.localizedString.uppercased())
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .padding(.vertical, 12)
                            Spacer()
                        }
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal, 20)
                    }
                }
                HStack(spacing: 8) {
                    ForEach(BoardingModel.screens.indices, id: \.self) { index in
                        Circle()
                            .fill(.white)
                            .opacity(index == getIndex() ? 1 : 0.4)
                            .squareFrame(8)
                            .scaleEffect(index == getIndex() ? 1.3 : 0.85)
                            .animation(.easeInOut, value: getIndex())
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 40)
            }
        }
    }
}

// MARK: - Logic Function
private extension OnboardingView {
    @ViewBuilder var backgroundView: some View {
        if getIndex() >= 0 && getIndex() < BoardingModel.screens.count {
            BoardingModel.screens[getIndex()].bgColor
                .animation(.easeInOut, value: getIndex())
        }
    }
    func getIndex() -> Int {
        let progress = (offset / getScreenBounds().width).rounded()
        return Int(progress)
    }

    func getRotation() -> Double {
        let progress = offset / (getScreenBounds().width * 4)
        let rotation = Double(progress) * 360
        return rotation
    }
}
