//
//  HapticsManager.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/12/17.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import UIKit

class HapticManager {
    static let instance = HapticManager()
    private init() {}
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
