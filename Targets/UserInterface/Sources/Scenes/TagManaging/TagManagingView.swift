//
//  TagManagingView.swift
//  UserInterface
//
//  Created by Shin Jae Ung on 2022/11/19.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

import DomainInterface

struct TagManagingView: View {
    @EnvironmentObject var modelContainer: ModelContainer
    @State var tags: [Tag] = []
    @State private var isMakingTagButtonTapped: Bool = false
    
    var body: some View {
        VStack {
            if tags.isEmpty {
                Image("tag_empty")
                    .frame(width: 335, height: 188)
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(tags, id: \.id) { tag in
                            TagView(modelContainer: modelContainer, tag: tag)
                        }
                    }
                }
            }
        }
        .ticlemoaNavigationBar(title: "태그관리", image: "arrow") {
            Button {
                isMakingTagButtonTapped = true
            } label: {
                Image("black_add")
            }
        }
        .ticlmoaAlert(
            isPresented: $isMakingTagButtonTapped,
            title: "새 태그 만들기",
            style: .inputText,
            isConfirmAlert: false,
            completion: { result in
                guard let result = result else { return (true, "") }
                do {
                    try await modelContainer.tagModel.create(tagName: result)
                    return (false, "")
                } catch let domainInterFaceError as DomainInterfaceError {
                    switch domainInterFaceError {
                    case .networkError(let code):
                        if code == 400 {
                            return (true, "이미 존재하는 태그입니다.")
                        }
                        return (true, "알 수 없는 에러입니다.") // FIXME: 스웨거 기준 statusCode 세분화 필요
                    }
                } catch {
                    return (true, "알 수 없는 에러입니다.")
                }
            })
        .onReceive(modelContainer.tagModel.itemsPublisher) {
            self.tags = $0
            Task {
                do {
                    try await modelContainer.articleModel.fetch(tagId: nil) // 아티클 모델 itempublisher에 모든 아티클이 들어 있어야 함 (안해주면 홈화면에서 클릭한 태그의 아티클만 나옴..)
                } catch {
                    print(error.localizedDescription) // TODO: 실패 토스트 메세지 띄우기
                }
            }
        }
    }
}

struct TagView: View {
    @ObservedObject var modelContainer: ModelContainer
    @State private var isTagSettingButtonTouched: Bool = false
    @State private var isTagDeletingButtonTouched: Bool = false
    
    let tag: Tag
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(tag.tagName)
                    .customFont(weight: 700, size: 14, lineHeight: 21)
                    .padding(.leading, 21)
                Spacer()
                NavigationLink {
                    ArticleManagingListView(tag: tag)
                } label: {
                    Image("meat_ball")
                        
                }
                .frame(width: 3, height: 21)
                .padding(.trailing, 27)
            }
            .frame(height: 55)
            Divider()
                .overlay(Color.grey2Line)
                .frame(height: 1)
        }
        .frame(height: 56)
    }
}

struct TagManageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NavigationLink("눌러") {
                TagManagingView()
            }
        }
    }
}
