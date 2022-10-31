//
//  ElementWikipediaView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 31/10/2022.
//

import SwiftUI

struct ElementWikipediaView: View {
    @Binding var isPushToWikipediaView: Bool
    
    var body: some View {
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
                isLoading: .constant(false),
                type: .external,
                url: "https://en.wikipedia.org/wiki/Nitrogen"
            )
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ElementWikipediaView_Previews: PreviewProvider {
    static var previews: some View {
        ElementWikipediaView(isPushToWikipediaView: .constant(false))
    }
}
