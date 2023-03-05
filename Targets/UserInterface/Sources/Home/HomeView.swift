//
//  HomeView.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/11/28.
//

import SwiftUI

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
            /// TIcleMoa 로고
            HStack {
                Image("ticlemoa_logo")
                    .padding(.leading, 20)
                Spacer()
            }
            .frame(height: 56)
            
            VStack(spacing: 0) {
                ZStack {
                    if isFolding { /// 접혀 있을 경우 일직선 배열의 tagView
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 10) {
                                ForEach(viewModel.tags.indices, id: \.self) { index in
                                    Text(viewModel.tags[index].tagName)
                                        .foregroundColor(viewModel.tags[index].id == (viewModel.selectedTag?.id ?? 0) ? .grey1 : .grey4)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 12)
                                        .background(
                                            RoundedRectangle(cornerRadius: 4)
                                                .foregroundColor(viewModel.tags[index].id == (viewModel.selectedTag?.id ?? 0) ? .ticlemoaBlack : .grey2)
                                        )
                                        .onTapGesture {
                                            viewModel.selectedTag = viewModel.tags[index]
                                        }
                                }
                            }
                            .padding(.leading, 20)
                            .frame(height: 60)
                        }
                    } else { /// 펼쳐져 있을 경우 tagView
                        
                    }
                    /// folding button
                    ZStack {
                        HStack {
                            Spacer()
                            Rectangle().fill(
                                LinearGradient(gradient: Gradient(colors: [.clear, Color.grey1]), startPoint: .leading, endPoint: .trailing)
                            )
                            .frame(width: 102, height: 37)
                        }
                        
                        HStack {
                            Spacer()
                            Button {
                                withAnimation {
                                    isFolding.toggle()
                                }
                            } label: {
                                Group {
                                    isFolding ? Image("arrow.down") : Image("arrow.up")
                                }
                                .padding(.trailing, 26.1)
                            }
                        }
                    }
                }
                
                /// 잡햐쟈
                if !isFolding {
                    NavigationLink(isActive: $viewModel.isTagManagingViewPresented) {
                        TagManagingView()
                    } label: {
                        HStack(spacing: 6.82) {
                            Text("태그 관리")
                                .customFont(weight: 500, size: 12, lineHeight: 18, style: .medium)
                            Image("tagArrow.right")
                            Spacer()
                        }
                        .padding(.leading, 20)
                    }
                    .padding(.bottom, 20)
                }
                
                HomeArticleList(viewModel: .init(modelContainer: modelContainer))
                    .transition(.slide)
                    .environmentObject(viewModel)
                    .background(Color.grey1)
                
                Spacer()
                Divider()
            }
        }
        .onAppear {
            guard let selectedTag = viewModel.selectedTag else { return }
            /*
             홈화면에서 태그 관리 페이지로 이동 시,
             화면 전체에서 공용으로 사용하고 있는 articleModel의 itemPublisher에 전체 아티클들을 넣어줘야 하는데,
             다시 홈화면으로 올때, 클릭 되어 있던 태그의 아티클들을 articleModel의 itemPublisher에 넣어 UI에 표시해 주어야함
             */
            if selectedTag.tagName != "전체" {
                Task {
                    try? await modelContainer.articleModel.fetch(tagId: selectedTag.id)
                }
            }
        }
    }
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
