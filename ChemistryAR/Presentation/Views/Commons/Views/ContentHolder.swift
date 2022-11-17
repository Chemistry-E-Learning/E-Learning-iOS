//
//  ContentHolder.swift
//  ChemistryAR
//
//  Created by NhatMinh on 17/11/2022.
//

import SwiftUI

struct ContentHolder: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(AppConstant.ShortText)
            Text(AppConstant.LongText)
                .multilineTextAlignment(.leading)
            Rectangle()
                .fill(Color.black.opacity(0.1))
                .frame(width: getScreenBounds().width - 40, height: 100)
            Text(AppConstant.Paragraph)
                .multilineTextAlignment(.leading)
            Rectangle()
                .fill(Color.black.opacity(0.1))
                .frame(width: getScreenBounds().width - 40, height: 50)
            Text(AppConstant.LongText)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 12)
            Text(AppConstant.Paragraph)
                .multilineTextAlignment(.leading)
        }
        .redacted(if: true)
    }
}

struct ContentHolder_Previews: PreviewProvider {
    static var previews: some View {
        ContentHolder()
    }
}
