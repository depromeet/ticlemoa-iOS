//
//  AddingLinkView.swift
//  UserInterface
//
//  Created by Joseph Cha on 2022/12/06.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI
import Combine

import DomainInterface

enum FromWhichButton: Equatable {
    case naviBar
    case snackBar
    case modifyingButton(article: Article)
    
    static func == (lhs: FromWhichButton, rhs: FromWhichButton) -> Bool {
        switch (lhs, rhs) {
        case (.naviBar, .naviBar),
            (.snackBar, .snackBar): return true
        case (.modifyingButton(let lhsString), .modifyingButton(let rhsString)):
            return lhsString.url == rhsString.url
        default:
            return false
        }
    }
}

private enum TextFieldType: String {
    case link = "링크"
    case memo = "메모"
}

struct AddingArticle: Article {
    let content: String
    let title: String
    let url: String
    let imageUrl: String = ""
    let isPublic: Bool
    var id: Int = 0
    let viewCount: Int = 0
    let createdAt: String = ""
    let updatedAt: String = ""
    var tagIds: [Int] = []
}

struct AddingLinkView: View {
    @EnvironmentObject private var modelContainer: ModelContainer
    @ObservedObject private var viewModel: AddingLinkViewModel
    @FocusState private var isArticleTitleFocused: Bool
    @State private var isPublicSettingsHelpClicked: Bool = false
    @State private var isTagAddingButtonTouched: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    init(
        modelContainer: ModelContainer,
        fromWhere fromWhichButton: FromWhichButton
    ) {
        self.viewModel = AddingLinkViewModel(
            modelContainer: modelContainer,
            fromWhichButton: fromWhichButton)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            linkSetting
            articleSetting
            tagSetting
            memoSetting
            publicSetting
            Spacer()
            AddingButton
        }
        .hideKeyboard()
        .padding(.horizontal, 20)
        .navigationBarHidden(true)
        .ticlemoaNavigationBar(title: viewModel.isModifying ? "수정하기" : "아티클 추가", image: viewModel.isModifying ? "close_button_black" : "arrow")
        .ticlemoaBottomSheet(isPresented: $isTagAddingButtonTouched) {
            TagSelectingListView(
                modelContainer: modelContainer,
                selectedTags: $viewModel.selectedTags,
                isTagAddingButtonTouched: $isTagAddingButtonTouched
            )
        }
    }
}

extension AddingLinkView {
    var linkSetting: some View {
        CommonTextFieldView(type: .link, textFieldText: $viewModel.link)
    }
    
    var articleSetting: some View {
        VStack(spacing: 0) {
            if !viewModel.link.isEmpty {
                HStack(spacing: 12) {
                    Image(viewModel.articleThumbNail)
                        .frame(width: 57, height: 57)
                    HStack(spacing: 6.75) {
                        //                        TextField("", text: $viewModel.articleTitle, axis: .vertical)
                        TextField("", text: $viewModel.articleTitle)
                            .focused($isArticleTitleFocused, equals: true)
                            .font(.system(size: 14))
                            .lineLimit(2)
                            .foregroundColor(.grey4)
                        if !viewModel.articleTitle.isEmpty && isArticleTitleFocused {
                            Button {
                                viewModel.articleTitle = ""
                            } label: {
                                Image("ClearButtonGreyLine2")
                                    .frame(width: 16.5, height: 16.5)
                            }
                        }
                    }
                }
                .padding(.top, 12.8)
                Divider()
                    .overlay(isArticleTitleFocused ? Color.ticlemoaBlack : Color.grey2Line)
                    .frame(height: 1.2)
                    .padding(.top, 12)
            } else {
                if viewModel.fromWhichButton == .naviBar && UserDefaults.standard.string(forKey: "isUIPastePermitted") != nil {
                    HStack {
                        Button {
                            viewModel.link = UserDefaults.standard.string(forKey: "isUIPastePermitted") ?? ""
                        } label: {
                            HStack(spacing: 2) {
                                Text("복사한 링크 붙여넣기")
                                    .pretendFont(.body1)
                                    .tint(.ticlemoaWhite)
                                
                                Image("WhiteAdd")
                                    .frame(width: 10.67, height: 10.67)
                            }
                        }
                        .frame(width: 136, height: 34)
                        .background(Color.init(uiColor: #colorLiteral(red: 0.43, green: 0.42, blue: 0.38, alpha: 1)))
                        .cornerRadius(4.0)
                        .padding(.top, 12.8)
                        Spacer()
                    }
                }
            }
        }
    }

    var tagSetting: some View {
        VStack(spacing: 0) {
            HStack {
                Text("태그")
                    .foregroundColor(.grey4)
                    .font(.system(size: 14))
                    .padding(.top, 36.8)
                Spacer()
            }
            HStack(spacing: 10) {
                ForEach(viewModel.selectedTags, id: \.id) {
                    if !$0.tagName.isEmpty {
                        AddedTagView(selectedTags: $viewModel.selectedTags, tagName: $0.tagName)
                    }
                }
                if viewModel.selectedTags.count < 2 {
                    Button {
                        isTagAddingButtonTouched = true
                    } label: {
                        HStack(spacing: 3.04) {
                            Image("TagAdd")
                                .frame(width: 7.92, height: 7.92)
                            Text("태그추가")
                                .font(.system(size: 14))
                                .tint(.grey4)
                        }
                    }
                    .frame(width: 81, height: 37)
                    .background(Color.grey2)
                    .cornerRadius(4.0)
                }
                Spacer()
            }
            .padding(.top, 8)
            .padding(.bottom, 36)
        }
    }
    
    var memoSetting: some View {
        CommonTextFieldView(type: .memo, textFieldText: $viewModel.memo)
    }
    
    var publicSetting: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("공개설정")
                    .font(.system(size: 14))
                    .foregroundColor(.grey4)
                Button {
                    isPublicSettingsHelpClicked.toggle()
                } label: {
                    Image("ToolTip")
                }
                .padding(.leading, 4)
                Spacer()
                Toggle("", isOn: $viewModel.isPublicSetting)
                    .toggleStyle(SwitchToggleStyle(tint: .ticlemoaBlack))
            }
            .padding(.top, 46.8)
            if isPublicSettingsHelpClicked {
                HStack(spacing: 0) {
                    HStack(alignment: .top ,spacing: 31.34) {
                        Text("공개설정시 나의 태그를 다른 사용자가 볼 수 있어요.")
                            .font(.system(size: 14))
                            .padding(.leading, 16)
                            .padding(.vertical, 14)
                        Button {
                            isPublicSettingsHelpClicked.toggle()
                        } label: {
                            Image("CloseButton")
                                .frame(width: 16.0, height: 16.0)
                                .padding(.trailing, 18.34)
                                .padding(.top, 14)
                        }
                    }
                    .frame(height: 70)
                    .background(Color.grey2Line)
                    .cornerRadius(4.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4.0)
                            .stroke(Color.ticlemoaBlack, lineWidth: 1.0)
                        )
                    Spacer()
                }
                .padding(.trailing, 32)
            }
        }
    }
    
    var AddingButton: some View {
        Button {
            Task {
                let (message, isSuccess) = await viewModel.addingButtondidTapped()
                if isSuccess {
                    print(message)
                    dismiss()
                } else {
                    print(message)
                }
            }
        } label: {
            Text(viewModel.isModifying ? "완료" : "추가하기")
                .tint(viewModel.link.isEmpty ? .grey3 : .ticlemoaWhite)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 56)
        .background(viewModel.link.isEmpty ?  Color.grey2Line : Color.ticlemoaBlack)
        .cornerRadius(6.0)
        .padding(.bottom, 16)
    }
}

