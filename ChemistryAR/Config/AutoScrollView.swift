//
//  AutoScrollView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 25/11/2022.
//

import SwiftUI

struct AutoScrollView: View {
    @State private var position = 9 //test.count - 1
    @State private var test = [10,1,2,3,4,5,6,7,8,9]
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(test, id: \.self) { id in
                        Rectangle()
                            .frame(width: 200, height: 100)
                            .overlay {
                                Text("\(id)")
                                    .foregroundColor(.white)
                            }
                            .onAppear {
                                print(test.rotatingLeft(positions: id))
                            }
                    }
                }
            }
        }
    }
}

struct AutoScrollView_Previews: PreviewProvider {
    static var previews: some View {
        AutoScrollView()
    }
}

extension RangeReplaceableCollection {
    func rotatingLeft(positions: Int) -> SubSequence {
        let index = self.index(startIndex, offsetBy: positions, limitedBy: endIndex) ?? endIndex
        return self[index...] + self[..<index]
    }
    mutating func rotateLeft(positions: Int) {
        let index = self.index(startIndex, offsetBy: positions, limitedBy: endIndex) ?? endIndex
        let slice = self[..<index]
        removeSubrange(..<index)
        insert(contentsOf: slice, at: endIndex)
    }
}

extension RangeReplaceableCollection {
    func rotatingRight(positions: Int) -> SubSequence {
        let index = self.index(endIndex, offsetBy: -positions, limitedBy: startIndex) ?? startIndex
        return self[index...] + self[..<index]
    }
    mutating func rotateRight(positions: Int) {
        let index = self.index(endIndex, offsetBy: -positions, limitedBy: startIndex) ?? startIndex
        let slice = self[index...]
        removeSubrange(index...)
        insert(contentsOf: slice, at: startIndex)
    }
}
