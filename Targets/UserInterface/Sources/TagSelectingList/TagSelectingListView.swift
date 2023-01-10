//
//  SelectTagModalView.swift
//  UserInterface
//
//  Created by 김용우 on 2022/12/10.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI
import Combine
import DomainInterface

struct CheckableTag: Tag, Identifiable {
    let id: Int
    let userId: Int
    let tagName: String
    var isSelected: Bool = false
}

public struct TagSelectingListView: View {
    @ObservedObject private var modelContainer: ModelContainer
    @State private var chekableTags: [CheckableTag] = []
    @State private var isMakingTagButtonTapped: Bool = false
    
    @Binding var selectedTags: [Tag]
    @Binding var isTagAddingButtonTouched: Bool
    
    public init(
        modelContainer: ModelContainer,
        selectedTags: Binding<[Tag]>,
        isTagAddingButtonTouched: Binding<Bool>
    ) {
        self.modelContainer = modelContainer
        self._selectedTags = selectedTags
        self._isTagAddingButtonTouched = isTagAddingButtonTouched
    }
    
    // FIXME: font 및 icon 변경 필요
    public var body: some View {
        VStack(alignment: .center) {
            title
            tagList
            makingTagButton
            completeButton
        }
        .gesture(DragGesture())
        .onReceive(self.modelContainer.tagModel.itemsPublisher) { tags in
            chekableTags = tags.map {
                CheckableTag(
                    id: $0.id,
                    userId: $0.userId,
                    tagName: $0.tagName)
            }
        }
    }
}

extension TagSelectingListView {
    
    var title: some View {
        Text("티클모아에 저장하기")
//            .customFont(18, .bold)
            .frame(height: 59)
    }
    
    var tagList: some View {
        LazyVStack {
            if chekableTags.isEmpty {
                HStack {
                    Text("저장된 태그가 없어요.")
                        .customFont(weight: 400, size: 16, lineHeight: 24)
                        .font(.system(size: 16))
                        .foregroundColor(.grey4)
                        .padding(.vertical, 12)
                        .padding(.leading, 36)
                    Spacer()
                }
            } else if (1...3).contains(chekableTags.count) {
                tagView
            } else {
                ScrollView {
                    tagView
                }
                .frame(height: 178)
            }
        }
        .listStyle(.plain)
        .environment(\.defaultMinListRowHeight, 10)
    }
    
    var tagView: some View {
        ForEach($chekableTags, id: \.id) { $tag in
            TagSelectingListRow(
                selectedTagsCount: chekableTags.filter{$0.isSelected}.count,
                checkableTag: $tag
            )
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
                selectedTags = chekableTags
                    .filter { $0.isSelected }
                    .map { $0 as Tag }
                
                isTagAddingButtonTouched = false
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
    
    @State private static var selectedTags: [Tag] = []
    @State private static var isTagAddingButtonTouched: Bool = false
    
    static var previews: some View {
        TagSelectingListView(
            modelContainer: ModelContainer.dummy,
            selectedTags: $selectedTags,
            isTagAddingButtonTouched: $isTagAddingButtonTouched
        )
    }
}
