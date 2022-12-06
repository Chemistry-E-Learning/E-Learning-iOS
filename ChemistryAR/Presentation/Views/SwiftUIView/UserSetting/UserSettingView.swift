//
//  UserSettingView.swift
//  ChemistryAR
//
//  Created by NhatMinh on 06/12/2022.
//

import SwiftUI

struct UserViewEntity: Codable {
    var username: String
    var fullName: String
    var email: String
    var phoneNumber: String
    var academicLevel: Int
    var gender: Gender

    enum Gender: String, Codable  {
        case male
        case female
        case other
    }

    static var `default` = UserViewEntity(
        username: AppConstant.NoContent,
        fullName: AppConstant.NoContent,
        email: AppConstant.NoContent,
        phoneNumber: AppConstant.NoContent,
        academicLevel: 0,
        gender: .other
    )
}


struct UserSettingView: View {
    @StateObject private var viewModel = UserSettingViewModel()
    @Binding var isPushToUserSettingView: Bool
    @State private var isShowImagePicker = false
    @State private var genderSelected = UserViewEntity.Gender.other
    @State private var isEditing = false
    @State private var level = "0"
    @State private var inputImage: UIImage?
    @State private var image: Image = Image("avatar")

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 40) {
                navigationBar
                makeAvatarView()
                    .disabled(!isEditing)
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 12) {
                        makeProfileCell(
                            item: ("person.fill", "Username"),
                            value: $viewModel.user.username
                        )
                        makeProfileCell(
                            item: ("person.fill", "Full Name"),
                            value: $viewModel.user.fullName
                        )
                        makeProfileCell(
                            item: ("envelope.fill", "Email"),
                            value: $viewModel.user.email
                        )
                        makeProfileCell(
                            item: ("phone.fill", "Phone Number"),
                            value: $viewModel.user.phoneNumber
                        )
                        makeProfileCell(
                            item: ("book.fill", "Academic Level"),
                            value: $level,
                            isNumber: true
                        )
                        makeGenderCell()
                        makeButtonGroupView(geo: geo)
                            .padding(.top, 40)
                    }
                    .disabled(!isEditing)
                    .padding(.horizontal, 24)
                }
                .onChange(of: genderSelected, perform: { newValue in
                    viewModel.user.gender = genderSelected
                })
                .onChange(of: level, perform: { newValue in
                    viewModel.user.academicLevel = Int(level) ?? 0
                })
                .padding(.top, 12)
            }
            .sheet(isPresented: $isShowImagePicker, onDismiss: loadImage) {
                ImagePicker(selectedImage: $inputImage)
            }
            .onAppear {
                loadImageUserDefault()
                genderSelected = viewModel.user.gender
                level = "\(viewModel.user.academicLevel)"
            }
            .onTapGesture {
                hideKeyboard()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }
}

