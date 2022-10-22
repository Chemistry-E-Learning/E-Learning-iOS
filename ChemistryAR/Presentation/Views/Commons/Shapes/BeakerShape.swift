//
//  BeakerShape.swift
//  ChemistryAR
//
//  Created by NhatMinh on 19/10/2022.
//

import SwiftUI

struct BeakerShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height

        path.move(to: CGPoint(x: 0.12637*width, y: 0.01648*height))
        path.addLine(to: CGPoint(x: 0.19231*width, y: 0.17033*height))
        path.addLine(to: CGPoint(x: 0.19231*width, y: 0.89561*height))
        path.addCurve(to: CGPoint(x: 0.28022*width, y: 0.98352*height), control1: CGPoint(x: 0.19231*width, y: 0.94396*height), control2: CGPoint(x: 0.23187*width, y: 0.98352*height))
        path.addLine(to: CGPoint(x: 0.71978*width, y: 0.98352*height))
        path.addCurve(to: CGPoint(x: 0.80769*width, y: 0.89561*height), control1: CGPoint(x: 0.76813*width, y: 0.98352*height), control2: CGPoint(x: 0.80769*width, y: 0.94396*height))
        path.addLine(to: CGPoint(x: 0.80769*width, y: 0.01648*height))
        path.addLine(to: CGPoint(x: 0.12637*width, y: 0.01648*height))
        path.closeSubpath()

        path.move(to: CGPoint(x: 0.36813*width, y: 0.64835*height))
        path.addLine(to: CGPoint(x: 0.28022*width, y: 0.64835*height))
        path.addCurve(to: CGPoint(x: 0.26374*width, y: 0.63187*height), control1: CGPoint(x: 0.27112*width, y: 0.64835*height), control2: CGPoint(x: 0.26374*width, y: 0.64097*height))
        path.addCurve(to: CGPoint(x: 0.28022*width, y: 0.61538*height), control1: CGPoint(x: 0.26374*width, y: 0.62276*height), control2: CGPoint(x: 0.27112*width, y: 0.61538*height))
        path.addLine(to: CGPoint(x: 0.36813*width, y: 0.61538*height))
        path.addCurve(to: CGPoint(x: 0.38462*width, y: 0.63187*height), control1: CGPoint(x: 0.37724*width, y: 0.61538*height), control2: CGPoint(x: 0.38462*width, y: 0.62276*height))
        path.addCurve(to: CGPoint(x: 0.36813*width, y: 0.64835*height), control1: CGPoint(x: 0.38462*width, y: 0.64097*height), control2: CGPoint(x: 0.37724*width, y: 0.64835*height))
        path.closeSubpath()

        path.move(to: CGPoint(x: 0.36813*width, y: 0.78022*height))
        path.addLine(to: CGPoint(x: 0.28022*width, y: 0.78022*height))
        path.addCurve(to: CGPoint(x: 0.26374*width, y: 0.76374*height), control1: CGPoint(x: 0.27112*width, y: 0.78022*height), control2: CGPoint(x: 0.26374*width, y: 0.77284*height))
        path.addCurve(to: CGPoint(x: 0.28022*width, y: 0.74725*height), control1: CGPoint(x: 0.26374*width, y: 0.75463*height), control2: CGPoint(x: 0.27112*width, y: 0.74725*height))
        path.addLine(to: CGPoint(x: 0.36813*width, y: 0.74725*height))
        path.addCurve(to: CGPoint(x: 0.38462*width, y: 0.76374*height), control1: CGPoint(x: 0.37724*width, y: 0.74725*height), control2: CGPoint(x: 0.38462*width, y: 0.75463*height))
        path.addCurve(to: CGPoint(x: 0.36813*width, y: 0.78022*height), control1: CGPoint(x: 0.38462*width, y: 0.77284*height), control2: CGPoint(x: 0.37724*width, y: 0.78022*height))
        path.closeSubpath()

        path.move(to: CGPoint(x: 0.36813*width, y: 0.51648*height))
        path.addLine(to: CGPoint(x: 0.28022*width, y: 0.51648*height))
        path.addCurve(to: CGPoint(x: 0.26374*width, y: 0.5*height), control1: CGPoint(x: 0.27112*width, y: 0.51648*height), control2: CGPoint(x: 0.26374*width, y: 0.5091*height))
        path.addCurve(to: CGPoint(x: 0.28022*width, y: 0.48352*height), control1: CGPoint(x: 0.26374*width, y: 0.4909*height), control2: CGPoint(x: 0.27112*width, y: 0.48352*height))
        path.addLine(to: CGPoint(x: 0.36813*width, y: 0.48352*height))
        path.addCurve(to: CGPoint(x: 0.38462*width, y: 0.5*height), control1: CGPoint(x: 0.37724*width, y: 0.48352*height), control2: CGPoint(x: 0.38462*width, y: 0.4909*height))
        path.addCurve(to: CGPoint(x: 0.36813*width, y: 0.51648*height), control1: CGPoint(x: 0.38462*width, y: 0.5091*height), control2: CGPoint(x: 0.37724*width, y: 0.51648*height))
        path.closeSubpath()

        path.move(to: CGPoint(x: 0.36813*width, y: 0.38462*height))
        path.addLine(to: CGPoint(x: 0.28022*width, y: 0.38462*height))
        path.addCurve(to: CGPoint(x: 0.26374*width, y: 0.36813*height), control1: CGPoint(x: 0.27112*width, y: 0.38462*height), control2: CGPoint(x: 0.26374*width, y: 0.37723*height))
        path.addCurve(to: CGPoint(x: 0.28022*width, y: 0.35165*height), control1: CGPoint(x: 0.26374*width, y: 0.35903*height), control2: CGPoint(x: 0.27112*width, y: 0.35165*height))
        path.addLine(to: CGPoint(x: 0.36813*width, y: 0.35165*height))
        path.addCurve(to: CGPoint(x: 0.38462*width, y: 0.36813*height), control1: CGPoint(x: 0.37724*width, y: 0.35165*height), control2: CGPoint(x: 0.38462*width, y: 0.35903*height))
        path.addCurve(to: CGPoint(x: 0.36813*width, y: 0.38462*height), control1: CGPoint(x: 0.38462*width, y: 0.37723*height), control2: CGPoint(x: 0.37724*width, y: 0.38462*height))
        path.closeSubpath()

        path.move(to: CGPoint(x: 0.36813*width, y: 0.25275*height))
        path.addLine(to: CGPoint(x: 0.28022*width, y: 0.25275*height))
        path.addCurve(to: CGPoint(x: 0.26374*width, y: 0.23626*height), control1: CGPoint(x: 0.27112*width, y: 0.25275*height), control2: CGPoint(x: 0.26374*width, y: 0.24537*height))
        path.addCurve(to: CGPoint(x: 0.28022*width, y: 0.21978*height), control1: CGPoint(x: 0.26374*width, y: 0.22716*height), control2: CGPoint(x: 0.27112*width, y: 0.21978*height))
        path.addLine(to: CGPoint(x: 0.36813*width, y: 0.21978*height))
        path.addCurve(to: CGPoint(x: 0.38462*width, y: 0.23626*height), control1: CGPoint(x: 0.37724*width, y: 0.21978*height), control2: CGPoint(x: 0.38462*width, y: 0.22716*height))
        path.addCurve(to: CGPoint(x: 0.36813*width, y: 0.25275*height), control1: CGPoint(x: 0.38462*width, y: 0.24537*height), control2: CGPoint(x: 0.37724*width, y: 0.25275*height))
        path.closeSubpath()

        path.move(to: CGPoint(x: 0.78571*width, y: height))
        path.addLine(to: CGPoint(x: 0.28022*width, y: height))
        path.addCurve(to: CGPoint(x: 0.17582*width, y: 0.8956*height), control1: CGPoint(x: 0.22266*width, y: height), control2: CGPoint(x: 0.17582*width, y: 0.95317*height))
        path.addLine(to: CGPoint(x: 0.17582*width, y: 0.17371*height))
        path.addLine(to: CGPoint(x: 0.11122*width, y: 0.02298*height))
        path.addCurve(to: CGPoint(x: 0.11261*width, y: 0.00741*height), control1: CGPoint(x: 0.10904*width, y: 0.01789*height), control2: CGPoint(x: 0.10956*width, y: 0.01204*height))
        path.addCurve(to: CGPoint(x: 0.12637*width, y: 0), control1: CGPoint(x: 0.11566*width, y: 0.00279*height), control2: CGPoint(x: 0.12083*width, y: 0))
        path.addLine(to: CGPoint(x: 0.87363*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.89011*width, y: 0.01648*height), control1: CGPoint(x: 0.88273*width, y: 0), control2: CGPoint(x: 0.89011*width, y: 0.00738*height))
        path.addLine(to: CGPoint(x: 0.89011*width, y: 0.89561*height))
        path.addCurve(to: CGPoint(x: 0.78571*width, y: height), control1: CGPoint(x: 0.89011*width, y: 0.95317*height), control2: CGPoint(x: 0.84328*width, y: height))
        path.closeSubpath()

        path.move(to: CGPoint(x: 0.15137*width, y: 0.03297*height))
        path.addLine(to: CGPoint(x: 0.20746*width, y: 0.16383*height))
        path.addCurve(to: CGPoint(x: 0.20879*width, y: 0.17033*height), control1: CGPoint(x: 0.20834*width, y: 0.16589*height), control2: CGPoint(x: 0.20879*width, y: 0.1681*height))
        path.addLine(to: CGPoint(x: 0.20879*width, y: 0.8956*height))
        path.addCurve(to: CGPoint(x: 0.28022*width, y: 0.96703*height), control1: CGPoint(x: 0.20879*width, y: 0.93499*height), control2: CGPoint(x: 0.24084*width, y: 0.96703*height))
        path.addLine(to: CGPoint(x: 0.78571*width, y: 0.96703*height))
        path.addCurve(to: CGPoint(x: 0.85714*width, y: 0.8956*height), control1: CGPoint(x: 0.8251*width, y: 0.96703*height), control2: CGPoint(x: 0.85714*width, y: 0.93499*height))
        path.addLine(to: CGPoint(x: 0.85714*width, y: 0.03297*height))
        path.addLine(to: CGPoint(x: 0.15137*width, y: 0.03297*height))
        path.closeSubpath()

        return path
    }
}

struct BeakerShape_Previews: PreviewProvider {
    static var previews: some View {
        BeakerShape()
    }
}
