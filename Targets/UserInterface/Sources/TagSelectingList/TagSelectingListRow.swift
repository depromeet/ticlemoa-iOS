//
//  SelectableTagListRow.swift
//  UserInterface
//
//  Created by 김용우 on 2022/12/10.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

struct TagSelectingListRow: View {
    
    static let cellHeight: CGFloat = 42
    
    let selectedTagsCount : Int
    @Binding var checkableTag: CheckableTag
    
    // FIXME: font 및 icon 변경 필요
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(checkableTag.tagName)
//                    .customFont(16, .medium)
                    .foregroundColor(.ticlemoaBlack)
                    .padding(.leading, 36)
                Spacer()
                Image(checkableTag.isSelected ? "radio_on" : "radio_off")
                    .padding(.trailing, 27)
            }
            .frame(height: TagSelectingListRow.cellHeight)
            Divider()
                .overlay(Color.grey2Line)
                .frame(height: 1)
                .padding(.top, 4)
                .padding(.horizontal, 25)
        }
        .listRowBackground(Color.clear)
        .contentShape(Rectangle())
        .onTapGesture {
            if selectedTagsCount < 2 || checkableTag.isSelected {
                self.checkableTag.isSelected.toggle()
            }
        }
    }
}

struct SelectableTagListRow_Previews: PreviewProvider {
    static var previews: some View {
        TagSelectingListRow(
            selectedTagsCount: 1,
            checkableTag: .constant(
                .init(
                    id: 1,
                    userId: 1,
                    tagName: "새로운 태그",
                    isSelected: Bool.random()
                )
            )
        )
        .previewLayout(.sizeThatFits)
    }
}
