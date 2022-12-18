//
//  PresentationDetent+.swift
//  UserInterface
//
//  Created by 김용우 on 2022/12/11.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

@available(iOS 16.0, *)
extension PresentationDetent {
    
    static func heightByCell(height: CGFloat, count: Int) -> Self {
        var modalHeight: CGFloat = 500
        switch count {
            case 0, 1:  modalHeight -= height * 3
            case 2:     modalHeight -= height * 2
            case 3:     modalHeight -= height
            default:    break
        }
        return .height(modalHeight)
    }
}
