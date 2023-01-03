//
//  SelectTagModalView.swift
//  UserInterface
//
//  Created by 김용우 on 2022/12/10.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

protocol Checkable {
    var isSelected: Bool { get set }
}

// FIXME: - Example 타입 변경필요
struct TagSelectingListViewModel: Identifiable, Checkable {
    let id: UUID
    let title: String
    var isSelected: Bool
}

public struct TagSelectingListView: View {
    
    @Binding var tags: [TagSelectingListViewModel]
    @State private var isMakingTagButtonTapped: Bool = false
    
    // FIXME: font 및 icon 변경 필요
    public var body: some View {
        VStack(alignment: .center) {
            title
            tagList
            makingTagButton
            completeButton
        }
        .gesture(DragGesture())
    }
    
}

extension TagSelectingListView {
    
    var title: some View {
        Text("티클모아에 저장하기")
//            .customFont(18, .bold)
            .frame(height: 59)
    }
    
    var tagList: some View {
        Group {
//            if tags.isEmpty {
//                HStack {
//                    Text("저장된 태그가 없어요.")
//                        .customFont(16, .medium)
//                        .font(.system(size: 16))
//                        .foregroundColor(.grey4)
//                        .padding(.vertical, 12)
//                        .padding(.leading, 36)
//                    Spacer()
//                }
//            } else if (1...3).contains(tags.count) {
//                tagView
//            } else {
//                ScrollView {
//                    tagView
//                }
//                .frame(height: 178)
//            }
        }
        .listStyle(.plain)
        .environment(\.defaultMinListRowHeight, 10)
    }
    
    var tagView: some View {
        ForEach($tags) { $tag in
            TagSelectingListRow(tag: $tag)
        }
    }
    
    var makingTagButton: some View {
        Button(
            action: {
                isMakingTagButtonTapped = true
            }, label: {
                HStack(spacing: 6.62) {
                    Image("tag")
                        .padding(.leading, 34)
                    Text("새 태그 만들기")
                        .foregroundColor(.ticlemoaBlack)
//                        .customFont(16, .semiBold)
                    Spacer()
                }
            }
        )
        .frame(height: 64)
        .ticlmoaAlert(
            isPresented: $isMakingTagButtonTapped,
            title: "새 태그 만들기",
            style: .inputText,
            completion: { result in
                print(result)
            })
    }
    
    var completeButton: some View {
        Button(
            action: {
                
            }, label: {
                HStack {
                    Spacer()
                    Text("완료")
//                        .customFont(16, .bold)
                    Spacer()
                }
                .frame(height: 56)
                .foregroundColor(.white)
                .cornerRadius(6)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.ticlemoaBlack)
                )
            }
        )
        .padding(.top, 10)
        .padding(.bottom, 16)
        .padding([.leading, .trailing], 20)
    }
    
}

struct SelectableTagListView_Previews: PreviewProvider {
    
    @State static var tags = TagSelectingListViewModel.dummy
    
    static var previews: some View {
        TagSelectingListView(tags: $tags)
    }
    
}

#if DEBUG

extension TagSelectingListViewModel {
    static var dummy: [Self] {
        [
            .init(id: .init(), title: "첫번째 태그", isSelected: Bool.random()),
            .init(id: .init(), title: "두번째 태그", isSelected: Bool.random()),
            .init(id: .init(), title: "세번째 태그", isSelected: Bool.random()),
            .init(id: .init(), title: "네번째 태그", isSelected: Bool.random()),
            .init(id: .init(), title: "다섯번째 태그", isSelected: Bool.random())
        ]
    }
}

#endif
