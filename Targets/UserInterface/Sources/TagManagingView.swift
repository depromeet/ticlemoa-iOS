//
//  TagManagingView.swift
//  UserInterface
//
//  Created by Shin Jae Ung on 2022/11/19.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

struct TagManagingView: View {
    @ObservedObject private var viewModel: TagManagingViewModel
    
    init(tags: [String]) {
        self.viewModel = TagManagingViewModel(tags: tags)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.tags, id: \.self) { name in
                    TagView(name: name, isNew: true)
                }
            }
        }
        .navigationTitle("태그관리")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "plus")
            }
        }
    }
}

fileprivate class TagManagingViewModel: ObservableObject {
    @Published var tags: [String]
    
    init(tags: [String]) {
        self.tags = tags
    }
}

fileprivate struct TagView: View {
    let name: String
    let isNew: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text(name)
                if isNew {
                    Text("N")
                        .foregroundColor(.gray)
                }
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding()
            Divider()
                .foregroundColor(.gray)
        }
    }
}

struct TagManageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NavigationLink("눌러") {
                TagManagingView(tags: "ABCDEFGHIJKLMN".map{ String($0) })
            }
        }
    }
}

