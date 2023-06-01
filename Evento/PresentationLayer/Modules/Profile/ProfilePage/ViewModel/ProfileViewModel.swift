//
//  ProfileViewModel.swift
//  Evento
//
//  Created by RAmrayev on 28.05.2023.
//

import Foundation
import SwiftUI
import Combine

final class ProfileViewModel: ObservableObject{
    
    private let apiManager: ProfileApiManagerProtocol
    private let eventApiManager: EventsApiManagerProtocol
    @Published var user : UserModel?
    @Published var myevents: [EventItemModel] = []
    private var cancellables = Set<AnyCancellable>()
    
    init(apiManager: ProfileApiManagerProtocol, eventApiManager: EventsApiManagerProtocol){
        self.apiManager = apiManager
        self.eventApiManager = eventApiManager
        self.getMyEvents()
        self.getMyProfile()
        
    }

    func getSubscribers(){
    
    }
    
    func getMyProfile() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.getMyProfile().sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print("something wrong \(error)")
                    }
                },
                receiveValue: { [weak self] model in
                    self?.user = model
            
                }
            ).store(in: &self.cancellables)
        }
    }
    //
    private func getMyEvents() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
//            self.eventApiManager.getMyEvents().sink(
            self.eventApiManager.getMyEvents().sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                },
                receiveValue: { [weak self] model in
                    self?.myevents = model.events
                }
            ).store(in: &self.cancellables)
        }
    }
    //
    func uploadImage(image:UIImage) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiManager.uploadProfileImage(image: image, hasImage: ((self.user?.imageLink.isEmpty) == nil)).sink(
                receiveCompletion: { [weak self] completion in
                    if case let .failure(error) = completion {
                        print(error)
                    }
                },
                receiveValue: {_ in
                    print("Image has been uploaded!")
                }
            ).store(in: &self.cancellables)
        }
    }
}

struct ProfileImageView: View {
    @State private var selectedImage: UIImage?
    @ObservedObject var viewModel: ProfileViewModel
    @State var showImagePicker = false
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if ((viewModel.user?.imageLink.isEmpty) != nil){
                AsyncImage(
                    url: URL(string: (viewModel.user!.imageLink)),
                    content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(CustLinearGradient, lineWidth: 3))
                    },
                    placeholder: {
                        Image("person_circle")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(CustLinearGradient, lineWidth: 3))
                    }
                )
            }
            Button(action: {
                showImagePicker = true
            }) {
                ZStack {
                    CustLinearGradient
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                    Image("camera")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                }
                
            }
            .padding(2)
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage, viewModel: viewModel)
        }
        .padding()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @ObservedObject var viewModel: ProfileViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                parent.selectedImage = selectedImage
                parent.viewModel.uploadImage(image: selectedImage)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        // No need to update the view controller
    }
    
}
