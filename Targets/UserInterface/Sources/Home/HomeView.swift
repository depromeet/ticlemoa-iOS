//
//  HomeView.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/11/28.
//

import SwiftUI

struct HomeView: View {
    
    init() {
//        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Pretendard-Bold", size: 14)!]
    }
    
    var body: some View {
        mainBody()
            .setupBackground()
    }
}

// MARK: - SubView
private extension HomeView {
    func mainBody() -> some View {
        VStack {
            Collapsible(
                label: {
                    Text("태그위치임")
                },
                content: {
                    HStack {
                        Text("짜란~")
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.secondary)
                }
            )
            .frame(maxWidth: .infinity)
            
            Spacer()
            
            HomeArticleList()
            
            Spacer()
            Divider()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


// MARK: - Dummy
struct Tag: Identifiable {
    var id = UUID()
    var name: String
}

let tag01 = Tag(name: "첫번째")
let tag02 = Tag(name: "두번째")
let tag03 = Tag(name: "세번째")
let tag04 = Tag(name: "네번째")
let tag05 = Tag(name: "5번째")
let tag06 = Tag(name: "6번째")
let tag07 = Tag(name: "7번째")

var allTags: [Tag] { [tag01, tag02, tag03, tag04, tag05, tag06, tag07]}
