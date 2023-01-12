//
//  ProfileSettingView.swift
//  Ticlemoa
//
//  Created by Shin Jae Ung on 2022/12/02.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI
import Combine
import PhotosUI

struct ProfileSettingView: View {
    @ObservedObject var viewModel: ProfileSettingViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: ProfileSettingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Group {
                if let path = viewModel.profileImageURL?.path, let uiImage = UIImage(contentsOfFile: path) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                } else {
                    DefaultProfileView()
                }
            }
            .frame(width: 59, height: 59)
            .padding(.top, 24)
            .overlay {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "gearshape.circle.fill")
                            .resizable()
                            .foregroundColor(.gray)
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .background {
                                Circle()
                                    .foregroundColor(.white)
                                    .frame(width: 22, height: 22)
                            }
                        }
                    }
            }
            .onTapGesture {
                viewModel.profileImageTouched()
            }
            
            VStack(spacing: 0) {
                HStack {
                    Text("닉네임")
                        .foregroundColor(.grey4)
                        .font(.system(size: 14))
                    Spacer()
                }
                .padding(.bottom, 12)
                TextField("닉네임을 입력해주세요.", text: $viewModel.nickname)
                    .padding(.bottom, 8)
                    .onChange(of: viewModel.nickname.count) { _ in
                        viewModel.nicknameTextfieldChanged()
                    }
                Divider()
                    .padding(.bottom, 8.8)
                HStack {
                    Spacer()
                    Text("\(viewModel.nickname.count)/10")
                        .foregroundColor(.grey4)
                        .font(.system(size: 14))
                }
            }
            .padding(20)
            
            Spacer()
        }
        .confirmationDialog("프로필 사진 설정", isPresented: $viewModel.isConfirmationDialogOpen, titleVisibility: .visible) {
            Button("앨범에서 사진 선택") {
                viewModel.selectPhotoInAlbumButtonTouched()
            }
            Button("기본 이미지로 변경") {
                viewModel.resetImage()
            }
            Button("취소", role: .cancel) { Void() }
        }
        .sheet(isPresented: $viewModel.isImagePickerOpen) {
            ImagePicker(viewModel: viewModel)
        }
        .ticlemoaNavigationBar(title: "프로필 설정", image: "arrow") {
            Button("완료") {
                viewModel.saveButtonTouched()
            }
            .foregroundColor(viewModel.isSavable ? .ticlemoaPrimary : .black)
        }
        .onChange(of: viewModel.isPresented) { newValue in
            if !newValue {
                dismiss()
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    private weak var viewModel: ProfileSettingViewModel?
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: ProfileSettingViewModel) {
        self.viewModel = viewModel
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self, viewModel: viewModel)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        weak var viewModel: ProfileSettingViewModel?

        init(_ parent: ImagePicker, viewModel: ProfileSettingViewModel?) {
            self.parent = parent
            self.viewModel = viewModel
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                viewModel?.updateProfileImage(fromUrl: url)
            }
            parent.dismiss()
        }
    }
}
