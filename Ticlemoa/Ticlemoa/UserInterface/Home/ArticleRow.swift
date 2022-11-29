//
//  ArticleCell.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/11/28.
//

import SwiftUI

struct ArticleRow: View {
    
    var body: some View {
        HStack {
            Color.grey2
                .frame(maxWidth: 88, maxHeight: 88)
                .padding(.leading, 20)
            Spacer()
            VStack(alignment:.leading) {
                Text("아티클 제목제목제목제목제목제목제목제목제목제목")
                    .font(16, .semiBold)
                Text("태그들")
                    .font(12,. medium)
                    .foregroundColor(Color.grey4)
                    .padding(2)
                    .background(Color.grey2)
                    .background(
                        RoundedRectangle(cornerRadius: 5,style: .continuous)
                            .foregroundColor(Color.grey2)
                    )
            }
            Spacer()
            VStack {
                Text("...")
                    .padding(.top, 14)
                Spacer()
            }
                .padding(.trailing, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: 106)
        .listRowInsets(EdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.grey1)
        .background(Color.grey1)
    }
}

struct ArticleRow_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRow()
    }
}
