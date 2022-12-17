//
//  HomeView.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/11/28.
//

import SwiftUI

let tagHeight = 32

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State var isFolding = false;
    @State var isPushSearchView = false
    
    var body: some View {
        NavigationView {
            mainBody
                .toolbar(content: {
                    // 네비게이션 제목
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        // TODO: 이미지로 변경 필요
                        Text("TICLEMOA")
                            .pretendFont(.title3)
                    }
                    
                    // 종모양 & 마이프로필
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        NavigationLink(
                            destination: AlarmView(),
                            label: {
                                // TODO: 이미지 에셋 추가 시, 등록
                                //                                Image("alarm")
                                Image(systemName: "bell.badge")
                                    .symbolRenderingMode(.palette)
                                    .foregroundColor(.primary)
                                
                            })
                        NavigationLink(destination: ProfileView(), label: {
                            //                            Image("defaultProfile")
                            Image(systemName: "person.crop.circle")
                                .foregroundColor(Color.grey4)
                                .font(.title3)
                        })
                    }
                })
                .setupBackground()
        }
    }
}

// MARK: - SubView
private extension HomeView {
    @ViewBuilder
    var mainBody: some View {
        ZStack {
            tagListView
            
            VStack {
                Spacer()
                    .frame(maxHeight: 36)
                
                Spacer()
                    .frame(minHeight: 0, maxHeight: isFolding ? 35 : 250)
                HomeArticleList()
                    .padding(.top, 0)
                    .animation(.default)
                    .transition(.slide)
                    .environmentObject(viewModel)
                    .setupBackground()
                
                Spacer()
                Divider()
            }
        }
    }
    
    var tagListView: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 4){
                ForEach(Array(viewModel.rows.enumerated()), id:\.offset) { columnIndex, rows in
                    HStack(spacing: 10){
                        ForEach(Array(rows.enumerated()), id: \.offset){ rowIndex, row in
                            Button(action: {
                                HapticManager.instance.impact(style: .light)
                                viewModel.selectedTag = row
                            }, label: {
                                Text(row.name)
                            })
                                .pretendFont(.body2)
                                .foregroundColor(
//                                    columnIndex == 0 && rowIndex == 0
                                    viewModel.selectedTag == row
                                    ? Color.white
                                    : .grey4
                                )
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(
                                    ZStack(alignment: .trailing){
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(
                                                viewModel.selectedTag == row
                                                ? Color.ticlemoaBlack
                                                : Color.grey2
                                            )
                                    }
                                )
                        }
                    }
                    .frame(height: 28)
                    .padding(.vertical, 10)
                }
                
                Spacer()
            }
            .padding(.top, 24)
            .padding(.trailing, 65)
            
            VStack {
                HStack {
                    Spacer()
                    Rectangle()
                        .foregroundColor(Color.clear)
                        .frame(width: 24, height: 24)
                        .overlay {
                            Image(systemName: isFolding ? "chevron.down" : "chevron.up")
                                .animation(.linear)
                        }
                    Spacer()
                        .frame(maxWidth: 20)
                }
                .padding(.top, 20)
                Spacer()
            }
            .onTapGesture {
                withAnimation { isFolding.toggle() }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


// MARK: - Dummy
struct Tag: Identifiable, Hashable{
    var id = UUID().uuidString
    var name: String
    var size: CGFloat = 0
}

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.width
}

extension String{
    func getSize() -> CGFloat{
        let font = UIFont.systemFont(ofSize: 16)
        let attributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: attributes)
        return size.width
    }
}

class ContentViewModel: ObservableObject{
    
    @Published var rows: [[Tag]] = []
    @Published var tags: [Tag] = [
        Tag(name: "전체"),
        Tag(name: "IOS"),
        Tag(name: "IOS App Development"),
        Tag(name: "Swift"),
        Tag(name: "SwiftUI"),
        Tag(name: "XCode"),
        Tag(name: "IOS"),
        Tag(name: "IOS App Development"),
        Tag(name: "Swift"),
        Tag(name: "SwiftUI"),
        Tag(name: "XCode"),
        Tag(name: "IOS"),
        Tag(name: "IOS App Development"),
        Tag(name: "Swift"),
        Tag(name: "SwiftUI"),
        Tag(name: "XCode"),
        Tag(name: "IOS"),
        Tag(name: "IOS App Development"),
        Tag(name: "Swift"),
        Tag(name: "SwiftUI")
    ]
    @Published var tagText = ""
    
    @Published var selectedTag: Tag = Tag(name: "전체")
    
    init(){
        getTags()
    }
    
    func getTags(){
        var rows: [[Tag]] = []
        var currentRow: [Tag] = []
        
        var totalWidth: CGFloat = 0
        
        let screenWidth = UIScreen.screenWidth - 10
        //        let tagSpaceing: CGFloat = 14 /*Leading Padding*/ + 30 /*Trailing Padding*/ + 6 + 6 /*Leading & Trailing 6, 6 Spacing*/
        let tagSpaceing: CGFloat = 16 /*Leading Padding*/ + 16 /*Trailing Padding*/ + 6 + 6 /*Leading & Trailing 6, 6 Spacing*/
        
        if !tags.isEmpty{
            
            for index in 0..<tags.count{
                self.tags[index].size = tags[index].name.getSize()
            }
            
            tags.forEach{ tag in
                
                totalWidth += (tag.size + tagSpaceing)
                
                if totalWidth > screenWidth{
                    totalWidth = (tag.size + tagSpaceing)
                    rows.append(currentRow)
                    currentRow.removeAll()
                    currentRow.append(tag)
                }else{
                    currentRow.append(tag)
                }
            }
            
            if !currentRow.isEmpty{
                rows.append(currentRow)
                currentRow.removeAll()
            }
            
            self.rows = rows
        } else {
            self.rows = []
        }
        
    }
    
    
    func addTag(){
        tags.append(Tag(name: tagText))
        tagText = ""
        getTags()
    }
    
    func removeTag(by id: String){
        tags = tags.filter{ $0.id != id }
        getTags()
    }
}
