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
    @State var name: String
    @State var id: String
    @State var phone: String = ""
    @State var address: String = ""
    @State var userImage: Image
    @State var imagePickerPresented = false
    
    @Binding var user: User
    @Binding var change: Bool
    
    @ObservedObject var viewModel: ProfileViewModel
    
    // MARK: - Private properties
    @State private var selectedImage: UIImage?
    
    // MARK: - Views
    var body: some View {
        VStack {
            HStack {
                VStack {
                    userImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 135)
                        .clipped()
                        .cornerRadius(20)
                        .shadow(radius: 10, y: 5)
                        .padding(.top)
                    
                    Button(action: { imagePickerPresented.toggle()}, label: {
                        Text("change")
                            .font(.system(size: 18, weight: .semibold))
                            .fontWeight(.light)
                            .foregroundColor(Color("MainColor"))
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
                viewModel.updateUser(userName: name,
                                     phone: phone,
                                     address: address,
                                     image: selectedImage ?? nil,
                                     id: id)
                user.userName = name
                user.phone = phone
                user.address = address
                change.toggle()
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
}

// MARK: - Extensions
extension UpdateProfilleView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        userImage = Image(uiImage: selectedImage)
    }
}
