//
//  ShareNavigationController.swift
//  ShareExtension
//
//  Created by Shin Jae Ung on 2022/11/13.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI
import UserInterface

@objc(ShareNavigationController)
final class ShareNavigationController: UINavigationController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        let hostingController = UIHostingController(rootView: BottomSheet(content: {
            TagSelectingListView(tags: .constant(TagSelectingListViewModel.dummy))
        }))
        hostingController.view.backgroundColor = .clear
        self.setViewControllers([hostingController], animated: false)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
