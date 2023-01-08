//
//  Tab.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/12/04.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

enum Tab {
    case home
    case myPage
    
    var textItem: Text {
        switch self {
        case .home: return Text("홈")
        case .myPage: return Text("마이페이지")
        }
    }
    
    var imageItem: Image {
        switch self {
        case .home: return Image("home")
        case .myPage: return Image("community")
        }
    }
}
