//
//  TiclemoaAlert.swift
//  UserInterface
//
//  Created by Yongwoo Marco on 2022/11/16.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

public enum AlertStyle: Equatable {
    case confirm(message: String)
    case inputText
    
    var alertHeight: CGFloat {
        switch self {
            case .confirm(_):   return 169
            case .inputText:    return 225
        }
    }
}

extension View {

    public func ticlmoaAlert(
        isPresented: Binding<Bool>,
        title: String,
        style: AlertStyle,
        completion: @escaping (String?) -> Void
    ) -> some View {
        let keyWindow = keyWindow()
        let alertViewController = {
            let alertView: TiclemoaAlert = .init(
                isPresented: isPresented,
                title: title,
                style: style,
                completion: completion
            )
            let viewController = UIHostingController(rootView: alertView)
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .overCurrentContext
            viewController.view.backgroundColor = .clear
            viewController.definesPresentationContext = true
            return viewController
        }()

        return self.onChange(of: isPresented.wrappedValue) {
            if $0 {
                keyWindow?.rootViewController?.present(alertViewController, animated: true)
            } else {
                keyWindow?.rootViewController?.dismiss(animated: true)
            }
        }
    }

    private func keyWindow() -> UIWindow? {
        UIApplication.shared.connectedScenes
            .filter ({ $0.activationState == .foregroundActive })
            .compactMap({ $0 as? UIWindowScene}).first?
            .windows.filter({ $0.isKeyWindow }).first!
    }
    
}

public struct TiclemoaAlert: View {

    @Binding var isPresented: Bool
    let title: String
    let style: AlertStyle
    let completion: (String?) -> Void
    @State var inputText: String = ""

    public var body: some View {
        ZStack{
            Color.black
                .opacity(0.6)
                .ignoresSafeArea()
            VStack(spacing:0) {
                Text(title)
                    .font(.system(size: 18, weight: .bold))
                    .padding(.top, 24)
                alertContext
                Divider()
                HStack(){
                    cancelButton
                    Divider()
                    confirmButton
                }
                .frame(height: 56)
            }
            .frame(
                width: UIScreen.main.bounds.width * 328/375,
                height: UIScreen.main.bounds.height * style.alertHeight/812
            )
            .background(.white)
            .cornerRadius(10)
        }
        .onChange(of: inputText) { newValue in // FIXME: ViewModel Logic 인가 고민하기
            if inputText.count > 8 {
                self.inputText = inputText.map({ String($0) })[0..<8].joined()
            }
        }
    }
    
    @ViewBuilder
    public var alertContext: some View {
        switch style {
            case .confirm(let message):
                Text(message)
                    .font(.body)
                    .padding(.horizontal, 32)
                    .padding(.top, 16)
                    .padding(.bottom, 24)
            case .inputText:
                VStack {
                    ZStack {
                        Rectangle()
                            .fill(.white)
                            .border(.black)
                            .padding(.horizontal, 24)
                        TextField("InputText", text: $inputText)
                            .padding(.horizontal, 40)
                    }
                    
                    .frame(height: 58)
                    HStack {
                        Spacer()
                        Text("\(inputText.count)/8")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .padding(.trailing, 24)
                            .padding(.bottom, 26)
                    }
                }
        }
    }

    public var cancelButton: some View {
        Button(
            action: {
                self.isPresented.toggle()
            }, label: {
                HStack {
                    Spacer()
                    Text("취소")
                        .font(.system(size: 16, weight: .semibold))
                    Spacer()
                }
            }
        )
    }

    public var confirmButton: some View {
        Button(
            action: {
                switch style {
                    case .confirm(_):
                        completion(nil)
                    case .inputText:
                        completion(inputText)
                }
                self.isPresented.toggle()
            }, label: {
                HStack {
                    Spacer()
                    Text("확인")
                        .foregroundColor(.primary)
                        .font(.system(size: 16, weight: .semibold))
                    Spacer()
                }
            }
        )
    }

}
