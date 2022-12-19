//
//  VirtualLabView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 12/10/2022.
//

import SwiftUI

struct VirtualLabView: View {
    @StateObject private var viewModel = VirtualLabViewModel()
    @Binding var selectedTab: TabItem
    @State private var animationTask: DispatchWorkItem?
    @State private var chemicalLocation = CGPoint.zero
    @State private var instrumentLocation = CGPoint.zero
    @State private var locationOfSelectedItem = CGPoint.zero
    @State private var isDecant = false
    @State private var isShowInstrument = true
    @State private var isDragging = false
    @State private var chemicalColor = Color.clear
    @State private var selectedInstruments = [Instrument]()
    @State private var chemicalList = [Chemical]()
    @State private var reactants = [Chemical]()
    @State private var solidReactants = [Chemical]()
    @State private var selectedInstrument: Instrument?
    @State private var selectedChemical: Chemical?
    @State private var isLiquid = true

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                Color.virtualLabBGC
                makeDeskLabView(width: geo.size.width, height: geo.size.height * 0.1)
                    .offset(y: geo.size.height * 0.1)
                if isShowInstrument {
                    instrumentListView
                        .offset(y: geo.size.height * 0.08)
                } else {
                    makeListChemical(height: geo.size.height)
                }
                selectedInstrumentView
                    .offset(y: geo.size.height * 0.5)
                if viewModel.isCompleted && !viewModel.isLoading {
                    makeReactionEquationView()
                       .offset(y: geo.size.height * 0.2)
                }
            }
            .onAppear {
                GA4Manager.shared.trackScreenView(.virtualLab)
            }
            .onChange(of: selectedChemical) { newValue in
                if let item = newValue, reactants.count < 2, !reactants.contains(item) {
                    reactants.append(item)
                    if item.standardState == .solid {
                        solidReactants.append(item)
                    }
                    if reactants.count == 2 {
                        let reactantsFormula = reactants.map { item in
                            item.formula
                        }
                        viewModel.doGetReactionResult(with: reactantsFormula)
                    }
                }
            }
            .overlay(
                FloatButtonGroupView(
                    chemicals: $viewModel.chemicals,
                    isShowInstrument: $isShowInstrument,
                    chemicalList: $chemicalList,
                    selectedTab: $selectedTab
                )
                .padding(.leading, 16)
                .padding(.bottom, 20)
                ,alignment: .bottomLeading
            )
            .ignoresSafeArea(.all, edges: .all)
        }
    }
}

// MARK: - Variables View
private extension VirtualLabView {
    @ViewBuilder func makeInstrumentView(name: String) -> some View {
        switch name {
        case "beaker":
            beakerView
        case "flat-bottemed-flask":
            measuringCylinderView
        case "triangular-vase":
            alcoholLampView
        case "triangular-vase-2":
            flaskView
        default:
            EmptyView()
        }
    }

    var selectedInstrumentView: some View {
        ZStack {
            ForEach(selectedInstruments) { item in
                makeInstrumentView(name: item.name)
                    .customOffset(selectedInstrument == item ? instrumentLocation : item.location )
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                selectedInstrument = item
                                instrumentLocation = value.location
                            })
                            .onEnded({ value in
                                item.location = value.location
                                instrumentLocation = value.location
                            })
                    )
            }
        }
    }
    var beakerView: some View {
        BeakerShape()
            .stroke(.black, lineWidth: 1)
            .squareFrame(120)
            .background(
                ZStack {
                    Color.white.opacity(0.1)
                    WaterFlowAnimation(
                        isAnimating: $isDecant,
                        chemicalColor: chemicalColor.opacity(0.4),
                        size: CGSize(width: 120, height: 120)
                    )
                    ForEach(solidReactants) { item in
                        MetalGroupView(cmsColor: item.color)
                            .opacity(selectedChemical != item ? 1 : 0)
                            .offset(x: CGFloat(Int.random(in: -10...0)), y: CGFloat(Int.random(in: -10...10)))
                    }
                    .offset(y: 40)
                }
                .clipShape(BeakerShape())
            )
    }
    var measuringCylinderView: some View {
        BeakerShape()
            .stroke(.blue, lineWidth: 1)
            .squareFrame(120)
            .background(
                ZStack {
                    Color.white.opacity(0.1)
                    WaterFlowAnimation(
                        isAnimating: $isDecant,
                        chemicalColor: chemicalColor,
                        size: CGSize(width: 120, height: 120)
                    )
                }
            )
            .clipShape(BeakerShape())
    }
    var alcoholLampView: some View {
        BeakerShape()
            .stroke(.red, lineWidth: 1)
            .squareFrame(120)
            .background(
                ZStack {
                    Color.white.opacity(0.1)
                }
            )
            .clipShape(BeakerShape())
    }
    var flaskView: some View {
        BeakerShape()
            .stroke(.green, lineWidth: 1)
            .squareFrame(120)
            .background(
                ZStack {
                    Color.white.opacity(0.1)
                }
            )
            .clipShape(BeakerShape())
    }

    var instrumentListView: some View {
        HStack {
            ForEach(Instrument.laboratoryInstruments) { item in
                Button {
                    if !selectedInstruments.contains(item) {
                        selectedInstruments.append(item)
                    }
                } label: {
                    Image(item.image)
                        .resizable()
                        .scaledToFit()
                        .squareFrame(80)
                }
            }
        }
    }
}

