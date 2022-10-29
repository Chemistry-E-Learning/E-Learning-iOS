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
                VStack(alignment: .leading, spacing: 0) {
                    Image("branchBG")
                        .resizable()
                        .scaledToFill()
                        .overlay {
                            ZStack(alignment: .topLeading) {
                                Color.black.opacity(0.4)
                                VStack(alignment: .leading, spacing: 28) {
                                    Button {
                                        isPushToLawsView = false
                                    } label: {
                                        Image(systemName: "chevron.backward")
                                            .foregroundColor(.white)
                                            .font(.system(size: 24, weight: .bold))
                                            .background(
                                                Circle()
                                                    .fill(Color.black.opacity(0.6))
                                                    .squareFrame(48)
                                            )
                                    }
                                    .padding(.horizontal, 8)
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Inorganic Chemistry")
                                            .font(.system(size: 26, weight: .bold))
                                            .foregroundColor(.white)
                                        Text("5m30s - 12 Lessons")
                                            .font(.system(size: 13, weight: .regular))
                                            .foregroundColor(.white.opacity(0.9))
                                    }
                                    Text("Le lorem ipsum est, en imprimerie, une suite de mots sans signification utilisée à titre provisoire pour calibrer une mise en page, le texte définitif venant pour calibrer une mise en page, le texte définitif venant")
                                        .multilineTextAlignment(.leading)
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(.white)
                                        .lineLimit(4)
                                }
                                .padding(.horizontal, 28)
                                .offset(y: geo.size.height * 0.17)
                            }
                        }
                        .frame(height: geo.size.height * 0.2)
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(0..<10) { _ in
                                BranchLessonItemView()
                                    .onTapGesture {
                                        isPushToLessonDetailView = true
                                    }
                            }
                        }
                        .padding(.bottom, 40)
                    }
                    .padding(.top, geo.size.height * 0.11)
                    .padding(.horizontal, 20)
                }

            }
        }
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
