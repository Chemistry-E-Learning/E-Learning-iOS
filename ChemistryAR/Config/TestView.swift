//
//  TestView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 19/10/2022.
//

import SwiftUI

struct TestView: View {
    @State private var beakerYellow = Color.yellow
    @State private var beakerPercent = 1.0
    @State private var instrumentAppear = 0

    var body: some View {
        VStack {
            HStack {
                Button {
                    instrumentAppear = 1
                } label: {
                    Text("Add")
                }
                Button {
                    instrumentAppear = 2
                } label: {
                    Text("Add new item")
                }
                Button {
                    instrumentAppear = 3
                } label: {
                    Text("Add new item")
                }
                Button {
                    instrumentAppear = 4
                } label: {
                    Text("Add new item")
                }
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
