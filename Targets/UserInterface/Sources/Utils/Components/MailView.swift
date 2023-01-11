//
//  MailView.swift
//  Ticlemoa
//
//  Created by Shin Jae Ung on 2023/01/11.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

import SwiftUI
import MessageUI

struct MailView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentation
    @Binding var result: Result<MFMailComposeResult, Error>?
    private let message: String = """
    [문의사항]
    메세지:
    
    Ticlemoa 내부 규정에 의거하여 24시간 이내로 검토하여 안내드리겠습니다.
    일부 요청은 지연될 수 있습니다.
    """
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var presentation: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(presentation: Binding<PresentationMode>, result: Binding<Result<MFMailComposeResult, Error>?>) {
            self._presentation = presentation
            self._result = result
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
                defer { self.$presentation.wrappedValue.dismiss() }
                if let error = error {
                    self.result = .failure(error)
                    return
                }
                self.result = .success(result)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentation: presentation, result: self.$result)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let viewController = MFMailComposeViewController()
        viewController.mailComposeDelegate = context.coordinator
        viewController.setToRecipients(["ticlemoa6@gmail.com"])
        viewController.setSubject("Ticlemoa 문의")
        viewController.setMessageBody(self.message, isHTML: false)
        return viewController
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailView>) { }
}
