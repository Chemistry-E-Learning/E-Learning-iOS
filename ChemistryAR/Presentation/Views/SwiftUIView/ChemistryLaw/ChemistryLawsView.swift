//
//  ChemistryLawsView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 25/10/2022.
//

import SwiftUI

struct ChemistryLawsView: View {
    @Binding var isPushToLawsView: Bool
    @State private var isPushToLessonDetailView = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                NavigationLink(
                    destination: NavigationLazyView(
                        LessonDetailView(isPushToLessonDetailView: $isPushToLessonDetailView)
                    ),
                    isActive: $isPushToLessonDetailView
                ) {
                    EmptyView()
                }
                HeaderListCustomView(
                    isPushToCurrentView: $isPushToLawsView,
                    parentHeight: geo.size.height
                )
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(0..<10) { _ in
                            BranchLessonItemView()
                                .onTapGesture {
                                    isPushToLessonDetailView = true
                                }
                        }
                    }
                    .padding(.bottom, geo.size.height * 0.38)
                }
                .offset(y: geo.size.height * 0.34)
                .padding(.horizontal, 20)
            }
        }
        .ignoresSafeArea(.all)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct ChemistryLawsView_Previews: PreviewProvider {
    static var previews: some View {
        ChemistryLawsView(isPushToLawsView: .constant(false))
    }
}
