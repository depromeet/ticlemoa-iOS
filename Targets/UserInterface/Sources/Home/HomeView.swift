//
//  HomeView.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/11/28.
//

import SwiftUI

let tagHeight = 32

struct HomeView: View {
    @EnvironmentObject var modelContainer: ModelContainer
    @StateObject var viewModel: HomeViewModel
    @State var isFolding = true
    @State var isPushSearchView = false
    
    var body: some View {
        mainBody
            .background(Color.grey1)
            .setupBackground()
    }
}

// MARK: - SubView
private extension HomeView {
    @ViewBuilder
    var mainBody: some View {
        VStack(spacing: 0) {
            HStack {
                Image("ticlemoa_logo")
                    .padding(.leading, 20)
                Spacer()
            }
            .frame(height: 56)
            
            ZStack {
                tagListView
                
                VStack {
                    Spacer()
                        .frame(
                            minHeight: 0,
                            maxHeight: isFolding ? 58 : 58 + CGFloat((45 * viewModel.homeRows.count))
                        )
                    HomeArticleList(viewModel: .init(modelContainer: modelContainer))
                        .padding(.top, 0)
                        .animation(.default)
                        .transition(.slide)
                        .environmentObject(viewModel)
                        .background(Color.grey1)
                    
                    Spacer()
                    Divider()
                }
            }
        }
        .onAppear {
            guard let selectedTag = viewModel.selectedTag else { return }
            /*
             홈화면에서 태그 관리 페이지로 이동 시,
             화면 전체에서 공용으로 사용하고 있는 articleModel의 itemPublisher에 전체 아티클들을 넣어줘야 하는데,
             다시 홈화면으로 올때, 클릭 되어 있던 태그의 아티클들을 articleModel의 itemPublisher에 넣어 UI에 표시해 주어야함
             */
            if selectedTag.tag.tagName != "전체" {
                Task {
                    do {
                        try await modelContainer.articleModel.fetch(tagId: selectedTag.tag.id)
                        print(viewModel.homeTags)
                    } catch {
                        print(error.localizedDescription) // TODO: 실패 토스트 메세지 띄우기
                    }
                }
            }
        }
    }
    
    var tagListView: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4){
                ForEach(Array(viewModel.homeRows.enumerated()), id:\.offset) { columnIndex, rows in
                    
                    HStack(spacing: 10) {
                        ForEach(Array(rows.enumerated()), id: \.offset){ rowIndex, row in
                            Button(
                                action: {
                                    HapticManager.instance.impact(style: .light)
                                    viewModel.selectedTag = row
                                }, label: {
                                    Text(row.tag.tagName)
                                }
                            )
                            .pretendFont(.body2)
                            .foregroundColor(
                                // columnIndex == 0 && rowIndex == 0
                                viewModel.tagButtonColor(by: row)
                            )
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                ZStack(alignment: .trailing){
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(viewModel.tagBackgroundColor(by: row))
                                }
                            )
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .frame(height: 28)
                    .padding(.vertical, 10)
                }
                NavigationLink(
                    destination: {
                        TagManagingView()
                    },
                    label: {
                        
                        HStack {
                            Text("태그 관리")
                                .foregroundColor(.ticlemoaBlack)
                                .customFont(
                                    weight: 400,
                                    size: 12,
                                    lineHeight: 18,
                                    style: .medium
                                )
                                .padding(.top, 11)
                            
                            Image("left_chevron")
                                .padding(.top, 10)
                        }.opacity(0)
                    }
                )
                
//                Spacer()
            }
            .padding(.top, 5)
            .padding(.trailing, 65)
            
            // Fold - UnFold Button
            VStack {
                HStack {
                    Spacer()
                    Rectangle()
                        .foregroundColor(Color.clear)
                        .frame(width: 24, height: 24)
                        .overlay {
                            Image(systemName: isFolding ? "chevron.down" : "chevron.up")
                                .frame(width: 32, height: 32)
                                .animation(.linear)
                        }
                    Spacer()
                        .frame(maxWidth: 20)
                }
                .padding(.top, 18)
                Spacer()
            }
            .onTapGesture {
                guard viewModel.homeRows.count > 1 else { return }
                withAnimation { isFolding.toggle() }
            }
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(
//            viewModel: HomeViewModel(
//                modelContainer: ModelContainer(
//                    articleModel: MockArticleModel(),
//                    tagModel: MockTagModel(),
//                    loginModel: MockLoginModel()
//                )
//            )
//        )
//    }
//}

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.width
}

extension String{
    func getSize() -> CGFloat{
        let font = UIFont.systemFont(ofSize: 16)
        let attributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: attributes)
        print("DEBUG: \(size.width)")
        // 24 : leading trailing default padding value
        return size.width + 24
    }
}
