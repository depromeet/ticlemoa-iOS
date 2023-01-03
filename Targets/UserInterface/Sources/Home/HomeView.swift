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
    @State var isFolding = false
    @State var isPushSearchView = false
    
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
                            Button(
                                action: {
                                    HapticManager.instance.impact(style: .light)
                                    viewModel.selectedTag = row
                                }, label: {
                                    Text(row.name)
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
