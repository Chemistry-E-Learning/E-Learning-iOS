//
//  VirtualLabView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 12/10/2022.
//

import SwiftUI

struct VirtualLabView: View {
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
    @State private var chemicalList = Chemical.liquid
    @State private var reactants = [Chemical]()
    @State private var solidReactants = [Chemical]()
    @State private var selectedInstrument: Instrument?
    @State private var selectedChemical: Chemical?
    @State private var isLiquid = true

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                Color.virtualLabBGC
                makeDeskLabView(width: geo.size.width, height: geo.size.height * 0.1)
                    .offset(y: -geo.size.height * 0.8)
                if isShowInstrument {
                    instrumentListView
                        .offset(y: -geo.size.height * 0.84)
                } else {
                    makeListChemical(height: geo.size.height)
                }
                makeReactionEquationView()
                    .offset(y: -geo.size.height * 0.76)
                selectedInstrumentView
                    .offset(y: -geo.size.height * 0.4)
            }
            .onChange(of: selectedChemical) { newValue in
                if let item = newValue, !reactants.contains(item) {
                    reactants.append(item)
                    if item.category == .solid {
                        solidReactants.append(item)
                    }
                }
            }
            .overlay(
                FloatButtonGroupView(
                    isShowInstrument: $isShowInstrument,
                    chemicalList: $chemicalList,
                    selectedTab: $selectedTab
                )
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
                    ForEach(solidReactants, id: \.self) { item in
                        MetalGroupView(color: item.color)
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
        Text("2HCL + Na2CO3 = H20 + CO2 + 2NaCL")
            .foregroundColor(.white)
            .font(.system(size: 16, weight: .bold))
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
                ForEach(chemicalList, id: \.self) { item in
                    ZStack {
                        Image(item.image)
                            .resizable()
                            .scaledToFill()
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
                                        isLiquid = item.category == .liquid
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
                chemicalColor: chemical.color,
                initialOffSet: CGSize.zero
            )
            .rotationEffect(.init(degrees: 180))
        }
    }
}

// MARK: - Animation Function
private extension VirtualLabView {
    func handleAnimationTask() {
        withAnimation(.easeOut(duration: 0.2)) {
            isDecant = true
        }
        animationTask = DispatchWorkItem {
            withAnimation(.easeInOut(duration: 0.3)) {
                if selectedChemical?.category == .liquid {
                    chemicalColor = selectedChemical?.color ?? .clear
                }
                isDecant = false
                chemicalLocation = CGPoint.zero
                selectedChemical = nil
            }
        }
        guard let animationTaskUnwrap = animationTask else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: animationTaskUnwrap)
    }
}



struct Chemical: Hashable {
    let name: String
    let formula: String
    let image: String
    let color: Color
    let category: ChemicalState
    let subCategory: ChemicalCategory

    static let liquid = [
        Chemical(name: "Acid Sulfuric", formula: "H2SO4", image: "yellow-acid", color: .yellow, category: .liquid, subCategory: .acid),
        Chemical(name: "Acid hydrochloric", formula: "HCL", image: "yellow-acid", color: .yellow, category: .liquid, subCategory: .acid),
        Chemical(name: "Acid Nitric", formula: "HNO3", image: "hno3", color: .brown, category: .liquid, subCategory: .acid),
    ]

    static let gas = [
        Chemical(name: "Acid Sulfuric", formula: "H2", image: "yellow-acid", color: .clear, category: .gas, subCategory: .gas),
        Chemical(name: "Acid hydrochloric", formula: "O2", image: "yellow-acid", color: .clear, category: .gas, subCategory: .gas),
        Chemical(name: "Acid Nitric", formula: "CO2", image: "hno3", color: .clear, category: .gas, subCategory: .gas),
    ]

    static let solid = [
        Chemical(name: "Acid Sulfuric", formula: "Cu", image: "yellow-acid", color: .brown, category: .solid, subCategory: .metal),
        Chemical(name: "Acid hydrochloric", formula: "Fe", image: "yellow-acid", color: .red, category: .solid, subCategory: .metal),
        Chemical(name: "Acid Nitric", formula: "Ag", image: "hno3", color: .gray, category: .solid, subCategory: .metal),
    ]
}

enum ChemicalState {
    case liquid
    case solid
    case gas
}

enum ChemicalCategory {
    case acid
    case base
    case salt
    case metal
    case gas
    case oxide
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
        Instrument(name: "triangular-vase-2", image: "triangular-vase", location: CGPoint.zero)
    ]

    static func == (lhs: Instrument, rhs: Instrument) -> Bool {
        return lhs.name == rhs.name
    }
}
