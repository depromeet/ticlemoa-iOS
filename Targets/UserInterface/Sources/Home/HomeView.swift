//
//  HomeView.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/11/28.
//

import SwiftUI

let tagHeight = 32

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @State var isFolding = true
    @State var isPushSearchView = false
    @Binding var isNotEmptyArticle: Bool
    
    var body: some View {
        NavigationView {
            mainBody
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
                    .frame(
                        minHeight: 0,
                        maxHeight: isFolding ? 80 : 35 + CGFloat((35 * viewModel.homeTags.count))
                    )
                HomeArticleList(isNotEmptyArticle: $isNotEmptyArticle)
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
                    }
                    .frame(height: 28)
                    .padding(.vertical, 10)
                }
                
                // 태그 관리
                Button(
                    action: {
                        // TODO: 태그관리 화면으로 이동
                        HapticManager.instance.impact(style: .light)
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
                        }
                    }
                )
                
//                Spacer()
            }
            .padding(.top, 24)
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
                .padding(.top, 30)
                Spacer()
            }
            .onTapGesture {
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
        return size.width
    }
}