private extension UserSettingView {
    @ViewBuilder func makeButtonGroupView(geo: GeometryProxy) -> some View {
        if isEditing {
            HStack {
                Button {
                    saveImage()
                    UserDefaultsData.shared.username = viewModel.user.username
                    let user = UserViewEntity(
                        username: viewModel.user.username,
                        fullName: viewModel.user.fullName,
                        email: viewModel.user.email,
                        phoneNumber: viewModel.user.phoneNumber,
                        academicLevel: viewModel.user.academicLevel,
                        gender: viewModel.user.gender
                    )
                    do {
                        let encoder = JSONEncoder()
                        let data = try encoder.encode(user)
                        UserDefaults.standard.set(data, forKey: "user")
                    } catch {
                        print("Unable to Encode Note (\(error))")
                    }
                    isEditing = false
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(hex: 0x00A899))
                        .frame(width: geo.size.width * 0.43, height: 52)
                        .overlay(
                            Text(Localization.saveButtonTitle.localizedString)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                        )
                }
                Spacer()
                Button {
                    isEditing = false
                    viewModel.getUserProfile()
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.cFF6651)
                        .frame(width: geo.size.width * 0.43, height: 52)
                        .overlay(
                            Text(Localization.discardButtonTitle.localizedString)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                        )
                }
            }
        }
    }

    var navigationBar: some View {
        HStack {
            BackButton(
                action: {
                    isPushToUserSettingView = false
                },
                fontWeight: .medium,
                color: .black
            )
            .squareFrame(44)
            Spacer()
            Text(Localization.profileTitle.localizedString)
                .font(.system(size: 24, weight: .medium))
            Spacer()
            Button {
                isEditing = true
            } label: {
                Image(systemName: "pencil.circle.fill")
                    .foregroundColor(.black.opacity(0.9))
                    .font(.system(size: 28, weight: .medium))
            }
            .squareFrame(44)
            .padding(.trailing, 8)
        }
        .padding(.horizontal, 8)
    }

    func makeAvatarView() -> some View {
        image
            .resizable()
            .scaledToFill()
            .squareFrame(120)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.cFFC42C, lineWidth: 3)
                    .padding(-4)
            )
            .overlay(
                Circle()
                    .fill(Color.white)
                    .squareFrame(44)
                    .offset(x: -1, y: 11)
                ,alignment: .bottomTrailing
            )
            .overlay(
                Button(action: {
                    isShowImagePicker = true
                }, label: {
                    Circle()
                        .fill(Color.cFFC42C)
                        .squareFrame(36)
                        .overlay(
                            Image(systemName: "camera")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.black)
                        )
                        .offset(x: -4, y: 8)
                })
                ,alignment: .bottomTrailing
            )
    }

    func makeProfileCell(item: (String, String), value: Binding<String>, isNumber: Bool = false) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: item.0)
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.black.opacity(0.5))
                .padding(.top, 6)
                .padding(.trailing, 12)
                .squareFrame(44)
            VStack(alignment: .leading, spacing: 4) {
                Text(item.1)
                    .font(.system(size: 16))
                    .foregroundColor(.black.opacity(0.6))
                    .padding(.top, 8)
                TextField("Enter Your \(item.1)", text: value)
                    .if(isNumber, transform: { item in
                        item.keyboardType(.numberPad)
                    })
                    .font(.system(size: 20))
                    .foregroundColor(.black.opacity(0.9))
                    .frame(height: 28)
                    .padding(.bottom, 8)
                    .autocapitalization(.none)
            }
            Spacer()
        }
    }

    func makeGenderCell() -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "person.fill.and.arrow.left.and.arrow.right")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.black.opacity(0.5))
                .padding(.top, 6)
                .padding(.trailing, 12)
                .squareFrame(44)
            VStack(alignment: .leading, spacing: 16) {
                Text("Gender")
                    .font(.system(size: 16))
                    .foregroundColor(.black.opacity(0.6))
                    .padding(.top, 8)
                HStack(spacing: 24) {
                    makeRadioButton(gender: .male)
                    makeRadioButton(gender: .female)
                    makeRadioButton(gender: .other)
                }
                .padding(.leading, 4)
            }
            Spacer()
        }
    }

    func makeRadioButton(gender: UserViewEntity.Gender) -> some View {
        Button {
            genderSelected = gender
        } label: {
            HStack {
                Circle()
                    .fill(gender.rawValue == genderSelected.rawValue ? Color.cFFC42C : .clear)
                    .squareFrame(12)
                    .overlay(
                        Circle()
                            .stroke(Color.cFFC42C, lineWidth: 1.5)
                            .padding(-1.6)
                    )
                Text(gender.rawValue.capitalized)
                    .foregroundColor(.black.opacity(0.9))
                    .font(.system(size: 16))
            }
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }

    func saveImage() {
        guard let image = inputImage, let data = image.jpegData(compressionQuality: 0.5) else { return }
        let encoded = try! PropertyListEncoder().encode(data)
        UserDefaults.standard.set(encoded, forKey: "avatar")
    }

    func loadImageUserDefault() {
        guard let data = UserDefaults.standard.data(forKey: "avatar") else { return }
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
        if let uiImage = UIImage(data: decoded) {
            image = Image(uiImage: uiImage)
        }
    }
}

struct UserSettingView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingView(isPushToUserSettingView: .constant(false))
    }
}
