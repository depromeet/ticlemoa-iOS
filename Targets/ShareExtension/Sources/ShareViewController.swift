//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by Yongwoo Marco on 2022/11/11.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
    private let modalSheet: UIView = {
        let uiView: UIView = UIView()
        uiView.backgroundColor = .white
        uiView.clipsToBounds = true
        uiView.layer.cornerRadius = 20
        return uiView
    }()
    private let panButton: UIView = {
        let uiView: UIView = UIView()
        uiView.backgroundColor = .gray
        uiView.clipsToBounds = true
        uiView.layer.cornerRadius = 3.5
        return uiView
    }()
    private let titleLabel: UILabel = {
        let uiLabel: UILabel = UILabel()
        uiLabel.text = "티클모아에 저장하기"
        uiLabel.font = .systemFont(ofSize: 16)
        uiLabel.textColor = .black
        return uiLabel
    }()
    private let scrollView: UIScrollView = {
        let uiScrollView: UIScrollView = UIScrollView()
        return uiScrollView
    }()
    private let newTagAddingButton: UIView = {
        let uiView: UIView = UIView()
        uiView.layer.borderWidth = 0.5
        uiView.layer.borderColor = #colorLiteral(red: 0.8470588326, green: 0.8470588326, blue: 0.8470588326, alpha: 1)
        return uiView
    }()
    private let newTagAddingImageView: UIImageView = {
        let uiImageView: UIImageView = UIImageView()
        uiImageView.image = UIImage(systemName: "plus")
        uiImageView.tintColor = .black
        uiImageView.contentMode = .scaleAspectFill
        return uiImageView
    }()
    private let newTagAddingLabel: UILabel = {
        let uiLabel: UILabel = UILabel()
        uiLabel.text = "새 태그 만들기"
        uiLabel.font = .systemFont(ofSize: 16)
        uiLabel.textColor = .black
        return uiLabel
    }()
    private let saveButton: UIButton = {
        let uiButton: UIButton = UIButton()
        uiButton.backgroundColor = #colorLiteral(red: 0.1999999881, green: 0.1999999881, blue: 0.1999999881, alpha: 1)
        uiButton.setTitle("저장", for: .normal)
        uiButton.setTitleColor(UIColor.white, for: .normal)
        return uiButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    private func configureView() {
        self.view.backgroundColor = .clear
        
        self.view.addSubview(self.modalSheet)
        self.modalSheet.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.modalSheet.topAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.modalSheet.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.modalSheet.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.modalSheet.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        self.modalSheet.addSubview(self.panButton)
        self.panButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.panButton.topAnchor.constraint(equalTo: self.modalSheet.topAnchor, constant: 7),
            self.panButton.centerXAnchor.constraint(equalTo: self.modalSheet.centerXAnchor),
            self.panButton.widthAnchor.constraint(equalToConstant: 50),
            self.panButton.heightAnchor.constraint(equalToConstant: 7)
        ])
        
        self.modalSheet.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.panButton.bottomAnchor, constant: 19),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.modalSheet.centerXAnchor)
        ])
        
        self.modalSheet.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.titleLabel.topAnchor, constant: 16),
            self.scrollView.leadingAnchor.constraint(equalTo: self.modalSheet.leadingAnchor, constant: 16),
            self.scrollView.trailingAnchor.constraint(equalTo: self.modalSheet.trailingAnchor, constant: 16)
        ])
        
        self.modalSheet.addSubview(self.newTagAddingButton)
        self.newTagAddingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.newTagAddingButton.topAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: 16),
            self.newTagAddingButton.leadingAnchor.constraint(equalTo: self.modalSheet.leadingAnchor, constant: 35),
            self.newTagAddingButton.trailingAnchor.constraint(equalTo: self.modalSheet.trailingAnchor, constant: -35),
            self.newTagAddingButton.heightAnchor.constraint(equalToConstant: 58)
        ])
        
        self.newTagAddingButton.addSubview(self.newTagAddingImageView)
        self.newTagAddingImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.newTagAddingImageView.centerYAnchor.constraint(equalTo: self.newTagAddingButton.centerYAnchor),
            self.newTagAddingImageView.leadingAnchor.constraint(equalTo: self.newTagAddingButton.leadingAnchor, constant: 24),
            self.newTagAddingImageView.widthAnchor.constraint(equalToConstant: 16),
            self.newTagAddingImageView.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        self.newTagAddingButton.addSubview(self.newTagAddingLabel)
        self.newTagAddingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.newTagAddingLabel.centerYAnchor.constraint(equalTo: self.newTagAddingButton.centerYAnchor),
            self.newTagAddingLabel.leadingAnchor.constraint(equalTo: self.newTagAddingImageView.trailingAnchor, constant: 8)
        ])
        
        self.modalSheet.addSubview(self.saveButton)
        self.saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.saveButton.topAnchor.constraint(equalTo: self.newTagAddingButton.bottomAnchor, constant: 20),
            self.saveButton.leadingAnchor.constraint(equalTo: self.modalSheet.leadingAnchor),
            self.saveButton.trailingAnchor.constraint(equalTo: self.modalSheet.trailingAnchor),
            self.saveButton.bottomAnchor.constraint(equalTo: self.modalSheet.bottomAnchor),
            self.saveButton.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
}
