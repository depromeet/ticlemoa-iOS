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
    
    // FIXME: font 및 icon 변경 필요
    public var body: some View {
        VStack(alignment: .center) {
            Capsule()
                .foregroundColor(.black)
                .frame(width: 42, height: 4)
                .padding(18)
            title
            tagList
            makingTagButton
            completeButton
        }
    }
    
}

extension TagSelectingListView {
    
    var title: some View {
        Text("티클모아에 저장하기")
            .font(.system(size: 18, weight: .bold))
    }
    
    var tagList: some View {
        List {
            if tags.isEmpty {
                Text("저장된 태그가 없어요.")
                    .font(.system(size: 16))
                    .foregroundColor(.grey4)
                    .padding([.vertical, .horizontal], 12)
            }
            ForEach($tags) { $tag in
                TagSelectingListRow(tag: $tag)
                    .frame(height: TagSelectingListRow.cellHeight)
            }
        }
        .listStyle(.plain)
        .environment(\.defaultMinListRowHeight, 10)
    }
    
    var makingTagButton: some View {
        Button(
            action: {
                
            }, label: {
                HStack {
                    Label("새 태그 만들기", image: "tag")
                        .foregroundColor(.black)
                        .padding(.top, 20)
                        .padding(.horizontal, 35)
                    Spacer()
                }
            }
        )
    }
    
    var completeButton: some View {
        Button(
            action: {
                
            }, label: {
                HStack {
                    Spacer()
                    Text("완료")
                    Spacer()
                }
                .frame(height: 56)
                .foregroundColor(.white)
                .cornerRadius(6)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.black)
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