// MARK: - Functions View
private extension VirtualLabView {
    func makeReactionEquationView() -> some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                if viewModel.chemicalEquation.count == 0 {
                    Text("\(Localization.noReactionTitle.localizedString.uppercased())!")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .bold))
                } else {
                    ForEach(viewModel.chemicalEquation, id: \.self) { equation in
                        Text(equation)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                    }
                }
            }
            .padding(.vertical, 32)
            .frame(width: getScreenBounds().width - 40)
            .background(
                ZStack(alignment: .topTrailing) {
                    Color.black.opacity(0.6)
                        .cornerRadius(10)
                    Button {
                        resetValue()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding(.top, 14)
                            .padding(.trailing, 12)
                            .scaleEffect(1.2)
                    }
                }
            )
        }
    }

    func makeDeskLabView(width: CGFloat, height: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(.white.opacity(0.2))
            .frame(width: width , height: height)
            .rotation3DEffect(.degrees(50), axis: (x: 1, y: 0, z: 0))
    }

    func makeListChemical(height: CGFloat) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(chemicalList) { item in
                    ZStack {
                        ImageFromUrlView(image: item.imageURL)
                            .squareFrame(80)
                            .overlay {
                                Text("\(item.formula)")
                                    .font(.system(size: 8, weight: .medium))
                                    .offset(y: 12)
                            }
                            .rotationEffect(.degrees(selectedChemical == item && isDecant ? -50 : 0))
                            .customOffset(selectedChemical == item ? chemicalLocation : CGPoint.zero)
                            .overlay (
                                makeDropAnimationView(chemical: item)
                                    .customOffset(selectedChemical == item ? chemicalLocation : CGPoint.zero)
                                , alignment: .leading
                            )
                            .gesture(
                                DragGesture()
                                    .onChanged({ value in
                                        animationTask?.cancel()
                                        selectedChemical = item
                                        chemicalLocation = value.location
                                    })
                                    .onEnded({ value in
                                        isLiquid = item.standardState == .liquid
                                        chemicalLocation = value.location
                                        handleAnimationTask()
                                    })
                            )

                    }
                }
                .offset(y: -height * 0.38)
            }
            .frame(height: UIScreen.main.bounds.height)
        }
    }

    @ViewBuilder func makeDropAnimationView(chemical: Chemical) -> some View {
        if selectedChemical == chemical {
            DropGroupView(
                isAnimating: $isDecant,
                isLiquid: $isLiquid,
                cmsColor: chemical.color,
                initialOffSet: CGSize.zero
            )
            .rotationEffect(.init(degrees: 180))
        }
    }
}

// MARK: - Animation Function
private extension VirtualLabView {
    func resetValue() {
        viewModel.isCompleted = false
        viewModel.chemicalEquation = []
        viewModel.reactantsResponse = []
        reactants = []
        solidReactants = []
        chemicalColor = .clear
    }

    func handleAnimationTask() {
        withAnimation(.easeOut(duration: 0.2)) {
            isDecant = true
        }
        animationTask = DispatchWorkItem {
            withAnimation(.easeInOut(duration: 0.3)) {
                if selectedChemical?.standardState == .liquid {
                    let color = Color(
                        hex: UInt(selectedChemical?.color.hexColor ?? "0xFFFFFF") ?? 0xFFFFFF,
                        alpha: selectedChemical?.color.opacity ?? 0
                    )
                    chemicalColor = color
                }
                isDecant = false
                chemicalLocation = CGPoint.zero
                selectedChemical = nil
                if reactants.count == 2 {
                    viewModel.isCompleted = true
                }
            }
        }
        guard let animationTaskUnwrap = animationTask else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: animationTaskUnwrap)
    }
}

class Instrument: Identifiable, Equatable  {
    var id = UUID()
    let name: String
    let image: String
    var location: CGPoint

    init(name: String, image: String, location: CGPoint) {
        self.name = name
        self.image = image
        self.location = location
    }

    static let laboratoryInstruments = [
        Instrument(name: "beaker", image: "beaker", location: CGPoint.zero),
        Instrument(name: "flat-bottemed-flask", image: "flat-bottemed-flask", location: CGPoint.zero),
        Instrument(name: "triangular-vase", image: "triangular-vase", location: CGPoint.zero),
        Instrument(name: "alcohol_lamp", image: "alcohol_lamp", location: CGPoint.zero)
    ]

    static func == (lhs: Instrument, rhs: Instrument) -> Bool {
        return lhs.name == rhs.name
    }
}
