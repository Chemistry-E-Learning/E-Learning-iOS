//
//  ReportView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 07/12/2022.
//

import SwiftUI
import MessageUI

struct ReportView: View {
    @StateObject private var viewModel = ReportContentViewModel()
    @Binding var isShowReportView: Bool
    @State private var reportMessage = ""
    let contentID: String
    let contentName: String

    private let reports = [
        Localization.wrongContent.localizedString,
        Localization.oldContent.localizedString,
        Localization.inappropriateContent.localizedString,
        Localization.objectionableContent.localizedString,
        Localization.spamContent.localizedString,
        Localization.unauthorizedSales.localizedString,
        Localization.other.localizedString,
    ]

    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    Button {
                        isShowReportView = false
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .foregroundColor(.black)
                            .scaleEffect(0.4)
                    }
                    .squareFrame(44)
                    Text(Localization.reportTitle.localizedString)
                        .font(.system(size: 25, weight: .medium))
                    Spacer()
                }
                .padding(.horizontal, 12)
                Divider()
                    .padding(.horizontal, 20)
                VStack(alignment: .leading, spacing: 12) {
                    Text(Localization.reportHeadlineText.localizedString)
                        .font(.system(size: 22, weight: .medium))
                        .multilineTextAlignment(.leading)
                    Text(Localization.reportHeadlineDesc.localizedString)
                        .font(.system(size: 16))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black.opacity(0.6))
                    FlowLayout(
                        mode: .scrollable,
                        items: reports,
                        itemSpacing: 4
                    ) { item in
                        Button {
                            reportMessage = item
                        } label: {
                            Text(item)
                                .font(.system(size: 16))
                                .foregroundColor(reportMessage == item ? .white : .black)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .foregroundColor(Color.gray.opacity(reportMessage == item ? 0.8 : 0.2))
                                )
                        }
                    }
                    .padding(.top, 16)
                    Spacer()
                    Button {
                        let report = ReportModel(
                            username: UserDefaultsData.shared.username,
                            contentID: contentID,
                            contentName: contentName,
                            message: reportMessage
                        )
                        viewModel.doSendReport(with: report)
                    } label: {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(reportMessage.isEmpty ? Color.gray.opacity(0.5) : Color.cFFC42C)
                            .frame(height: 52)
                            .overlay(
                                Text(Localization.submitCommentsTitle.localizedString)
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(reportMessage.isEmpty ? .black.opacity(0.5) : .white)
                            )
                    }
                    .disabled(reportMessage.isEmpty)
                    .padding(.bottom, 20)
                }
                .padding(.horizontal, 20)
            }
            .onChange(of: viewModel.isShowReportView) { newValue in
                if !newValue {
                    isShowReportView = false
                }
            }
        }
    }
}
