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
    case community
    
    var textItem: Text {
        switch self {
        case .home: return Text("홈")
        case .community: return Text("모아모아")
        }
    }
    
    var imageItem: Image {
        switch self {
        case .home: return Image("home")
        case .community: return Image("community")
        }
    }
}
