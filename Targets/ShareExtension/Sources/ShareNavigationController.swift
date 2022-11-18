//
//  ShareNavigationController.swift
//  ShareExtension
//
//  Created by Shin Jae Ung on 2022/11/13.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import UIKit

@objc(CustomShareNavigationController)
class CustomShareNavigationController: UINavigationController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setViewControllers([ShareViewController()], animated: false)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
