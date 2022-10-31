//
//  UpdateProfilleView.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 19.10.2022.
//

import SwiftUI
import Kingfisher

struct UpdateProfilleView: View {
    
    // MARK: - Properties
    @Binding var user: User
    
    @State var name: String
    @State var phone = ""
    @State var address = ""
    @State var urlImage: String?
    @State var userImage: Image?
    @State var imagePickerPresented = false
    @State private var selectedImage: UIImage?
    
    @Binding var change: Bool
    
    @ObservedObject var viewModel: ProfileViewModel
    
    // MARK: - Views
    var body: some View {
        
        VStack {
            HStack {
                VStack {
                    profileImage()
                    
                    Button(action: { imagePickerPresented.toggle()}, label: {
                        Text("change")
                            .font(.system(size: 18, weight: .semibold))
                            .fontWeight(.light)
                            .foregroundColor(Color("MainColor"))
                            .padding(.bottom)
                    }).sheet(isPresented: $imagePickerPresented, onDismiss: loadImage, content: {
                        ImagePicker(image: $selectedImage)
                    })
                }
            }
            .padding(.top, 50)
        
            
            CustomTextField(text: $name, label: "Name")
            
            CustomTextField(text: $phone, label: "Phone")
            
            CustomTextField(text: $address, label: "Address")
            
            Spacer()
            
            Button {
                // TO:DO - Если имени нет...
                if name == "" {
                    name = user.userName
                } else {
                    viewModel.updateUser(userName: name, phone: phone, address: address, image: selectedImage ?? nil)
//                    if let image = selectedImage {
//                        viewModel.updateUser(userName: name, phone: phone, address: address, image: image) { url in
//                            user.profileImageUrl = url
//                        }
//                    } else {
//                        viewModel.updateUser(userName: name, phone: phone, address: address)
//                    }
                    user.userName = name
                    user.phone = phone
                    user.address = address
                    change.toggle()
                }
            } label: {
                Text("Update")
                    .font(.system(size: 17, weight: .semibold))
                    .fontWeight(.bold)
                    .frame(width: 314, height: 70)
                    .background(Color("MainColor"))
                    .foregroundColor(Color.white)
                    .cornerRadius(30)
                    .padding(.top)
                    .padding(.bottom, 50.0)
            }
        }
        .padding(.horizontal, 30.0)
        .keyboardAdaptive()
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    // MARK: - ViewBuilder
    @ViewBuilder
    func profileImage() -> some View {
        if urlImage == nil {
            if userImage == nil {
                Image("userImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 135)
            } else if let image = userImage {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 135)
                    .clipped()
                    .cornerRadius(20)
                    .padding([.top, .leading])
            }
        }  else  {
            if userImage == nil {
                KFImage(URL(string: urlImage!))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 135)
                    .clipped()
                    .cornerRadius(20)
                    .padding([.top, .leading])
            } else if let image = userImage {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 135)
                    .clipped()
                    .cornerRadius(20)
                    .padding([.top, .leading])
            }
        }
    }
}

// MARK: - Extensions
extension UpdateProfilleView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        userImage = Image(uiImage: selectedImage)
    }
}
