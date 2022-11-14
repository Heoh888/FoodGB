//
//  ImagePicker.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 20.10.2022.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    // MARK: - Properties
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var mode
    
    // MARK: - Functions
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    // MARK: - Coordinator
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else { return }
            self.parent.image = image
            self.parent.mode.wrappedValue.dismiss()
        }
    }
}
