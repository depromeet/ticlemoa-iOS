//
//  RecentQueryView.swift
//  UserInterface
//
//  Created by 김용우 on 2023/01/09.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import SwiftUI

struct RecentQueryRow: View {
    let recentQuery: String
    var searchAction: (String) -> Void
    var removeAction: () -> Void
    
    init(
        recentQuery: String,
        searchAction: @escaping (String) -> Void,
        removeAction: @escaping () -> Void
    ) {
        self.recentQuery = recentQuery
        self.searchAction = searchAction
        self.removeAction = removeAction
    }
    
    var body: some View {
        HStack(spacing: 0) {
            HStack{
                Image("recent")
                    .frame(width: 14, height: 14)
                Text(recentQuery)
                    .font(.system(size: 16))
                    .padding(.leading, 9)
                Spacer()
            }
            .onTapGesture {
                self.searchAction(recentQuery)
            }
            Button {
                self.removeAction()
            } label: {
                Image("deleteButton")
                    .frame(width: 10.5, height: 10.5)
            }
        }
        .padding(.bottom)
        .padding(.leading, 23)
        .padding(.trailing, 21.75)
    }
}

struct RecentQueryView_Previews: PreviewProvider {
    static var previews: some View {
        RecentQueryRow(recentQuery: "디자인", searchAction: { _ in }, removeAction: { })
    }
}
