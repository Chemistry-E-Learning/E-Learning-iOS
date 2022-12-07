//
//  ElementWikipediaView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 31/10/2022.
//

import SwiftUI

struct ElementWikipediaView: View {
    @Binding var isPushToWikipediaView: Bool
    @State private var isLoading = true
    let url: String
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                HStack {
                    BackButton(action: {
                        isPushToWikipediaView = false
                    }, fontWeight: .medium, color: .black)
                    Spacer()
                    HStack(spacing: -1) {
                        Image("wikipedia")
                            .resizable()
                            .squareFrame(36)
                        Text("ikipedia")
                            .font(.system(size: 20, weight: .medium))
                            .tracking(2)
                            .offset(y: 3)
                    }
                    Spacer()
                    Rectangle()
                        .squareFrame(44)
                        .opacity(0)
                }
                WebView(
                    contentHeight: .constant(0),
                    isLoading: $isLoading,
                    type: .external,
                    url: url
                )
            }
            .swipeBack(isPresented: $isPushToWikipediaView, maxTranslation: geo.size.width / 3)
            .ignoresSafeArea(.all, edges: .bottom)
        }
        .onAppear {
            GA4Manager.shared.trackScreenView(.wikipedia)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}