private struct CommonTextFieldView: View {
    let type: TextFieldType
    @Binding var textFieldText: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(type.rawValue)
                    .foregroundColor(.grey4)
                    .font(.system(size: 14))
                    .padding(.top, 16)
                Spacer()
            }
            HStack(spacing: 8.75) {
//                TextField("", text: $textFieldText, axis: type == .memo ? .vertical : .horizontal)
                TextField("", text: $textFieldText)
                    .placeholder("\(type.rawValue)를 입력해주세요", when: textFieldText.isEmpty, color: .grey3)
                    .onReceive(Just(textFieldText), perform: { _ in
                        if textFieldText.count > 50 && type == .memo {
                            textFieldText = String(textFieldText.prefix(50))
                        }
                    })
                    .font(.system(size: 16))
                    .foregroundColor(.ticlemoaBlack)
                    .focused($isFocused, equals: true)
                    .lineLimit(type == .memo ? 2 : 1)
                    .submitLabel(.done)
                if type == .link && !textFieldText.isEmpty {
                    Button {
                        textFieldText = ""
                    } label: {
                        Image("ClearButtonGreyLine2")
                            .frame(width: 18, height: 18)
                    }
                }
            }
            .padding(.top, 12)
            Divider()
                .overlay(isFocused ? Color.ticlemoaBlack : Color.grey2Line)
                .frame(height: 1.2)
                .padding(.top, 8)
        }
        
    }
}

private struct AddedTagView: View {
    @Binding var selectedTags: [Tag]
    var tagName: String
    
    var body: some View {
        HStack(spacing: 6.75) {
            Text(tagName)
                .font(.system(size: 14))
                .foregroundColor(.grey1)
            Button {
                selectedTags = selectedTags.filter({ $0.tagName != tagName })
            } label: {
                Image("ClearButtonGrey4")
                    .frame(width: 16.5, height: 16.5)
            }
        }
        .frame(width: 84, height: 37)
        .background(Color.ticlemoaBlack)
        .cornerRadius(4.0)
    }
}

struct LinkAddingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack(spacing: 100) {
                NavigationLink {
                    AddingLinkView(
                        modelContainer: ModelContainer.dummy,
                        fromWhere: .snackBar
                    )
                } label: {
                    Text("snackBar")
                }
                NavigationLink {
                    AddingLinkView(modelContainer: ModelContainer.dummy, fromWhere: .naviBar)
                } label: {
                    Text("naviBar")
                }
            }
        }
        
        AddingLinkView(modelContainer: ModelContainer.dummy, fromWhere: .naviBar)
        AddingLinkView(modelContainer: ModelContainer.dummy, fromWhere: .snackBar)
    }
}
