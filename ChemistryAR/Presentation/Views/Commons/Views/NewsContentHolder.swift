//
//  NewsContentHolder.swift
//  ChemistryAR
//
//  Created by NhatMinh on 05/12/2022.
//

import SwiftUI

import SwiftUI

struct NewsContentHolder: View {
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .fill(Color.black.opacity(0.1))
                .frame(width: getScreenBounds().width, height: 240)
            VStack(alignment: .leading, spacing: 8) {
                Text(AppConstant.ShortText)
                    .multilineTextAlignment(.leading)
                Text(AppConstant.LongText)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 12)
                Rectangle()
                    .fill(Color.black.opacity(0.1))
                    .frame(width: getScreenBounds().width - 40, height: 50)
                Text(AppConstant.LongText)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 12)
                Text(AppConstant.LongText)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 12)
                Rectangle()
                    .fill(Color.black.opacity(0.1))
                    .frame(width: getScreenBounds().width - 40, height: 50)
                Text(AppConstant.LongText)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 12)
                Rectangle()
                    .fill(Color.black.opacity(0.1))
                    .frame(width: getScreenBounds().width - 40, height: 100)
                Text(AppConstant.Paragraph)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 12)
        }
        .redacted(if: true)
    }
}

struct NewsContentHolder_Previews: PreviewProvider {
    static var previews: some View {
        NewsContentHolder()
    }
}
